#HW10A1-Get-User

[CmdletBinding()]

param(
[Parameter (
   Mandatory =$false,
   ValueFromPipeline =$false)]
   [string]$pFilter,
   

[Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [System.Management.Automation.PSCredential]$pCredential=(Get-Credential),

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [string]$pServer

)#Parameters

BEGIN {
    write-verbose "BEGIN starting..."
    write-output "BEGIN"

    Write-Output "Hw10A1-Get-User.psl starting"

    write-verbose "BEGIN finished."
}#Begin
PROCESS {
    write-verbose "PROCESS starting..."
    write-output "PROCESS"
    if ($pFilter -eq ""){
    Get-ADUser -Filter * -Credential $pCredential -Server $pServer
    }
    else {
    Get-ADUser -Filter $pFilter -Credential $pCredential -Server $pServer
    }
    

    Write-Verbose "PROCESS finished."
}#Process

END {
    Write-Verbose "END starting..."
    Write-Output "END"
    Write-Verbose "END finished."
}#End