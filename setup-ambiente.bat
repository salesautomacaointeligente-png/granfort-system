@echo off
chcp 65001 >nul
echo ============================================
echo   SETUP — Claude Code + Vercel CLI
echo ============================================
echo.

:: Verifica Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Instalando Node.js...
    winget install OpenJS.NodeJS.LTS --silent --accept-package-agreements --accept-source-agreements
    echo.
    echo FECHE este terminal, abra um NOVO e rode este script de novo.
    pause
    exit /b
) else (
    echo Node.js OK:
    node --version
)

echo.
echo Instalando Claude Code...
call npm install -g @anthropic-ai/claude-code

echo.
echo Instalando Vercel CLI...
call npm install -g vercel

echo.
echo ============================================
echo   CONFIGURAR API KEY DO CLAUDE
echo ============================================
echo.
echo Abrindo a pagina para pegar sua API Key...
start https://console.anthropic.com/settings/keys
echo.
echo 1. Faca login na pagina que abriu no navegador
echo 2. Clique em "Create Key"
echo 3. Copie a chave (comeca com sk-ant-...)
echo 4. Cole aqui abaixo e pressione ENTER:
echo.
set /p CLAUDE_KEY="Cole sua API Key aqui: "

:: Salva a chave como variavel de ambiente permanente
setx ANTHROPIC_API_KEY "%CLAUDE_KEY%" >nul
set ANTHROPIC_API_KEY=%CLAUDE_KEY%

echo.
echo API Key configurada com sucesso!

echo.
echo ============================================
echo   AUTENTICAR NO VERCEL
echo ============================================
call vercel login

echo.
echo ============================================
echo   TUDO PRONTO!
echo ============================================
echo.
echo Para abrir o Claude Code: claude
echo Para deployar projetos:   vercel --prod
echo.
pause
