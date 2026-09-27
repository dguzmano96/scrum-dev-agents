# Install cursor-agent-policy into one product repo (local overlay).
# Optional product-repo copy. The GitHub plugin already loads the same rule.
#
# Writes:
#   {ProjectPath}/AGENTS.md
#   {ProjectPath}/.cursor/rules/cursor-agent-policy.mdc  (alwaysApply: true)
#
# Usage (from plugin repo root):
#   Set-ExecutionPolicy -Scope Process Bypass
#   .\scripts\install-project.ps1 -ProjectPath "C:\path\to\your\product"
#   .\scripts\install-project.ps1 -ProjectPath "C:\path\to\your\product" -Symlink

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,

    [switch]$Symlink
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path $PSScriptRoot -Parent
$source = Join-Path $repoRoot "AGENTS.md"
$ruleSource = Join-Path $repoRoot "rules\cursor-agent-policy.mdc"

if (-not (Test-Path $source)) {
    throw "Source AGENTS.md not found. Run from the scrum-dev-agents plugin repo."
}
if (-not (Test-Path $ruleSource)) {
    throw "Source rule not found: $ruleSource"
}

if (-not (Test-Path $ProjectPath)) {
    throw "Project path does not exist: $ProjectPath"
}

function Backup-IfExists([string]$Path) {
    if (-not (Test-Path $Path)) { return }
    $item = Get-Item $Path
    if ($item.LinkType -eq "SymbolicLink") {
        Remove-Item $Path -Force
        return
    }
    $backup = "$Path.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Warning "Existing file backed up to $backup"
    Move-Item -Force $Path $backup
}

$destAgents = Join-Path $ProjectPath "AGENTS.md"
Backup-IfExists $destAgents

$canonical = Join-Path $env:USERPROFILE ".cursor\AGENTS.md"
if ($Symlink) {
    try {
        if (-not (Test-Path $canonical)) {
            $cursorDir = Split-Path $canonical -Parent
            if (-not (Test-Path $cursorDir)) {
                New-Item -ItemType Directory -Path $cursorDir | Out-Null
            }
            Copy-Item -Force $source $canonical
        }
        New-Item -ItemType SymbolicLink -Path $destAgents -Target $canonical | Out-Null
        Write-Host "Symlinked $destAgents -> $canonical"
    } catch {
        Write-Warning "Symlink failed (enable Developer Mode or run as admin). Falling back to copy."
        Copy-Item -Force $source $destAgents
        Write-Host "Copied policy to $destAgents"
    }
} else {
    Copy-Item -Force $source $destAgents
    Write-Host "Copied policy to $destAgents"
}

$projectRulesDir = Join-Path $ProjectPath ".cursor\rules"
if (-not (Test-Path $projectRulesDir)) {
    New-Item -ItemType Directory -Path $projectRulesDir -Force | Out-Null
}
$ruleFile = Join-Path $projectRulesDir "cursor-agent-policy.mdc"
Backup-IfExists $ruleFile

Copy-Item -Force $ruleSource $ruleFile
Write-Host "Project rule:   $ruleFile"

Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open this product as a workspace in Cursor (File > Open Folder)."
Write-Host "  2. The GitHub plugin already loads this rule. Skip this overlay unless the product repo should commit its own copy."
Write-Host "  3. Keep a single Always Apply cursor-agent-policy (plugin, or this project file, not both)."
Write-Host "  4. Start a NEW Multitask chat (type /multitask or use Multitask Mode)."
Write-Host "  5. Confirm the agent asks for budget / low / mid / high / cursor / emergencia mode."
Write-Host "  6. Optional: commit AGENTS.md and .cursor/rules/cursor-agent-policy.mdc in the product repo."
