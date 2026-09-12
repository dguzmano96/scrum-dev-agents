# Install cursor-agent-policy globally on this machine (all Cursor windows/projects).
# Mechanism: %USERPROFILE%\.cursor\rules\cursor-agent-policy.mdc (alwaysApply: true)
# Canonical copy: %USERPROFILE%\.cursor\AGENTS.md
# Source of truth: this plugin repo (scrum-dev-agents/AGENTS.md)
#
# Usage (from plugin repo root):
#   Set-ExecutionPolicy -Scope Process Bypass
#   .\scripts\install-global.ps1
#   powershell -ExecutionPolicy Bypass -File .\scripts\install-global.ps1
#   .\scripts\install-global.ps1 -SourcePath "C:\path\to\AGENTS.md"

param(
    [string]$SourcePath
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path $PSScriptRoot -Parent
if (-not $SourcePath) {
    $SourcePath = Join-Path $repoRoot "AGENTS.md"
}

if (-not (Test-Path $SourcePath)) {
    throw "Source AGENTS.md not found: $SourcePath"
}

$cursorDir = Join-Path $env:USERPROFILE ".cursor"
$rulesDir = Join-Path $cursorDir "rules"
$canonical = Join-Path $cursorDir "AGENTS.md"
$ruleFile = Join-Path $rulesDir "cursor-agent-policy.mdc"

foreach ($dir in @($cursorDir, $rulesDir)) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

Copy-Item -Force $SourcePath $canonical
Write-Host "Canonical copy: $canonical"

$agentsBody = Get-Content -Path $SourcePath -Raw -Encoding utf8

$frontmatter = @"
---
description: Cursor agent orchestration policy (Multitask) - low/mid/high/cursor models. Scrum = how; this rule = with what. User-facing language = first chat message.
alwaysApply: true
---

"@

if (Test-Path $ruleFile) {
    $backup = "$ruleFile.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Warning "Existing rule backed up to $backup"
    Copy-Item -Force $ruleFile $backup
}

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($ruleFile, $frontmatter + $agentsBody, $utf8NoBom)
Write-Host "Global rule:    $ruleFile"

Write-Host ""
Write-Host "Installed. Cursor loads machine-local user rules from:"
Write-Host "  $rulesDir"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open Customize -> Rules and confirm 'cursor-agent-policy' is listed (Always Apply)."
Write-Host "  2. Start a NEW Multitask chat (/multitask) in any window or project."
Write-Host "  3. The orchestrator should ask once for low / mid / high / cursor mode."
Write-Host "  4. Every Task must pass model from the matrix (Scrum does not pick slugs)."
Write-Host ""
Write-Host "Re-run this script after pulling plugin updates that change AGENTS.md."
Write-Host "Optional one-repo overlay: .\scripts\install-project.ps1 -ProjectPath <product>"
