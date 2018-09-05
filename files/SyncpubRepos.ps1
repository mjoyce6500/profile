# This sync's local copy from Master repo and pushes local copy to my fork
# Sample usage is $run\SyncRepos.ps1

$repos=((Get-ChildItem -Directory $pubgit).Name)
foreach ($repo in $repos){
    write-host "-----------------"
    write-host "Syncing $repo...."
    cd $pubgit\$repo
    $git=git remote
    if ($git -contains "upstream"){
        git pull upstream master
        git push
        } else {
        write-host "No upstream master, continuing to 'push'"
        git push
        }
}
cd ..