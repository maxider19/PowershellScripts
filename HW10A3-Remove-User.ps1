#HW10A3-Remove-User

[CmdletBinding(DefaultParameterSetName='AccountNameSet')]

param(
   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false,
   parametersetname = "FilterSet")]
   [string]$pFilter ,


   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [System.Management.Automation.PSCredential]$pCredential=(Get-Credential),

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [string]$pServer ,

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$true,
   parametersetname = "AccountNameSet")]
   [string[]]$pAccountName ,

   [Parameter (
   Mandatory =$false,
   ValueFromPipeline =$false)]
   [bool]$pConfirm=$true 

)
#Parameter

BEGIN {
    write-verbose "BEGIN starting..."
    write-output "BEGIN"
    Write-Output "HW10A3-Remove-Userr.psl starting"

    write-verbose "BEGIN finished."
}#Begin
PROCESS {
    write-verbose "PROCESS starting..."
    write-output "PROCESS"

    if ($pFilter -eq ""){
    foreach ($itemIn in $pAccountName){
    $RemoveUser= Get-ADUser -server $pServer -credential $pCredential -filter {$Name -like $itemIn}
    Remove-ADUser $RemoveUser -Confirm:$True -Server $pServer -Credential $pCredential 
    Write-Verbose "$item is deleted from the server!"
    }
    }

    else {
    $DeleteUsers= Get-ADUser -server $pServer -credential $pCredential -filter $pFilter
    foreach($item in $DeleteUsers){
    Remove-ADUser $($item) -Server $($pServer) -Credential $($pCredential) -Confirm:$True
    Write-Verbose "$item is deleted from the server!"
    }
    }
   (Get-ADUser -Filter * -Credential $pCredential -Server $pServer).name
   

    Write-Verbose "PROCESS finished."
}#Process

END {
    Write-Verbose "END starting..."
    Write-Output "END"
    Write-Verbose "END finished."
}#End