"""
生成任务状态流转图 - 简单版本
提供多种生成方式供选择
"""
import os
import webbrowser

def open_online_plantuml():
    """打开在线 PlantUML 编辑器"""
    
    # PlantUML 在线编辑器 URL
    url = "http://www.plantuml.com/plantuml/"
    
    print("=" * 70)
    print("方法1: 使用在线 PlantUML 编辑器（推荐）")
    print("=" * 70)
    print()
    print(f"正在打开浏览器: {url}")
    print()
    print("操作步骤:")
    print("1. 在打开的网页中，清空默认内容")
    print("2. 复制以下 PlantUML 代码并粘贴到网页中")
    print("3. 点击 'Submit' 按钮生成图片")
    print("4. 右键点击图片，选择 '保存图片为...' 保存为 PNG")
    print()
    print("-" * 70)
    
    # 读取 PlantUML 文件内容
    puml_file = 'E:/Project/ProjectFlow_Manager/docs/task-status-flowchart.puml'
    if os.path.exists(puml_file):
        with open(puml_file, 'r', encoding='utf-8') as f:
            content = f.read()
        print(content)
    else:
        print("错误: 找不到 PlantUML 文件")
        return
    
    print("-" * 70)
    print()
    
    # 打开浏览器
    webbrowser.open(url)
    
    print("浏览器已打开，请按照上述步骤操作。")
    print()

def create_simple_html():
    """创建简单的 HTML 预览页面"""
    
    html_content = """<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>任务状态流转图</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 1400px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 40px;
            font-size: 28px;
        }
        .diagram-container {
            background-color: #fafafa;
            padding: 30px;
            border-radius: 8px;
            margin: 30px 0;
            border: 2px solid #e0e0e0;
        }
        .mermaid {
            text-align: center;
        }
        .info-box {
            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
            padding: 20px;
            border-left: 5px solid #667eea;
            margin-top: 30px;
            border-radius: 6px;
        }
        .info-box h3 {
            margin-top: 0;
            color: #667eea;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: center;
            font-size: 14px;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f0f0f0;
        }
        .status-pending { 
            background-color: #e1f5ff !important;
            font-weight: bold;
        }
        .status-inprogress { 
            background-color: #fff9e1 !important;
            font-weight: bold;
        }
        .status-completed { 
            background-color: #e8f5e9 !important;
            font-weight: bold;
        }
        .status-suspended { 
            background-color: #fce4ec !important;
            font-weight: bold;
        }
        .check { color: #4caf50; font-size: 18px; }
        .cross { color: #f44336; font-size: 18px; }
        .download-btn {
            display: block;
            width: 200px;
            margin: 30px auto;
            padding: 12px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: transform 0.2s;
        }
        .download-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 任务状态流转图 (Task Status Flow Diagram)</h1>
        
        <div class="diagram-container">
            <div class="mermaid">
graph TB
    S0["📋 待办/未开始<br/>状态值: 0"]
    S1["⚙️ 进行中<br/>状态值: 1"]
    S2["✅ 已完成<br/>状态值: 2"]
    S3["⏸️ 暂停<br/>状态值: 3"]

    S0 -->|开始执行| S1
    S0 -->|暂时搁置| S3
    
    S1 -->|完成任务| S2
    S1 -->|暂时停止| S3
    S1 -->|回退任务| S0
    
    S3 -->|恢复执行| S1
    S3 -->|重新安排| S0
    
    S2 -->|重新打开| S1

    style S0 fill:#e1f5ff,stroke:#01579b,stroke-width:3px,color:#01579b
    style S1 fill:#fff9e1,stroke:#f57f17,stroke-width:3px,color:#f57f17
    style S2 fill:#e8f5e9,stroke:#1b5e20,stroke-width:3px,color:#1b5e20
    style S3 fill:#fce4ec,stroke:#880e4f,stroke-width:3px,color:#880e4f
            </div>
        </div>
        
        <h2 style="color: #667eea; margin-top: 40px;">📋 状态流转矩阵</h2>
        <table>
            <thead>
                <tr>
                    <th>从 \\ 到</th>
                    <th class="status-pending">📋 待办(0)</th>
                    <th class="status-inprogress">⚙️ 进行中(1)</th>
                    <th class="status-completed">✅ 已完成(2)</th>
                    <th class="status-suspended">⏸️ 暂停(3)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="status-pending">📋 待办(0)</td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="check">✓</span></td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="check">✓</span></td>
                </tr>
                <tr>
                    <td class="status-inprogress">⚙️ 进行中(1)</td>
                    <td><span class="check">✓</span></td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="check">✓</span></td>
                    <td><span class="check">✓</span></td>
                </tr>
                <tr>
                    <td class="status-completed">✅ 已完成(2)</td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="check">✓</span></td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="cross">✗</span></td>
                </tr>
                <tr>
                    <td class="status-suspended">⏸️ 暂停(3)</td>
                    <td><span class="check">✓</span></td>
                    <td><span class="check">✓</span></td>
                    <td><span class="cross">✗</span></td>
                    <td><span class="cross">✗</span></td>
                </tr>
            </tbody>
        </table>
        
        <div class="info-box">
            <h3>💡 说明</h3>
            <p><strong>✓</strong> 表示允许的流转 &nbsp;&nbsp; | &nbsp;&nbsp; <strong>✗</strong> 表示不允许的流转</p>
            <p style="margin-top: 10px;"><strong>提示：</strong>右键点击上方的状态流转图，选择"复制图片"或"保存图片"即可获取 PNG 格式的图片。</p>
        </div>
        
        <a href="#" class="download-btn" onclick="window.print(); return false;">
            🖨️ 打印/保存为 PDF
        </a>
    </div>
    
    <script>
        mermaid.initialize({ 
            startOnLoad: true,
            theme: 'default',
            flowchart: {
                useMaxWidth: true,
                htmlLabels: true,
                curve: 'basis'
            }
        });
    </script>
</body>
</html>
"""
    
    output_path = 'E:/Project/ProjectFlow_Manager/docs/task-status-flowchart.html'
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    print("=" * 70)
    print("方法2: 使用 HTML 预览页面（最简单）")
    print("=" * 70)
    print()
    print(f"HTML 文件已生成: {output_path}")
    print()
    print("操作步骤:")
    print("1. 双击打开生成的 HTML 文件")
    print("2. 在浏览器中查看精美的状态流转图")
    print("3. 右键点击图表，选择 '复制图片' 或 '保存图片'")
    print("4. 或者点击页面底部的 '打印' 按钮保存为 PDF")
    print()
    
    # 自动打开浏览器
    webbrowser.open('file://' + output_path)
    print("✓ 浏览器已自动打开 HTML 文件")
    print()

def main():
    print()
    print("╔" + "=" * 68 + "╗")
    print("║" + " " * 20 + "任务状态流转图生成工具" + " " * 25 + "║")
    print("╚" + "=" * 68 + "╝")
    print()
    
    print("请选择生成方式:")
    print()
    print("  1. 在线 PlantUML 编辑器（适合生成高质量 PNG）")
    print("  2. HTML 预览页面（最简单，可直接截图）")
    print()
    
    choice = input("请输入选项 (1 或 2，直接回车默认为 2): ").strip()
    
    if choice == '1':
        open_online_plantuml()
    else:
        create_simple_html()
    
    print()
    print("=" * 70)
    print("完成！")
    print("=" * 70)
    print()
    print("生成的文件位置:")
    print("  - PlantUML 源文件: E:\\Project\\ProjectFlow_Manager\\docs\\task-status-flowchart.puml")
    print("  - HTML 预览文件: E:\\Project\\ProjectFlow_Manager\\docs\\task-status-flowchart.html")
    print("  - Markdown 文档: E:\\Project\\ProjectFlow_Manager\\docs\\task-status-transition.md")
    print()
    print("论文使用建议:")
    print("  1. 如果使用 Word: 从 HTML 页面复制图片后粘贴到 Word")
    print("  2. 如果使用 LaTeX: 使用在线 PlantUML 生成 PNG 后插入")
    print("  3. 如果直接插入: 使用截图工具截取 HTML 页面中的图表")
    print()

if __name__ == '__main__':
    main()
