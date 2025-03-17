:: GitHub Release Download
:: Author: @usrunsudo

@Echo Off

set /p var="Enter GitHub URL (User/Project): "

echo Date: %date% %time% >jq_github_url.txt
echo GitHub API Options - Assets: browser download url - Release: latest >>jq_github_url.txt
echo GitHub URL (User/Project): %var% >>jq_github_url.txt
echo. >>jq_github_url.txt
curl -s https://api.github.com/repos/%var%/releases/latest | jq-win64.exe -r ".assets[].browser_download_url" >>jq_github_url.txt
echo. >>jq_github_url.txt
echo Copy this URLs to Download Manager >>jq_github_url.txt

echo.
echo File created jq_github_url.txt
echo.
type jq_github_url.txt

echo.
pause
