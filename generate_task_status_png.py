"""
生成任务状态流转图 PNG 文件
使用 PlantUML 生成高质量的状态流转图
"""
import subprocess
import os

def generate_plantuml_png():
    """使用 PlantUML 生成 PNG 图片"""
    
    puml_file = 'E:/Project/ProjectFlow_Manager/docs/task-status-flowchart.puml'
    output_dir = 'E:/Project/ProjectFlow_Manager/docs'
    
    if not os.path.exists(puml_file):
        print(f"错误: 找不到文件 {puml_file}")
        return False
    
    try:
        # 方法1: 使用 PlantUML jar 包
        plantuml_jar = os.environ.get('PLANTUML_JAR', 'plantuml.jar')
        
        if os.path.exists(plantuml_jar):
            cmd = ['java', '-jar', plantuml_jar, '-tpng', '-o', output_dir, puml_file]
            print(f"执行命令: {' '.join(cmd)}")
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                print("✓ PlantUML PNG 图片生成成功!")
                print(f"输出目录: {output_dir}")
                return True
            else:
                print(f"PlantUML 执行失败: {result.stderr}")
        else:
            print("未找到 PlantUML jar 包，尝试其他方法...")
        
        # 方法2: 使用 plantuml Python 包
        try:
            import plantuml
            print("使用 plantuml Python 包生成...")
            
            with open(puml_file, 'r', encoding='utf-8') as f:
                puml_content = f.read()
            
            # 连接到 PlantUML 服务器或使用本地安装
            plantuml_connector = plantuml.PlantUML()
            output = plantuml_connector.processes(puml_content)
            
            output_path = os.path.join(output_dir, 'task-status-flowchart.png')
            with open(output_path, 'wb') as f:
                f.write(output)
            
            print(f"✓ PNG 图片已生成: {output_path}")
            return True
            
        except ImportError:
            print("未安装 plantuml Python 包")
        except Exception as e:
            print(f"plantuml 包生成失败: {e}")
        
        print("\n建议的安装方法:")
        print("1. 下载 PlantUML jar: https://plantuml.com/download")
        print("2. 设置环境变量: PLANTUML_JAR=C:/path/to/plantuml.jar")
        print("3. 或在线生成: http://www.plantuml.com/plantuml/")
        
        return False
        
    except Exception as e:
        print(f"生成图片时出错: {e}")
        import traceback
        traceback.print_exc()
        return False

def generate_mermaid_html():
    """生成包含 Mermaid 图表的 HTML 文件"""
    
    html_content = """<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>任务状态流转图</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
    <style>
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            margin: 40px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 1200px;
            margin: 0 auto;
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .mermaid {
            text-align: center;
            margin: 30px 0;
        }
        .info {
            background-color: #e3f2fd;
            padding: 15px;
            border-left: 4px solid #2196f3;
            margin-top: 20px;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .status-pending { background-color: #e1f5ff; }
        .status-inprogress { background-color: #fff9e1; }
        .status-completed { background-color: #e8f5e9; }
        .status-suspended { background-color: #fce4ec; }
    </style>
</head>
<body>
    <div class="container">
        <h1>任务状态流转图 (Task Status Flow Diagram)</h1>
        
        <div class="mermaid">
graph TB
    S0["待办/未开始<br/>状态值: 0"]
    S1["进行中<br/>状态值: 1"]
    S2["已完成<br/>状态值: 2"]
    S3["暂停<br/>状态值: 3"]

    S0 -->|开始执行| S1
    S0 -->|暂时搁置| S3
    
    S1 -->|完成任务| S2
    S1 -->|暂时停止| S3
    S1 -->|回退任务| S0
    
    S3 -->|恢复执行| S1
    S3 -->|重新安排| S0
    
    S2 -->|重新打开| S1

    style S0 fill:#e1f5ff,stroke:#01579b,stroke-width:2px
    style S1 fill:#fff9e1,stroke:#f57f17,stroke-width:2px
    style S2 fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px
    style S3 fill:#fce4ec,stroke:#880e4f,stroke-width:2px
        </div>
        
        <h2>状态流转矩阵</h2>
        <table>
            <thead>
                <tr>
                    <th>从 \\ 到</th>
                    <th class="status-pending">待办(0)</th>
                    <th class="status-inprogress">进行中(1)</th>
                    <th class="status-completed">已完成(2)</th>
                    <th class="status-suspended">暂停(3)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="status-pending"><b>待办(0)</b></td>
                    <td>✗</td>
                    <td>✓</td>
                    <td>✗</td>
                    <td>✓</td>
                </tr>
                <tr>
                    <td class="status-inprogress"><b>进行中(1)</b></td>
                    <td>✓</td>
                    <td>✗</td>
                    <td>✓</td>
                    <td>✓</td>
                </tr>
                <tr>
                    <td class="status-completed"><b>已完成(2)</b></td>
                    <td>✗</td>
                    <td>✓</td>
                    <td>✗</td>
                    <td>✗</td>
                </tr>
                <tr>
                    <td class="status-suspended"><b>暂停(3)</b></td>
                    <td>✓</td>
                    <td>✓</td>
                    <td>✗</td>
                    <td>✗</td>
                </tr>
            </tbody>
        </table>
        
        <div class="info">
            <strong>说明:</strong> ✓ 表示允许的流转，✗ 表示不允许的流转
        </div>
    </div>
    
    <script>
        mermaid.initialize({ 
            startOnLoad: true,
            theme: 'default',
            flowchart: {
                useMaxWidth: true,
                htmlLabels: true
            }
        });
    </script>
</body>
</html>
"""
    
    output_path = 'E:/Project/ProjectFlow_Manager/docs/task-status-flowchart.html'
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html_content)
    
    print(f"✓ HTML 文件已生成: {output_path}")
    print("  可以在浏览器中打开此文件查看状态流转图")
    print("  使用浏览器的打印功能可以导出为 PDF 或截图保存为 PNG")
    
    return True

if __name__ == '__main__':
    print("=" * 60)
    print("任务状态流转图生成工具")
    print("=" * 60)
    print()
    
    # 生成 HTML 文件（推荐）
    print("1. 生成 HTML 文件（包含 Mermaid 图表）...")
    generate_mermaid_html()
    print()
    
    # 尝试生成 PNG
    print("2. 尝试生成 PNG 文件...")
    if generate_plantuml_png():
        print("✓ PNG 文件生成成功!")
    else:
        print("⚠ PNG 文件生成失败，请使用 HTML 文件方式")
    
    print()
    print("=" * 60)
    print("生成完成！")
    print("=" * 60)
