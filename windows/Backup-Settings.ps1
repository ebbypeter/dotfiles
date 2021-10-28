<#
.SYNOPSIS
  Backup the current settings / configuration files.
  
.DESCRIPTION
  Backup the current settings / coniguration files. The script will use config.json
  to identify the files that needs to be backed up. The files will be stored 
  within ./backup/<comupterName> folder.  

.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Ebby Peter
  Creation Date:  28-Oct-2021
  Purpose/Change: Initial script development

.EXAMPLE
  .\Backup-Settings.ps1
#>

#----------------------------------------[Script Parameters]----------------------------------------
[CmdletBinding()]
param ()

#-------------------------------------------[Declarations]------------------------------------------
$homeFolder = $HOME;
$myDocumentsFolder = [Environment]::GetFolderPath("MyDocuments");
$configFileName = "config.json"
$currentLocation = $PSScriptRoot;
$hostname = hostname;
$backupFolder = ".\backup\$hostname"
#--------------------------------------------[Functions]--------------------------------------------

#--------------------------------------------[Execution]--------------------------------------------
Write-Host "Current Location: $currentLocation";
Write-Host "Config File Path: $currentLocation\$configFileName";
Write-Host "MyDocuments Folder Path: $myDocumentsFolder";

# Load config file
$configJson = Get-Content -Raw -Path "$currentLocation\$configFileName" | ConvertFrom-Json

# Create a ./backup/<hostname> folder
New-Item -Path . -Name $backupFolder -ItemType Directory -Force

# Copy the files determined in config to backup folder
Write-Host "";
foreach ($configItem in $configJson)
{
  Write-Host "Copying $($configItem.title)";
  $configItem.sourceFolder = $configItem.sourceFolder.replace("~", $homeFolder);
  $configItem.sourceFolder = $configItem.sourceFolder.replace("%Documents%", $myDocumentsFolder);

  Copy-Item -LiteralPath "$($configItem.sourceFolder)\$($configItem.sourceFile)" -Destination "$backupFolder\$($configItem.targetFile)" -Force;
}
