Set-Alias -Name ll -Value ls
Set-Alias -Name rmrf -Value Remove
Set-Alias -Name dn -Value dotnet
Set-Alias -Name dnw -Value DotnetWatch
Set-Alias -Name dnr -Value DotnetRun
Set-Alias -Name dnb -Value DotnetBuild

function Remove([string]$Item)
{
    rm "$Item" -Force -Recurse
}

function DotnetBuild {
    dn build
}

function DotnetRun {
    dn run
}

function DotnetWatch {
    dn watch run
}