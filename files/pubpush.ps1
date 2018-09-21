# This commits & pushes local code to my fork
# Sample usage is $run\bbpush.ps1
$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
$StopWatch.Start()
    write-host "-----------------"
    write-host "Pushing to fork...."
    $git=git remote
    if ($git -contains "origin"){
        $t1 = Measure-Command {git add *}
        $t2 = Measure-Command {git commit -m "Updated formatting of seconds, commited with script"}
        $t3 = Measure-Command {git push -u origin master}
        Write-Host "Took " $t1.TotalSeconds.ToString("#,###.00") " seconds to add, and " -NoNewline
        Write-Host $t2.TotalSeconds.ToString("#,###.00") " seconds to commit,  " -NoNewLine 
        Write-Host $t3.TotalSeconds.ToString("#,###.00") " seconds to push"
        } else {
        write-host "No upstream origin, doing nothing'"
        }
$stopwatch.Stop()
Write-Host "Took " $stopWatch.Elapsed.TotalSeconds.ToString("#,###.00") " seconds to push to repo" -ForegroundColor White