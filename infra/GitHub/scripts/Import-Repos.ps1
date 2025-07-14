# Path to your .tfvars file
$tfVarsFile = "talelearncode.tfvars"

# Dynamically locate the infra directory from the script's location
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path $scriptPath -Parent
$tfDirectory = Join-Path $scriptDir ".." | Resolve-Path

# Function to strip comments (single-line and block)
function Strip-Comments {
    param ($rawContent)

    # Remove block comments (/* ... */), across multiple lines
    $noBlockComments = [regex]::Replace($rawContent, '/\*.*?\*/', '', 'Singleline')

    # Remove single-line comments (starting with # or //)
    $cleanLines = $noBlockComments -split "`r?`n" | Where-Object {
        ($_ -notmatch '^\s*#') -and ($_ -notmatch '^\s*//')
    }

    return $cleanLines -join "`n"
}

# Gather current terraform state
Write-Host "`n🔍 Retrieving current Terraform state..."
$existingState = terraform state list | Where-Object { $_ -like "github_repository.*" -or $_ -like "module.*.github_repository.*" }

# Regex patterns
$githubResourcePattern = '(?ms)resource\s+"github_repository"\s+"([^"]+)"\s*{(.*?)}'
$namePropPattern        = 'name\s*=\s*"([^"]+)"'

$modulePattern          = '(?ms)module\s+"([^"]+)"\s*{(.*?source\s*=\s*"(\./modules/presentation_repo)".*?)}'
$privateRepoPattern     = 'private_repo_name\s*=\s*"([^"]+)"'
$publicRepoPattern      = 'public_repo_name\s*=\s*"([^"]+)"'

# Collection
$importItems = @()

# Parse .tf files in infra folder
Get-ChildItem -Path $tfDirectory -Filter *.tf | ForEach-Object {
    $rawContent = Get-Content $_.FullName -Raw
    $content = Strip-Comments -rawContent $rawContent

    # 🧩 Inline github_repository blocks
    $resourceMatches = [regex]::Matches($content, $githubResourcePattern)
    foreach ($match in $resourceMatches) {
        $resourceName = $match.Groups[1].Value
        $blockBody = $match.Groups[2].Value

        $nameMatch = [regex]::Match($blockBody, $namePropPattern)
        if ($nameMatch.Success) {
            $repoId = $nameMatch.Groups[1].Value
            $resourceFullName = "github_repository.$resourceName"
            $importItems += @{ Resource = $resourceFullName; Repo = $repoId }
        }
    }

    # 🧩 Module blocks referencing presentation_repo
    $moduleMatches = [regex]::Matches($content, $modulePattern)
    foreach ($mod in $moduleMatches) {
        $moduleName = $mod.Groups[1].Value
        $moduleBody = $mod.Groups[2].Value

        $privateMatch = [regex]::Match($moduleBody, $privateRepoPattern)
        $publicMatch  = [regex]::Match($moduleBody, $publicRepoPattern)

        if ($privateMatch.Success) {
            $repoId = $privateMatch.Groups[1].Value
            $resourceFullName = "module.$moduleName.github_repository.private"
            $importItems += @{ Resource = $resourceFullName; Repo = $repoId }
        }

        if ($publicMatch.Success) {
            $repoId = $publicMatch.Groups[1].Value
            $resourceFullName = "module.$moduleName.github_repository.public"
            $importItems += @{ Resource = $resourceFullName; Repo = $repoId }
        }
    }
}

# 🚀 Import missing resources
foreach ($item in $importItems) {
    if ($existingState -contains $item.Resource) {
        Write-Host "✓ Already in state: $($item.Resource)" -ForegroundColor Yellow
    } else {
        Write-Host "`n🔄 Importing: $($item.Repo) as $($item.Resource)" -ForegroundColor Cyan
        terraform import -var-file="$tfVarsFile" $($item.Resource) $($item.Repo)
    }
}
