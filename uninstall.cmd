@echo off
rem Double-click to remove the "Convert to PDF" item.
setlocal
set "HERE=%~dp0"
if not exist "%HERE%svg2pdf.vbs" (
  echo [x] svg2pdf.vbs not found next to this script.
  pause
  exit /b 1
)
wscript.exe "%HERE%svg2pdf.vbs" -uninstall
exit /b 0
