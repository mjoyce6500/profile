# This sync's local copy from Master repo and pushes local copy to my fork
# Sample usage is $run\SyncRepos.ps1
$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
$repocount = 0
function input-path {
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$True,Position=1)]
      [string]$pubgit
    )
}
if (!(Test-Path $pubgit))  {input-path}
$StopWatch.Start()
$repos=((Get-ChildItem -Directory $pubgit).Name)
foreach ($repo in $repos){
    write-host "-----------------"
    write-host "Syncing $repo...." -ForegroundColor Green
    cd $pubgit\$repo
    $repocount = $repocount + 1
    $git=git remote
    if ($git -contains "upstream"){
        $t1 = Measure-Command {git pull upstream master}
        $t2 = Measure-Command { git push}
        $t3 = $t1 + $t2
        Write-Host "Took "  $t1.TotalSeconds.ToString("#,###.00") " seconds to pull, and " -NoNewline -ForegroundColor Yellow
        Write-Host $t2.TotalSeconds.ToString("#,###.00") " seconds to push for a " -NoNewline -ForegroundColor Yellow
        Write-Host " total of " $t3.TotalSeconds.ToString("#,###.00") " seconds" -ForegroundColor White
        } else {
        write-host "No upstream master, continuing to 'push'"
        git push
        }
}
cd ..
Write-Host "`n This took " $StopWatch.Elapsed.TotalSeconds.ToString("#,###.00") " seconds to sync all " $repocount "repos" -ForegroundColor White
$stopwatch.Stop()
