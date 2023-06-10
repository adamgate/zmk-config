# A simple script to make switching between layouts painless
# also exports config to my dotfiles repo

# Exports the entire repo except for github actions to the target directory
function Export-Dotfiles {
    # $exportPath = "${HOME}\Code\Personal\config-files\keyboards\corne\"
    $exportPath = "E:\Code\Personal\config-files\keyboards\corne\"
    if (-not (Test-Path -Path $exportPath)) {
        return Write-Host "Couldn't find the export path. Please make sure you have the dotfiles repo cloned in the corret spot. `n" -ForegroundColor Red
    }

    Write-Host "Exporting repository..."
    Copy-Item -Path "..\*" -Destination $exportPath -Exclude .github,.git -Force -Recurse
    Write-Host "Repository exported successfully." -ForegroundColor Green
}

# Loads the selected keymap into the directory to be built by github actions
function Stage-Keymap {
    $Folder = Read-Host "Please enter the name of the folder containing the keymap you want to build (e.g. 'default')" 

    # Ensure provided folder exists
    if (-not (Test-Path -Path $Folder)) {
        return Write-Host "Couldn't find the keymap folder '${Folder}' for staging. `n" -ForegroundColor Red
    }

    # See if the files are already loaded.
    if ((Get-FileHash "corne.conf").Hash -eq (Get-FileHash ".\${Folder}\corne.conf").Hash -and
        (Get-FileHash "corne.keymap").Hash -eq (Get-FileHash ".\${Folder}\corne.keymap").Hash -and
        (Get-FileHash "west.yml").Hash -eq (Get-FileHash ".\${Folder}\west.yml").Hash) {
            return Write-Host "The keymap '${Folder}' is already staged. Exiting... `n" -ForegroundColor Blue
        }
    
    Copy-Item -Path ".\${Folder}\*" -Destination . -Force -Include *.conf,*.keymap,*.yml
    Write-Host "Successfully staged keymap '${Folder}' to build. `n" -ForegroundColor Green
}

# Entry point for the program
Export-Dotfiles
Stage-Keymap
