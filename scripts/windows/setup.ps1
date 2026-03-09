Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Convert-ToWslPath {
  param([Parameter(Mandatory = $true)][string]$WindowsPath)

  $full = (Resolve-Path $WindowsPath).Path
  if ($full -match '^([A-Za-z]):\\(.*)$') {
    $drive = $Matches[1].ToLower()
    $rest = $Matches[2] -replace '\\', '/'
    return "/mnt/$drive/$rest"
  }

  throw "无法将路径转换为 WSL 路径：$full"
}

if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
  throw "未找到 wsl.exe。请先安装/启用 WSL2：wsl --install"
}

$RepoRootWin = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$RepoRootWsl = Convert-ToWslPath $RepoRootWin

Write-Host "[setup.ps1] repo(win): $($RepoRootWin.Path)"
Write-Host "[setup.ps1] repo(wsl): $RepoRootWsl"

wsl.exe -e bash -lc "cd '$RepoRootWsl' && bash scripts/windows/wsl/setup.sh"
