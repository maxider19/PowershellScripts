#HW10A2-New-User

[CmdletBinding()]
param(
   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [string]$pPath ,
   <# TurkDaPath=OU=HW10OU_ShahMa,OU=c6-2016-1,DC=c6TurkDa,DC=TurkDom,DC=Net
    LocalPath=CN=Users,DC=c6ShahMa,DC=TurkDom,DC=Net#>

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$true)]
   [string[]]$pUserName ,

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [System.Management.Automation.PSCredential]$pCredential=(Get-Credential),

   [Parameter (
   Mandatory =$false,
   ValueFromPipeline =$false)]
   [string]$pPrefix='HW10_' ,

   [Parameter (
    Mandatory = $true
    , ValueFromPipeline=$false
    )]
    [System.Security.SecureString] $pPassword ,

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [string]$pServer

)#Param

BEGIN {
    write-verbose "BEGIN starting..."
    write-output "BEGIN"

    for ($i = 0; $i -le $pUserName.GetUpperBound(0); $i++)
    {
    $position = $pUserName[$i].IndexOf(" ")
    $firstName = $pUserName[$i].Substring(0,2).ToLower()
    $lastName =$pUserName[$i].Substring($position+1,4).ToLower()
    $pUserName[$i]=$lastName+$firstName
    }

    if ($pPrefix -ne "")
    {
    for ($i = 0; $i -le $pUserName.GetUpperBound(0); $i++)
    {
    $pUserName[$i] = $pPrefix+$pUserName[$i]
    Write-Verbose $pUserName[$i]
    }
    }
    
    Write-Output "Hw10A2-New-User.psl starting"

    write-verbose "BEGIN finished."
}#Begin
PROCESS {
    write-verbose "PROCESS starting..."
    write-output "PROCESS"
 
    Try{
    foreach($user in $pUserName){
    New-ADUser -Path $pPath -AccountPassword (ConvertTo-SecureString $pPassword -AsPlainText -force) `
     -Server $pServer -Credential $pCredential -Enabled:$true `
     -Name $user -ErrorAction Ignore
    }

    }Catch{
    Write-verbose "There is already an acoount exisitng with the given name!"
    continue
    }
    Write-Output $pUserName
  

    Write-Verbose "PROCESS finished."
}#Process

END {
    Write-Verbose "END starting..."
    Write-Output "END"
    Write-Verbose "END finished."
}#End