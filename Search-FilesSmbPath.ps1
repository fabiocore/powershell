# Search for specific files on the smb path

$path_to_find="\\server1\public"
$bytecount=0

Clear-Host
Write-Host "Searching... "

Get-Childitem -Path $path_to_find -Include *.aep,*.ai,*.c4d,*.ma,*.mb,*.nk,*.nk_,*.hip,*.max,*.vrmesh -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    Clear-Host
    Write-Host "Searching... "
    $bytecount += $_.Length
    switch -Regex ([math]::truncate([math]::log($bytecount,1024))) {
    '^0' {"$bytecount Bytes"}
    '^1' {"{0:n2} KB" -f ($bytecount / 1KB)}
    '^2' {"{0:n2} MB" -f ($bytecount / 1MB)}
    '^3' {"{0:n2} GB" -f ($bytecount / 1GB)}
    '^4' {"{0:n2} TB" -f ($bytecount / 1TB)}
     Default {"{0:n2} PB" -f ($bytecount / 1pb)}
    }
}

$bytecount | Out-File -FilePath "C:\pwsh-scripts\search.log"