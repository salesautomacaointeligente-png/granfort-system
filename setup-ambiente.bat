@echo off
chcp 65001 >nul
echo ============================================
echo   SETUP — Claude Code + Vercel + Granfort
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
echo Instalando Git (se necessario)...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    winget install Git.Git --silent --accept-package-agreements --accept-source-agreements
)

echo.
echo ============================================
echo   BAIXANDO PROJETO GRANFORT
echo ============================================
if not exist "C:\projetos" mkdir "C:\projetos"
cd /d "C:\projetos"

if exist "granfort-system" (
    echo Projeto ja existe, atualizando...
    cd granfort-system
    git pull
) else (
    echo Baixando projeto do GitHub...
    git clone https://github.com/salesautomacaointeligente-png/granfort-system.git
    cd granfort-system
)

echo.
echo ============================================
echo   CONFIGURAR API KEY DO CLAUDE
echo ============================================
echo.
echo Abrindo pagina para pegar sua API Key...
start https://console.anthropic.com/settings/keys
echo.
echo 1. Faca login e clique em "Create Key"
echo 2. Copie a chave (comeca com sk-ant-...)
echo 3. Cole aqui abaixo e pressione ENTER:
echo.
set /p CLAUDE_KEY="Cole sua API Key: "
setx ANTHROPIC_API_KEY "%CLAUDE_KEY%" >nul
set ANTHROPIC_API_KEY=%CLAUDE_KEY%
echo API Key salva!

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
echo Projeto em: C:\projetos\granfort-system
echo Sistema online: https://granfort-system.vercel.app
echo.
echo Para abrir o Claude:  claude
echo Para deployar:        vercel --prod
echo.
pause
