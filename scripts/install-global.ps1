# Install cursor-agent-policy globally on this machine (all Cursor windows/projects).
# Mechanism: %USERPROFILE%\.cursor\rules\cursor-agent-policy.mdc (alwaysApply: true)
# Canonical copy: %USERPROFILE%\.cursor\AGENTS.md
# Source of truth: policy/cursor-agent-policy.mdc (+ AGENTS.md body kept in sync)
# Lives in policy/ (not rules/) so the plugin does not auto-register a second Customize rule.
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
$ruleSource = Join-Path $repoRoot "policy\cursor-agent-policy.mdc"
if (-not (Test-Path $ruleSource)) {
    throw "Source rule not found: $ruleSource"
}

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

if (Test-Path $ruleFile) {
    $backup = "$ruleFile.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Warning "Existing rule backed up to $backup"
    Copy-Item -Force $ruleFile $backup
}

Copy-Item -Force $ruleSource $ruleFile
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
Write-Host "Re-run after git pull when policy/cursor-agent-policy.mdc or AGENTS.md change."
Write-Host "The plugin does not register this rule (avoids duplicate in Customize -> Rules)."
Write-Host "Optional one-repo overlay: .\scripts\install-project.ps1 -ProjectPath <product>"
