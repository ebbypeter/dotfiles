<#
.SYNOPSIS
  Install the Azure Visio Stencils
  
.DESCRIPTION
  Install / Copy the following Azure Visio Stencils to appropriate location, 
  so that the stencils are available for use in Visio
  
.INPUTS
  None

.OUTPUTS
  None

.NOTES
  Version:        1.0
  Author:         Ebby Peter
  Creation Date:  17-Dec-2020
  Purpose/Change: Initial script development

.EXAMPLE
  .\Install-VisioPackage.ps1
#>

#--------------------------------------------------[Script Parameters]--------------------------------------------------
[CmdletBinding()]
param ()

#-----------------------------------------------------[Declarations]----------------------------------------------------


#------------------------------------------------------[Functions]------------------------------------------------------
function DownloadGitHubRepository { 
  [CmdletBinding()]
  param( 
    [Parameter(Mandatory = $true)] 
    [string] $Name, 
        
    [Parameter(Mandatory = $true)] 
    [string] $Author, 
        
    [Parameter(Mandatory = $false)] 
    [string] $Branch, 
        
    [Parameter(Mandatory = $false)] 
    [string] $Location 
  ) 
    
  if (!$Branch) {
    $Branch = "master";
  }
    
  if (!$Location) {
    $Location = $PSScriptRoot;
  }

  # Force to create a zip file 
  $zipFile = $Location + "\temp.zip";

  $repositoryZipUrl = "https://api.github.com/repos/$Author/$Name/zipball/$Branch"  
  # download the zip 
  Write-Host ' > Starting downloading the GitHub Repository' -ForegroundColor DarkGray
  Invoke-RestMethod -Uri $repositoryZipUrl -OutFile $zipFile
  Write-Host '   > Download finished'  -ForegroundColor DarkGray

  #Extract Zip File
  Write-Host ' > Starting unziping the GitHub Repository locally' -ForegroundColor DarkGray
  Expand-Archive -Path $zipFile -DestinationPath $Location -Force
  Write-Host '   > Unzip finished' -ForegroundColor DarkGray
    
  # remove zip file
  Remove-Item -Path $zipFile -Force 

  $unzipFolder = (Get-ChildItem -Path $Location -Filter "$Author-$Name-*" -Recurse -Directory).Fullname

  Write-Host $unzipFolder;

  if($unzipFolder.count -gt 1) {
    return $unzipFolder[-1]
  }
  
  return $unzipFolder;
}
function Install-AzureStencils {
  [CmdletBinding()]
  param( 
    [Parameter(Mandatory = $true)] 
    [string] $Name, 
        
    [Parameter(Mandatory = $true)] 
    [string] $Author, 

    [Parameter(Mandatory = $false)] 
    [string] $TargetFolder, 
        
    [Parameter(Mandatory = $false)] 
    [string] $Branch, 
        
    [Parameter(Mandatory = $false)] 
    [string] $Location 
  ) 
        
  if (!$Location) {
    $Location = Get-ChildItem HKCU:\Software\Microsoft\Office\ -Recurse `
    | Where-Object { $_.PSChildName -eq "Application" } `
    | Get-ItemProperty -Name MyShapesPath `
    | Select-Object -ExpandProperty MyShapesPath;
  }

  if (!$TargetFolder) {
    $TargetFolder = $Name;
  }
    
  $downloadResult = (DownloadGitHubRepository -Name $Name -Author $Author -Branch $Branch);
  Write-Host "Unzip Folder is $downloadResult";
  [string]$githubFolder = $downloadResult;
  Write-Host " > Starting to install $Name Stencils locally" -ForegroundColor DarkGray;
  $files = Get-ChildItem $gitHubFolder -Recurse -Force -Filter *.vssx;
    
  $directory = New-Item -ItemType Directory -Path $Location -Name $TargetFolder -Force;
  foreach ($file in $files) {
    if (!$file.FullName.Contains("\Archive\")) {
      Copy-Item -Path $file.FullName -Destination (($directory.FullName) + "\" + ($file.NameString)) -Force;
    }
  }
    
  Remove-Item -Path $githubFolder -Recurse -Force -Confirm:$false;
}

#------------------------------------------------------[Execution]------------------------------------------------------
Write-Host "Installing Azure-Design" -ForegroundColor White
Install-AzureStencils -Name "Azure-Design" `
  -Author "David-Summers" `
  -Branch "master" `
  -TargetFolder "Azure Design";
Write-Host "Done" -ForegroundColor Green

Write-Host "Installing Microsoft-Integration-and-Azure-Stencils-Pack-for-Visio" `
  -ForegroundColor White
Install-AzureStencils -Name 'Microsoft-Integration-and-Azure-Stencils-Pack-for-Visio' `
  -Author 'sandroasp' `
  -Branch "master" `
  -TargetFolder "Microsoft Integration and Azure Stencils Pack";
Write-Host "Done" -ForegroundColor Green