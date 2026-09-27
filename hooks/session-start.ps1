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

$prefix = "Price table is stale. Do NOT refresh silently. You must inform the USER, in the session language, that the model catalog/pricing is outdated and ask whether they want to update it on this machine. If the user says no, keep using the current table (local override if present, otherwise plugin baseline) without refreshing. If the user says yes, perform the local refresh using the cheapest Task-catalog model that can WebSearch/WebFetch (AGENTS.md §2.0) and save the results in %USERPROFILE%\.cursor\scrum-dev-agents\. Do not assign any model slug until the user responds. Checker details: "
Write-HookJson ($prefix + $details)
exit 0
