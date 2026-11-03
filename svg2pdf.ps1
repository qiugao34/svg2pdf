param(
    [Parameter(Position = 0)][string]$Path,
    [switch]$Install,
    [switch]$Uninstall,
    [switch]$NoBox
)

# SVG -> PDF via Inkscape, plus Explorer context menu (per-user, no admin).
#   -Install    register the "Convert to PDF" menu item
#   -Uninstall  remove it
#   <path>      convert one SVG (Explorer calls it this way)
#   -NoBox      print errors instead of showing a message box

$ErrorActionPreference = 'Stop'
$Key = 'HKCU:\Software\Classes\SystemFileAssociations\.svg\shell\SvgToPdf'
$LogPath = Join-Path $PSScriptRoot 'last-error.txt'

function Fail([string]$Message) {
    try { Set-Content -LiteralPath $LogPath -Value $Message -Encoding UTF8 } catch { }
    if ($NoBox) { Write-Host $Message; exit 1 }
    try {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show(
            $Message, 'SVG to PDF',
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error) | Out-Null
    } catch { Write-Host $Message }
    exit 1
}

function Find-Inkscape {
    $list = @(
        (Join-Path $env:ProgramFiles 'Inkscape\bin\inkscape.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'Inkscape\bin\inkscape.exe'),
        (Join-Path $env:LOCALAPPDATA 'Programs\Inkscape\bin\inkscape.exe'))
    foreach ($p in $list) {
        if ($p -and (Test-Path -LiteralPath $p)) { return $p }
    }
    return $null
}

function Unique-Pdf([string]$SvgPath) {
    $dir = Split-Path -Parent $SvgPath
    $stem = [IO.Path]::GetFileNameWithoutExtension($SvgPath)
    $target = Join-Path $dir ($stem + '.pdf')
    $n = 1
    while (Test-Path -LiteralPath $target) {
        $target = Join-Path $dir ('{0} ({1}).pdf' -f $stem, $n)
        $n++
    }
    return $target
}

function Run-Inkscape([string]$Exe, [string]$Svg, [string]$Out) {
    # Launch hidden and wait for the file to appear.
    $proc = Start-Process -FilePath $Exe -ArgumentList @($Svg, ('--export-filename=' + $Out)) `
        -PassThru -WindowStyle Hidden -ErrorAction Stop
    if (-not $proc.WaitForExit(60000)) {
        try { $proc.Kill() } catch { }
    }
    return (Test-Path -LiteralPath $Out)
}

if ($Install) {
    $cmd = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "{0}" "%1"' -f $PSCommandPath
    New-Item -Path $Key -Force | Out-Null
    Set-Item -Path $Key -Value 'Convert to PDF'
    $icon = Find-Inkscape
    if ($icon) {
        New-ItemProperty -Path $Key -Name 'Icon' -Value $icon -PropertyType String -Force | Out-Null
    }
    New-Item -Path "$Key\command" -Force | Out-Null
    Set-Item -Path "$Key\command" -Value $cmd
    Write-Host '[ok] registered: right-click .svg -> Show more options -> Convert to PDF'
    Write-Host ('     script: ' + $PSCommandPath)
    exit 0
}

if ($Uninstall) {
    if (Test-Path $Key) {
        Remove-Item -Path $Key -Recurse -Force
        Write-Host '[ok] removed'
    } else {
        Write-Host '[i] not registered'
    }
    exit 0
}

if (-not $Path) { Fail 'No SVG file given.' }
if (-not (Test-Path -LiteralPath $Path)) { Fail ('File not found: ' + $Path) }

$svg = (Resolve-Path -LiteralPath $Path).Path
$target = Unique-Pdf $svg
$inkscape = Find-Inkscape
if (-not $inkscape) { Fail 'Inkscape not found. Install it from https://inkscape.org' }

$ok = Run-Inkscape $inkscape $svg $target
if (-not $ok) {
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ('svg2pdf-' + [guid]::NewGuid().ToString('N') + '.pdf')
    $ok = Run-Inkscape $inkscape $svg $tmp
    if ($ok) {
        try {
            Copy-Item -LiteralPath $tmp -Destination $target -Force
            Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue
            $ok = $true
        } catch {
            $ok = $false
        }
    }
}

if (-not $ok) {
    Fail ("Conversion failed.`nTarget: $target`nIf this folder blocks writes, try another folder or allow Inkscape in your security software.")
}
exit 0
