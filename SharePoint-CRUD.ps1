cls
$ErrorActionPreference = "Stop"

if(!(Get-Module -Name SharePointPnPPowerShellOnline -ea 0)) {
Write-Host "Working on it..." -ForegroundColor Green
Write-Progress -Activity "Loading Modules" -Status "Loading SharePointPnPPowerShellOnline"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Scope CurrentUser -Force
Install-Module SharePointPnPPowerShellOnline -Scope CurrentUser -Force
Import-Module SharePointPnPPowerShellOnline
}

#Static Variables
$UserName = ""
$SiteUrl = ""
#User Credentials
if ($Credentials -eq $null) {
$Credentials = Get-Credential -Credential $UserName
#Connect to SharePoint with browser based login
    Connect-PnPOnline -Url $SiteUrl -UseWebLogin
#Connect to SharePoint with specific credentials
    #Connect-PnPOnline -Url $SiteUrl -Credentials $Credentials
}

#List Data
$ListName = "CRUD Test"
$IdToUpdate = "1"
$ModifiedDate = Get-Date "2016-11-11T10:00:00-00:00"
$CreatedDate = Get-Date "2022-11-11T10:00:00-00:00"
$ValuesToUpdate = @{"Modified"=$ModifiedDate;"Created"=$CreatedDate}


#Update List Item
Set-PnPListItem -List $ListName -Identity $IdToUpdate -Values $ValuesToUpdate


#Retrive List Items
$ListItems = Get-PnPListItem -List $ListName
    foreach ($ListItem in $ListItems) {
        Write-Host "Id :" $ListItem["ID"]
        Write-Host "Title :" $ListItem["Title"]
        Write-Host "Modified Date :" $ListItem["Modified"]
        Write-Host "Created Date :" $ListItem["Created"]
        Write-Host "------------------------------------"
}
