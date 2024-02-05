[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string] $collectionName
)
    $collectionId = $(Get-CMDeviceCollection -Name $collectionName).CollectionID
    $devices = Get-CMDeviceCollection -CollectionId $collectionId

    Write-Host "Initiating client policy retrieval scripts for device collection: $($collectionName)"

    foreach ($device in $devices) {
	Invoke-CMClientAction -DeviceName $device.Name -ActionType ClientNotificationAppDeplEvalNow
	Invoke-CMClientAction -DeviceName $device.Name -ActionType ClientNotificationRequestMachinePolicyNow
	Invoke-CMClientAction -DeviceName $device.Name -ActionType ClientNotificationRequestUsersPolicyNow
}
 
