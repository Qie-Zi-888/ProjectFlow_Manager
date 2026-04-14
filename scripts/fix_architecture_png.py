# -*- coding: utf-8 -*-
"""
Patch the original architecture PNG in place (crop black edges, redraw fixed text).
Calibrated for:
  c__Users_..._image-7dcddb6f-3be3-453b-96e9-aa464255d6c1.png
Run: py -3 scripts/fix_architecture_png.py
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

SRC = Path(
    r"C:\Users\qiezi\.cursor\projects\e-Project-ProjectFlow-Manager\assets"
    r"\c__Users_qiezi_AppData_Roaming_Cursor_User_workspaceStorage_empty-window_images_image-7dcddb6f-3be3-453b-96e9-aa464255d6c1.png"
)
OUT = Path(__file__).resolve().parent.parent / "docs" / "system-architecture-fixed.png"

TITLE = "\u7cfb\u7edf\u67b6\u6784\u8bbe\u8ba1\u56fe"
LAYER_PRESENTATION = "\u5c55\u793a\u5c42"
LAYER_BUSINESS = "\u4e1a\u52a1\u903b\u8f91\u5c42"
LAYER_DAL = "\u6570\u636e\u8bbf\u95ee\u5c42"
LAYER_STORAGE = "\u6570\u636e\u5b58\u50a8\u5c42"
REDIS_CAPTION = "\u7f13\u5b58\u6a21\u5757"
DEPLOY_TITLE = "docker \u5bb9\u5668\u5316\u90e8\u7f72"

HDR_BAR = (197, 227, 246)


def trim_black_edges(im: Image.Image) -> Image.Image:
    rgb = im.convert("RGB")
    w, h = rgb.size
    px = rgb.load()
    lum = 200
    edge_frac = 0.82

    def row_dark(y: int) -> bool:
        return sum(1 for x in range(w) if sum(px[x, y]) < lum) / w > edge_frac

    def col_dark(x: int) -> bool:
        return sum(1 for y in range(h) if sum(px[x, y]) < lum) / h > edge_frac

    t, b, l, r = 0, h - 1, 0, w - 1
    while t < h and row_dark(t):
        t += 1
    while b > t and row_dark(b):
        b -= 1
    while l < w and col_dark(l):
        l += 1
    while r > l and col_dark(r):
        r -= 1
    return rgb.crop((l, t, r + 1, b + 1))


def load_font(size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    for p in (
        r"C:\Windows\Fonts\msyh.ttc",
        r"C:\Windows\Fonts\msyhbd.ttc",
        r"C:\Windows\Fonts\simhei.ttf",
    ):
        if os.path.isfile(p):
            try:
                return ImageFont.truetype(p, size=size)
            except OSError:
                continue
    return ImageFont.load_default()


def draw_centered_in_band(
    draw: ImageDraw.ImageDraw,
    x0: int,
    x1: int,
    y0: int,
    y1: int,
    text: str,
    font: ImageFont.ImageFont,
    fill: tuple[int, int, int],
) -> None:
    bbox = draw.textbbox((0, 0), text, font=font)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    cx = (x0 + x1) / 2
    cy = (y0 + y1) / 2
    draw.text((cx - tw / 2, cy - th / 2), text, font=font, fill=fill)


def median_color(px, w: int, h: int, x0: int, y0: int, x1: int, y1: int) -> tuple[int, int, int]:
    rs, gs, bs = [], [], []
    for y in range(max(0, y0), min(h, y1)):
        for x in range(max(0, x0), min(w, x1)):
            r, g, b = px[x, y]
            rs.append(r)
            gs.append(g)
            bs.append(b)
    if not rs:
        return (255, 255, 255)
    rs.sort()
    gs.sort()
    bs.sort()
    m = len(rs) // 2
    return (rs[m], gs[m], bs[m])


def main() -> int:
    if not SRC.is_file():
        print("Source not found:", SRC, file=sys.stderr)
        return 1

    base = trim_black_edges(Image.open(SRC))
    w, h = base.size
    px = base.load()
    draw = ImageDraw.Draw(base)

    xl, xr = int(w * 0.10), int(w * 0.90)

    font_title = max(18, int(h * 0.034))
    font_hdr = max(15, int(h * 0.022))
    font_sub = max(12, int(h * 0.017))
    ft_title = load_font(font_title)
    ft_hdr = load_font(font_hdr)
    ft_sub = load_font(font_sub)

    hdr_text = (13, 58, 92)

    # 1) Main title (fix garbled ??? etc.)
    draw.rectangle([int(w * 0.06), 8, int(w * 0.94), int(h * 0.085)], fill=(255, 255, 255))
    draw_centered_in_band(draw, xl, xr, 12, int(h * 0.078), TITLE, ft_title, (26, 26, 26))

    # 2) Layer header bars (calibrated on 514x771 crop)
    bands = [
        (117, 146, LAYER_PRESENTATION),
        (186, 208, LAYER_BUSINESS),
        (380, 412, LAYER_DAL),
        (480, 518, LAYER_STORAGE),
    ]
    for y0, y1, label in bands:
        draw.rectangle([xl, y0, xr, y1], fill=HDR_BAR)
        draw_centered_in_band(draw, xl, xr, y0, y1, label, ft_hdr, hdr_text)

    # 3) Redis sub-caption -> ??????? (right card body)
    ry0, ry1 = int(h * 0.72), int(h * 0.76)
    rx0, rx1 = int(w * 0.48), int(w * 0.93)
    fill_r = median_color(px, w, h, rx0, ry0, rx1, ry1)
    draw.rectangle([rx0, ry0, rx1, ry1], fill=fill_r)
    draw_centered_in_band(draw, rx0, rx1, ry0, ry1, REDIS_CAPTION, ft_sub, (51, 51, 51))

    # 4) Docker deploy title row (cover garbled dodoer / doAxer; band sits just above inner tiles)
    dy0, dy1 = 646, 676
    fill_d = median_color(px, w, h, xl, max(0, dy0 - 8), xr, dy0)
    draw.rectangle([xl, dy0, xr, dy1], fill=fill_d)
    draw_centered_in_band(draw, xl, xr, dy0, dy1, DEPLOY_TITLE, ft_hdr, (92, 48, 18))

    # 5) Remove ghosting under the three docker tiles (match local background)
    for x0p, x1p in [(int(w * 0.06), int(w * 0.34)), (int(w * 0.35), int(w * 0.64)), (int(w * 0.65), int(w * 0.94))]:
        gy0, gy1 = int(h * 0.88), int(h * 0.965)
        fill_g = median_color(px, w, h, x0p, gy0, x1p, gy1)
        draw.rectangle([x0p, gy0, x1p, gy1], fill=fill_g)

    OUT.parent.mkdir(parents=True, exist_ok=True)
    base.save(OUT, "PNG", optimize=True)
    print("Wrote", OUT, "size", base.size)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
