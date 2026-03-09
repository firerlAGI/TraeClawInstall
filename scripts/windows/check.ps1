param(
  [switch]$Dashboard
)

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

function Quote-BashSingle {
  param([Parameter(Mandatory = $true)][string]$Value)

  $escaped = $Value -replace "'", "'\"'\"'"
  return "'" + $escaped + "'"
}

if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
  throw "未找到 wsl.exe。请先安装/启用 WSL2：wsl --install"
}

$RepoRootWin = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$RepoRootWsl = Convert-ToWslPath $RepoRootWin
$RepoRootWslQuoted = Quote-BashSingle $RepoRootWsl

Write-Host "[check.ps1] repo(wsl): $RepoRootWsl"
Write-Host "[check.ps1] dashboard: $Dashboard"

$command = "cd $RepoRootWslQuoted && bash scripts/windows/wsl/check.sh"
if ($Dashboard) { $command += " --dashboard" }

wsl.exe -e bash -lc $command
