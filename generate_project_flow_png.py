from PIL import Image, ImageDraw, ImageFont


WIDTH, HEIGHT = 900, 1700
BG = (242, 242, 242)
BORDER = (51, 51, 51)
TEXT = (20, 20, 20)


def load_font(size: int):
    candidates = [
        r"C:\Windows\Fonts\msyh.ttc",
        r"C:\Windows\Fonts\msyh.ttf",
        r"C:\Windows\Fonts\simhei.ttf",
    ]
    for p in candidates:
        try:
            return ImageFont.truetype(p, size)
        except OSError:
            continue
    return ImageFont.load_default()


font = load_font(34)
font_small = load_font(30)

img = Image.new("RGB", (WIDTH, HEIGHT), BG)
draw = ImageDraw.Draw(img)

cx = WIDTH // 2
y = 40


def text_centered(x, y, w, h, s, f):
    bbox = draw.textbbox((0, 0), s, font=f)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    draw.text((x + (w - tw) / 2, y + (h - th) / 2 - 2), s, fill=TEXT, font=f)


def rounded_box(text, w=520, h=92, x=None, y_pos=None, radius=26, f=None):
    if x is None:
        x = cx - w // 2
    if y_pos is None:
        raise ValueError("y_pos is required")
    draw.rounded_rectangle((x, y_pos, x + w, y_pos + h), radius=radius, outline=BORDER, width=3, fill=BG)
    text_centered(x, y_pos, w, h, text, f or font)
    return (x + w // 2, y_pos + h, x + w // 2, y_pos)


def arrow(x1, y1, x2, y2):
    draw.line((x1, y1, x2, y2), fill=BORDER, width=3)
    if x1 == x2:
        draw.polygon([(x2 - 10, y2 - 18), (x2 + 10, y2 - 18), (x2, y2)], fill=BORDER)
    elif y1 == y2:
        if x2 > x1:
            draw.polygon([(x2 - 18, y2 - 10), (x2 - 18, y2 + 10), (x2, y2)], fill=BORDER)
        else:
            draw.polygon([(x2 + 18, y2 - 10), (x2 + 18, y2 + 10), (x2, y2)], fill=BORDER)


def diamond(text, w=240, h=110, x=None, y_pos=None):
    if x is None:
        x = cx - w // 2
    if y_pos is None:
        raise ValueError("y_pos is required")
    p1 = (x + w // 2, y_pos)
    p2 = (x + w, y_pos + h // 2)
    p3 = (x + w // 2, y_pos + h)
    p4 = (x, y_pos + h // 2)
    draw.polygon([p1, p2, p3, p4], outline=BORDER, fill=BG, width=3)
    text_centered(x, y_pos, w, h, text, font_small)
    return (p3[0], p3[1], p1[0], p1[1], x, y_pos, w, h)


def connect_from(prev_bottom, next_top, gap=26):
    px, py = prev_bottom
    nx, ny = next_top
    arrow(px, py, nx, ny - gap // 2)
    arrow(nx, ny - gap // 2, nx, ny)


# Flow nodes
n1 = rounded_box("��ʼ", w=130, h=78, y_pos=y, radius=32, f=font_small)
y += 130
n2 = rounded_box("������Ŀ����ģ��", w=340, h=92, y_pos=y)
y += 128
n3 = rounded_box("��д��Ŀ������Ϣ(����/����/ʱ��/���ȼ�)", w=760, h=100, y_pos=y, f=font_small)
y += 136
n4 = rounded_box("������༭��Ŀ", w=360, h=92, y_pos=y)
y += 128
n5 = rounded_box("������Ŀ��Ա���ɫ", w=420, h=92, y_pos=y)
y += 128
n6 = rounded_box("���������������ȼ�", w=460, h=92, y_pos=y)
y += 128
n7 = rounded_box("������Ŀ����", w=340, h=92, y_pos=y)
y += 124
d = diamond("�����쳣", w=230, h=108, y_pos=y)
y += 146
n8 = rounded_box("������Դ������ƻ�", w=430, h=92, y_pos=y)
y += 136
n9 = rounded_box("������Ŀ״̬", w=300, h=92, y_pos=y)
y += 132
n10 = rounded_box("����", w=130, h=78, y_pos=y, radius=32, f=font_small)

# Main vertical arrows
for a, b in [(n1, n2), (n2, n3), (n3, n4), (n4, n5), (n5, n6), (n6, n7)]:
    arrow(a[0], a[1], b[2], b[3] - 20)
    arrow(b[2], b[3] - 20, b[2], b[3])

arrow(n7[0], n7[1], d[0], d[3] - 20)
arrow(d[0], d[3] - 20, d[0], d[3])

# Yes branch down
arrow(d[0], d[1], n8[2], n8[3] - 20)
arrow(n8[2], n8[3] - 20, n8[2], n8[3])
draw.text((d[6] + d[4] + 6, d[5] + d[7] // 2 - 36), "��", fill=TEXT, font=font_small)

# No branch right then down to save status
right_x = d[4] + d[6] + 120
mid_y = d[5] + d[7] // 2
arrow(d[4] + d[6], mid_y, right_x, mid_y)
arrow(right_x, mid_y, right_x, n9[3] + 40)
arrow(right_x, n9[3] + 40, n9[2], n9[3] + 40)
arrow(n9[2], n9[3] + 40, n9[2], n9[3])

# n8 to n9 and n9 to n10
arrow(n8[0], n8[1], n9[2], n9[3] - 20)
arrow(n9[2], n9[3] - 20, n9[2], n9[3])
arrow(n9[0], n9[1], n10[2], n10[3] - 20)
arrow(n10[2], n10[3] - 20, n10[2], n10[3])

img.save("project-flow-no-hollow-square.png")
print("Generated: project-flow-no-hollow-square.png")
