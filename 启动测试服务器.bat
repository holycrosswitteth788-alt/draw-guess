@echo off
chcp 65001 >nul
title 你画我猜 - 本地测试服务器
cd /d "%~dp0"

set PORT=8090

echo ============================================
echo   你画我猜 1V1 - 本地测试
echo ============================================
echo.

where python >nul 2>nul
if %errorlevel%==0 (
    echo [启动中] 使用 Python 启动服务，端口 %PORT%
    echo.
    echo   浏览器地址:  http://127.0.0.1:%PORT%
    echo.
    echo   测试方法: 开两个浏览器窗口都访问上面地址
    echo             A 窗口点"创建房间"，等房间号出现后点"复制房间号"
    echo             B 窗口粘贴房间号，点"加入房间"
    echo.
    echo   关闭本窗口即停止服务
    echo ============================================
    echo.
    start "" http://127.0.0.1:%PORT%
    python -m http.server %PORT% --bind 127.0.0.1
    goto :eof
)

where node >nul 2>nul
if %errorlevel%==0 (
    echo [启动中] 使用 Node 启动服务，端口 %PORT%
    echo   浏览器地址:  http://127.0.0.1:%PORT%
    start "" http://127.0.0.1:%PORT%
    npx --yes http-server -p %PORT% -c-1
    goto :eof
)

echo [错误] 未找到 Python 或 Node.js
echo 请先安装其中之一，或直接用 Chrome 打开 index.html
pause
