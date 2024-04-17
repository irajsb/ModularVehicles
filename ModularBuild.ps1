

# Prompt the user for the Unreal Engine version
$version = Read-Host "Enter Unreal Engine version (e.g., 5.x)"

# Replace the version in the specified path
$newPath = "D:\WorkSpace\Engine\UE_$version\Engine\Build\BatchFiles\RunUAT.bat"

# Call RunUAT.bat to build the plugin
& $newPath BuildPlugin -Plugin=D:\WorkSpace\PersonalProjects\ModularVehicles\Plugins\MovementComponent\ModularMovement.uplugin -Package=D:\WorkSpace\Package\ModularMovement\ -Rocket

Write-Host "Start sleep"
Start-Sleep -Seconds 5
Write-Host "End sleep"

# If version is 5.1 or 5.2
if ($version -eq "5.1" -or $version -eq "5.2") {
    # Remove Content folder and its subfolders
    Remove-Item "D:\WorkSpace\Package\ModularMovement\Content" -Recurse -Force

    # Copy contents from the source to the target folder
    Copy-Item "D:\WorkSpace\PersonalProjects\ModularVehicle51\Plugins\MovementComponent\Content" -Destination "D:\WorkSpace\Package\ModularMovement\" -Recurse
}



# Remove Binaries and Intermediate folders inside the target folder
$targetFolder = "D:\WorkSpace\Package\ModularMovement\"
Remove-Item "$targetFolder\Binaries" -Recurse -Force
Remove-Item "$targetFolder\Intermediate" -Recurse -Force

# Zip the entire target folder
$zipFileName = "ModularMovement$version.zip"
Remove-Item "D:\WorkSpace\Package\$zipFileName"
Compress-Archive -Path $targetFolder\* -DestinationPath "D:\WorkSpace\Package\$zipFileName" -Update


Write-Host "Script completed successfully."
