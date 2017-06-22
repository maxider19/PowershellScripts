#HW10B3-Disable-User

[CmdletBinding(DefaultParameterSetName='FilterSet')]

param(
   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false,
   ParameterSetName = "FilterSet")]
   [string]$pFilter ,

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$true,
   ParameterSetName = "AccountNameSet")]
   [string[]]$pAccountName ,

   [Parameter (
   Mandatory =$false,
   ValueFromPipeline =$false)]
   [bool]$pConfirm=$false ,

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [System.Management.Automation.PSCredential]$pCredential=(Get-Credential),

   [Parameter (
   Mandatory =$true,
   ValueFromPipeline =$false)]
   [string]$pServer


)#Parameter

BEGIN {
    write-verbose "BEGIN starting..."
    write-output "BEGIN"
    Write-Output "HW10B3-Disable-User.psl starting"

    write-verbose "BEGIN finished."
}#Begin
PROCESS {
    write-verbose "PROCESS starting..."
    write-output "PROCESS"

    switch ($PSCmdlet.ParameterSetName)
  {
        "FilterSet"{ 
        $user = Get-ADUser -Filter $pFilter -server $pServer -credential $pCredential
            
            foreach ($UserObj in $user){       
                  Disable-ADAccount -Identity $UserObj -Confirm:$pConfirm -Server $pServer -Credential $pCredential 
    
     }
        Write-Output "$($UserObj.SAMAccountName)"
        Write-Output "$($UserObj.Enabled)"
     }      
     
        "AccountNameSet"{ 
         
            foreach ($ItemName in $pAccountName){  
            $user = Get-ADUser -Filter {Name -eq $ItemName} -server $pServer -credential $pCredential
              
                  Disable-ADAccount -Identity $user -Confirm:$pConfirm -Server $pServer -Credential $pCredential 
     }   
        Write-Output "$($user.SAMAccountName)"  
        Write-Output "$($user.Enabled)" 
     }   
     
     }   

   }
#Process

END {
    Write-Verbose "END starting..."
    Write-Output "END"
    Write-Verbose "END finished."
}#End