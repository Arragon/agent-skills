[CmdletBinding()]
param(
    [ValidateSet("user", "project")]
    [string]$SkillScope = "user",

    [ValidateSet("all", "codex", "claude", "cursor")]
    [string]$Target = "all",

    [string]$ProjectDir = (Get-Location).Path,

    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Skills
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillsRoot = Join-Path $RepoRoot "skills"

if (-not $Skills -or $Skills.Count -eq 0) {
    $Skills = Get-ChildItem -LiteralPath $SkillsRoot -Directory |
        Sort-Object Name |
        Select-Object -ExpandProperty Name
}

if ($SkillScope -eq "user") {
    $CodexRoot = Join-Path $HOME ".agents\skills"
    $ClaudeRoot = Join-Path $HOME ".claude\skills"
    $CursorRoot = Join-Path $HOME ".cursor\skills"
}
else {
    $ResolvedProject = (Resolve-Path -LiteralPath $ProjectDir).Path
    $CodexRoot = Join-Path $ResolvedProject ".agents\skills"
    $ClaudeRoot = Join-Path $ResolvedProject ".claude\skills"
    $CursorRoot = Join-Path $ResolvedProject ".cursor\skills"
}

$DestinationRoots = switch ($Target) {
    "all" { @($CodexRoot, $ClaudeRoot) }
    "codex" { @($CodexRoot) }
    "claude" { @($ClaudeRoot) }
    "cursor" { @($CursorRoot) }
}

$Timestamp = Get-Date -Format "yyyyMMddHHmmss"

foreach ($SkillName in $Skills) {
    $SourceDir = Join-Path $SkillsRoot $SkillName
    $SkillFile = Join-Path $SourceDir "SKILL.md"
    if (-not (Test-Path -LiteralPath $SkillFile -PathType Leaf)) {
        throw "Skill not found or invalid: $SkillName"
    }

    foreach ($DestinationRoot in $DestinationRoots) {
        New-Item -ItemType Directory -Path $DestinationRoot -Force | Out-Null
        $DestinationDir = Join-Path $DestinationRoot $SkillName

        if (Test-Path -LiteralPath $DestinationDir) {
            $BackupDir = "$DestinationDir.backup.$Timestamp"
            Move-Item -LiteralPath $DestinationDir -Destination $BackupDir
            Write-Host "Backed up $DestinationDir to $BackupDir"
        }

        Copy-Item -LiteralPath $SourceDir -Destination $DestinationRoot -Recurse
        Write-Host "Installed $SkillName to $DestinationDir"
    }
}
