$Folder = Read-Host "Please enter the name of the folder containing the keymap you want to build (e.g. 'default')" 

if (Test-Path -Path $Folder) {
    # See if the files are already loaded.
    if ((Get-FileHash 'corne.conf').Hash -eq (Get-FileHash ".\${Folder}\corne.conf").Hash -and
        (Get-FileHash 'corne.keymap').Hash -eq (Get-FileHash ".\${Folder}\corne.keymap").Hash -and
        (Get-FileHash 'west.yml').Hash -eq (Get-FileHash ".\${Folder}\west.yml").Hash) {
            return Write-Host "The given keymap is already loaded. Exiting..." -ForegroundColor Blue
        }

    Copy-Item -Path ".\${Folder}\*" -Destination . -Force -Include *.conf,*.keymap,*.yml
    Write-Host "Successfully set keymap to build." -ForegroundColor Green
} else {
    Write-Host "Couldn't find the keymap folder '${Folder}'." -ForegroundColor Red
}
