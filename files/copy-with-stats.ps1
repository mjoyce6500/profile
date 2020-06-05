# This copy's files with performance stats to view copy speeds.
# 
$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
$listcount = 0
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
    write-host "Counting $repo files...." -ForegroundColor Green
    cd $pubgit\$repo
    $listcount = $listcount + 1
    $t1 = Measure-Command {$count1 = (Get-ChildItem -Path $pubgit\$repo -Recurse).Count}
    Write-Host "Counting how long to copy " $count1 "files"
    $t2 = Measure-Command {Copy-Item -Path $pubgit\$repo -Recurse -Destination C:\tmp\$repo}
    $t3 = $t1 + $t2
    Write-Host "Took "  $t1.TotalSeconds.ToString("#,###.00") " seconds to list, and " -NoNewline -ForegroundColor Yellow
    Write-Host $t2.TotalSeconds.ToString("#,###.00") " seconds to copy for a " -NoNewline -ForegroundColor Yellow
    Write-Host " total of " $t3.TotalSeconds.ToString("#,###.00") " seconds" -ForegroundColor White
}
cd ..
Write-Host "`n This took " $StopWatch.Elapsed.TotalSeconds.ToString("#,###.00") " seconds to run this copy " $listcount "repos" -ForegroundColor White
$stopwatch.Stop()
