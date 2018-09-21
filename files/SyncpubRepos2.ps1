# This sync's local copy from Master repo and pushes local copy to my fork
# Sample usage is $run\SyncRepos.ps1
$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
function input-path {
    [CmdletBinding()]
    Param(
      [Parameter(Mandatory=$True,Position=1)]
      [string]$bbgit
    )
}

if (!(Test-Path $bbgit))  {input-path}

$StopWatch.Start()
$repos=((Get-ChildItem -Directory $bbgit).Name)
foreach ($repo in $repos){
    write-host "-----------------"
    write-host "Syncing $repo...."
    cd $bbgit\$repo
    $git=git remote
    if ($git -contains "upstream"){
        $t1 = Measure-Command {git pull upstream master}
        $t2 = Measure-Command { git push}
        $t3 = $t1 + $t2
 #       $t1 = [Math]::Round(($t1)
        Write-Host "Took "  $t1.TotalSeconds.ToString("#,###.00") " seconds to pull, and " -NoNewline
        Write-Host $t2.TotalSeconds.ToString("#,###.00") " seconds to push" -NoNewline
        Write-Host " for a total of " $t3.TotalSeconds.ToString("#,###.00") " seconds" -ForegroundColor White
        } else {
        write-host "No upstream master, continuing to 'push'"
        git push
        }
}
cd ..
Write-Host "`n This took " $StopWatch.Elapsed.TotalSeconds.ToString("#,###.00") " seconds to sync all repos" -ForegroundColor White
$stopwatch.Stop()
