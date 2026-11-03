@echo off
rem Double-click to register the "Convert to PDF" item for .svg files.
setlocal
set "HERE=%~dp0"
if not exist "%HERE%svg2pdf.vbs" (
  echo [x] svg2pdf.vbs not found next to this script.
  pause
  exit /b 1
)
wscript.exe "%HERE%svg2pdf.vbs" -install
if errorlevel 1 (
  echo [x] Registration failed.
  pause
  exit /b 1
)
exit /b 0
