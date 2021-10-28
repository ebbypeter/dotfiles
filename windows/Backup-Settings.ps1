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
$myDocumentsFolder = [Environment]::GetFolderPath("MyDocuments");
$configFileName = "config.json"
$currentLocation = $PSScriptRoot;
#--------------------------------------------[Functions]--------------------------------------------

#--------------------------------------------[Execution]--------------------------------------------
Write-Host "Current Location: $currentLocation";
Write-Host "Config File Path: $currentLocation\$configFileName";
Write-Host "MyDocuments Folder Path: $myDocumentsFolder";

# Load config file

# Create a ./backup/<hostname> folder

# Copy the files determined in config to backup folder

