# Read precios_consultados and vence from the plugin rule.
# Direct run: prints a status block and exits 0 (fresh), 1 (stale), or 2 (unreadable).
# Dot-source: defines Get-PriceFreshness and does not exit.
# Windows PowerShell 5.1 and PowerShell 7. Clock override: PRICE_FRESHNESS_TODAY=YYYY-MM-DD.

$script:PriceFreshnessRoot = Split-Path -Parent $PSScriptRoot

function Get-PriceFreshness {
    $root = $script:PriceFreshnessRoot
    if ($env:PRICE_FRESHNESS_RULE) {
        $rule = $env:PRICE_FRESHNESS_RULE
    } else {
        $userHome = if ($env:USERPROFILE) { $env:USERPROFILE } elseif ($env:HOME) { $env:HOME } else { $null }
        $localSnapshot = if ($userHome) { Join-Path $userHome ".cursor\scrum-dev-agents\AGENTS.md" } else { $null }
        if ($localSnapshot -and (Test-Path -LiteralPath $localSnapshot)) {
            $rule = $localSnapshot
        } else {
            $rule = Join-Path $root "rules\cursor-agent-policy.mdc"
        }
    }

    if ($env:PRICE_FRESHNESS_TODAY) {
        $today = $env:PRICE_FRESHNESS_TODAY
    } else {
        $today = [DateTime]::UtcNow.ToString("yyyy-MM-dd")
    }

    $lines = New-Object System.Collections.Generic.List[string]
    function Add-Line([string]$Line) { $lines.Add($Line) | Out-Null }

    if (-not (Test-Path -LiteralPath $rule)) {
        Add-Line "stale"
        Add-Line "rule-missing=$rule"
        Add-Line "today=$today"
        return @{ Code = 2; Text = ($lines -join "`n") }
    }

    $invariant = [Globalization.CultureInfo]::InvariantCulture
    $text = [IO.File]::ReadAllText($rule)
    $precios = $null
    $vence = $null
    foreach ($raw in ($text -split "`n")) {
        $line = $raw.TrimEnd("`r")
        if ($line -notmatch "(\d{4}-\d{2}-\d{2})") { continue }
        $found = $Matches[1]
        if ($line -like "*precios_consultados*") { $precios = $found }
        if ($line -match "(^|[^A-Za-z])vence([^A-Za-z]|$)") { $vence = $found }
    }

    if (-not $precios -or -not $vence) {
        Add-Line "stale"
        Add-Line ("precios_consultados=" + $(if ($precios) { $precios } else { "missing" }))
        Add-Line ("vence=" + $(if ($vence) { $vence } else { "missing" }))
        Add-Line "today=$today"
        Add-Line "Could not read precios_consultados and vence from $rule."
        return @{ Code = 2; Text = ($lines -join "`n") }
    }

    $preciosDate = [DateTime]::ParseExact($precios, "yyyy-MM-dd", $invariant)
    $limit = $preciosDate.AddMonths(1).ToString("yyyy-MM-dd")
    $reasonParts = New-Object System.Collections.Generic.List[string]
    if ([string]::CompareOrdinal($today, $vence) -gt 0) {
        $reasonParts.Add("today is after vence") | Out-Null
    }
    if ([string]::CompareOrdinal($today, $limit) -gt 0) {
        $reasonParts.Add("precios_consultados is more than one calendar month old") | Out-Null
    }

    Add-Line $(if ($reasonParts.Count -eq 0) { "fresh" } else { "stale" })
    Add-Line "precios_consultados=$precios"
    Add-Line "vence=$vence"
    Add-Line "month_limit=$limit"
    Add-Line "today=$today"
    if ($reasonParts.Count -gt 0) {
        Add-Line ("reason=" + ($reasonParts -join "; "))
        return @{ Code = 1; Text = ($lines -join "`n") }
    }
    return @{ Code = 0; Text = ($lines -join "`n") }
}

if ($MyInvocation.InvocationName -ne ".") {
    $result = Get-PriceFreshness
    Write-Output $result.Text
    exit $result.Code
}
