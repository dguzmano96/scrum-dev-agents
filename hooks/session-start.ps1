# sessionStart for Windows (PowerShell 5.1, included with Windows).
# Prints one JSON object on stdout. Exit 0 so the hook does not fall through.

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$root = Split-Path -Parent $PSScriptRoot
$check = Join-Path $root "scripts\price-freshness.ps1"

function ConvertTo-JsonString {
    param([string]$Value)
    if ($null -eq $Value) { return "" }
    return $Value.Replace('\', '\\').Replace('"', '\"').Replace("`r", "").Replace("`n", '\n')
}

function Write-HookJson {
    param([string]$Context)
    $escaped = ConvertTo-JsonString -Value $Context
    [Console]::Out.WriteLine(('{"additional_context":"' + $escaped + '"}'))
}

if (-not (Test-Path -LiteralPath $check)) {
    Write-HookJson "Price freshness check is missing at scripts/price-freshness.ps1. Do not assign or refresh models silently."
    exit 0
}

. $check
$result = Get-PriceFreshness
$code = $result.Code
$details = $result.Text

if ($code -eq 0) {
    Write-HookJson ""
    exit 0
}

$prefix = "Price table is stale. Do NOT refresh silently. You must inform the USER, in the session language, that the model catalog/pricing is outdated and ask whether they want to update it on this machine. If the user says no, keep using the current table (local override if present, otherwise plugin baseline) without refreshing. When the user later agrees to a local refresh (not now): launch one subagent per model, in parallel, each using the cheapest Task-catalog slug that can WebSearch/WebFetch (not one subagent for all models). After they return, the same cheap slug applies the existing math and writes only to %USERPROFILE%\.cursor\scrum-dev-agents\ (Linux/macOS: ~/.cursor/scrum-dev-agents/). GitHub stays the baseline. No GitHub Action. Do not assign any model slug until the user responds. Checker details: "
Write-HookJson ($prefix + $details)
exit 0
