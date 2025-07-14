## Get all github_repository resources from state
#$repoResources = terraform state list | Where-Object { $_ -like "github_repository.*" }
#
#if ($repoResources.Count -eq 0) {
#    Write-Host "No github_repository resources found in state." -ForegroundColor Yellow
#    return
#}
#
## Loop and remove each one
#foreach ($resource in $repoResources) {
#    Write-Host "❌ Removing $resource from state..." -ForegroundColor Red
#    terraform state rm $resource
#}


# Save user's original location
$startingPath = Get-Location

# Navigate to infra directory
$scriptPath = $MyInvocation.MyCommand.Path
$infraPath = Join-Path (Split-Path $scriptPath -Parent) ".." | Resolve-Path
Set-Location $infraPath

# Get all github_repository resources from Terraform state
$reposInState = terraform state list | Where-Object {
    $_ -like "github_repository.*" -or $_ -like "module.*.github_repository.*"
}

if ($reposInState.Count -eq 0) {
    Write-Host "🟡 No github_repository resources found in state."
} else {
    foreach ($resource in $reposInState) {
        Write-Host "✅ Removing: $resource" -ForegroundColor Green
        terraform state rm $resource
    }
}

# Return to user's original location
Set-Location $startingPath