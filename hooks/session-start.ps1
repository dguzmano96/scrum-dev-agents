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
    Write-HookJson "Price freshness check is missing at scripts/price-freshness.ps1. Before assigning a model slug, run the price refresh in AGENTS.md section 2.1."
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

$prefix = "Price table is stale. Before assigning or suggesting any model slug, run the model-policy price refresh (AGENTS.md section 2.1 / docs/fuentes.md): open https://cursor.com/docs/models-and-pricing and the Spanish variant of that page, update input, output, cache write, and cache read, recompute cost and bar_drain, and re-check budget, low, mid, high, and cursor. Do not assign a slug from the stale matrix. Checker output: "
Write-HookJson ($prefix + $details)
exit 0
