#HW10B1-Activation-Status-User

[cmdletBinding()]
param (

[Parameter (
Mandatory = $False,
ValueFromPipeline = $False
)]
[String] $pFilter ,                


[Parameter (
Mandatory = $True,
ValueFromPipeline = $False
)]
[String] $pServer ,

[Parameter (
Mandatory = $True,
ValueFromPipeline = $False
)]
[PSCredential] $pCredential = (Get-Credential)
)
#Parameter
BEGIN { ######################################
Write-Verbose "Begin Starting"
Write-Output  "Begin"
Write-Output "HW10B1-Activation-Status-User.ps1 starting.."
Write-Verbose "Begin Finished"

}

PROCESS {###########################################
Write-Verbose "Process Starting..."
Write-Output "Process"

if ($pFilter -eq "") {
Get-ADUser -Filter * -Credential $pCredential -Server $pServer | Select-Object -Property SAMAccountName, Name, Enabled
} 

else {
Get-ADUser -Filter $pFilter  -Credential $pCredential -Server $pServer | Select-Object -Property SAMAccountName, Name, Enabled
}

#Get-ADUser -Filter $pFilter
Write-Verbose "Process Finished"
}

END{#########################################
Write-Verbose "End Starting"
Write-Output "End"
Write-Verbose "End Finished"

}