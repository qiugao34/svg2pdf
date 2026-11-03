# SVG → PDF（Windows 右键菜单）

右键任意 `.svg` 文件，选「转换为 PDF」，同目录生成同名 `.pdf`。
**没有黑框、不用命令行、不用装 Python/Node**。

```
右键 test.svg → 显示更多选项 → 转换为 PDF
        ↓
    test.pdf（同目录，重名自动 test (1).pdf）
```

## 特性

- **无窗口**：用 `wscript.exe` 运行，全程不弹控制台
- **零依赖**：有 Edge 就能用（Windows 10/11 自带）；有 Inkscape 则自动优先用 Inkscape
- **不动原文件**：只读取 SVG，输出同名 PDF
- **重名自动编号**：`x.pdf` 存在就写 `x (1).pdf`
- **页面尺寸精确**：Edge 路径会用一层 HTML 指定纸张大小，不会套成 Letter 加白边
- **只写当前用户**：注册表写在 `HKCU`，不需要管理员权限

## 安装

### 方式 A：下载后双击（推荐）

1. 在本页右上角 **Code → Download ZIP**，解压到任意固定目录，例如
   `C:\Tools\svg2pdf\`（不要放在下载文件夹，会被清理）
2. 双击 `install.cmd`
3. 弹出「已注册」即可使用

### 方式 B：一行命令

在 PowerShell 里执行（会把脚本装到 `%LOCALAPPDATA%\svg2pdf`）：

```powershell
$d = "$env:LOCALAPPDATA\svg2pdf"
New-Item -ItemType Directory -Force $d | Out-Null
Invoke-WebRequest "https://raw.githubusercontent.com/OWNER/REPO/main/svg2pdf.vbs" -OutFile "$d\svg2pdf.vbs"
wscript.exe "$d\svg2pdf.vbs" -install
```

> 把 `OWNER/REPO` 换成实际仓库地址。

### 方式 C：Git 克隆

```powershell
git clone https://github.com/OWNER/REPO.git C:\Tools\svg2pdf
cd C:\Tools\svg2pdf
wscript.exe svg2pdf.vbs -install
```

## 没有 Inkscape 怎么办

**不需要装**。脚本会自动改用 **Edge 无头打印**（Windows 10/11 自带 Edge），效果一样是矢量 PDF，而且更快（约 0.6 秒）。

判断当前用的是哪个转换器：

| 电脑情况 | 用的转换器 |
|---|---|
| 装了 Inkscape | Inkscape（约 2 秒，兼容性最好） |
| 没装 Inkscape、有 Edge/Chrome | Edge 无头打印（约 0.6 秒） |
| 两者都没有 | 弹窗提示，不会静默失败 |

想强制走 Edge 试试：

```powershell
wscript.exe svg2pdf.vbs -edge "D:\某文件.svg"
```

### 如果你确实想装 Inkscape（可选）

它兼容性最好，适合用了滤镜、图案、Inkscape 专有特性的 SVG。

**方式一：winget（推荐）**

```powershell
winget install --id Inkscape.Inkscape -e
```

**方式二：官网安装包**

1. 打开 <https://inkscape.org/release/>
2. 选 **Windows** → 下载 **64-bit installer**（`.msi` 或 `.exe`）
3. 一路下一步，保持默认安装路径（`C:\Program Files\Inkscape`）
4. 装完不用重启，直接右键 SVG 就会自动优先用 Inkscape

**验证是否装好**

```powershell
Test-Path "C:\Program Files\Inkscape\bin\inkscape.exe"   # 应输出 True
```

脚本会按顺序查找：`Program Files` → `Program Files (x86)` → `%LOCALAPPDATA%\Programs` → `PATH`，所以便携版放进 PATH 也能识别。

## 使用

| 场景 | 做法 |
|---|---|
| 转一个 | 右键 → 转换为 PDF |
| 批量转 | 选中多个 → 右键 → 转换为 PDF（逐个执行） |
| 命令行 | `wscript.exe svg2pdf.vbs "D:\a\b.svg"` |
| 强制 Edge | `wscript.exe svg2pdf.vbs -edge "D:\a\b.svg"` |
| 安静模式（批处理） | `powershell -File svg2pdf.ps1 "D:\a\b.svg" -NoBox` |

## 卸载

```powershell
wscript.exe svg2pdf.vbs -uninstall
```

或双击 `uninstall.cmd`。只删注册表项，不删你的 PDF。

## 常见问题

**右键菜单里没有「转换为 PDF」？**
Windows 11 把第三方菜单收进了二级菜单：右键 → **显示更多选项**（或按 `Shift + F10`）。

**转换失败 / 提示拒绝访问？**
通常是目标文件夹不允许写入（同步盘、受保护目录、安全软件拦截）。
先试把 SVG 复制到桌面或 `D:\` 根目录再转；确认是文件夹问题后，在安全软件里放行 `wscript.exe`。

**中文文件名会有问题吗？**
不会。脚本全程用 Unicode 处理路径。

**输出的 PDF 页面尺寸不对？**
Edge 路径会读 SVG 的 `width`/`height`（支持 `px/pt/mm/cm/in`），没有就用 `viewBox`，都没有才退回 1024×768。Inkscape 路径直接按 SVG 尺寸输出。

**`.vbs` 是什么？安全吗？**
VBScript，Windows 自带的脚本语言，纯文本可读，用记事本就能打开审阅。本脚本只做三件事：找 Inkscape/Edge、调用它们转换、写一条 HKCU 注册表项。

## 文件说明

| 文件 | 作用 |
|---|---|
| `svg2pdf.vbs` | 主脚本（转换 + 注册/注销菜单），UTF-16LE 编码 |
| `svg2pdf.ps1` | 可选：命令行版本，支持 `-NoBox` 静默模式 |
| `install.cmd` | 双击注册 |
| `uninstall.cmd` | 双击取消注册 |

## 原理

```
Explorer 右键
  └─ wscript.exe svg2pdf.vbs "文件.svg"        （GUI 宿主，无控制台窗口）
       ├─ 找 Inkscape → 隐藏窗口运行 → 等它写完
       └─ 没有 Inkscape → 生成指定纸张大小的临时 HTML
                        → Edge --headless --print-to-pdf
```

## License

MIT
