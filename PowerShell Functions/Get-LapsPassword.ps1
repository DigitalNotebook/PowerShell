 
 
Function Get-LapsPassword
{
  [cmdletBinding()]
  param(

    [Parameter(Mandatory=$True,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName =$True)]
    [Alias('hostname', 'cn', 'Name', 'Computer', 'PC')]  # Flexible ByPropertyName or use Hastable @{Name = 'Name'; Expression={$_.ComputerName}}
    [String[]]$Computername
  )

  foreach ($Computer in $Computername)
  {

  Get-ADComputer -Identity $Computer -Properties ms-Mcs-AdmPwd, ms-Mcs-AdmPwdExpirationTime `
  | Select-Object `
    @{N='ComputerName'; E={$_.name}}, `
    @{N='ComputerPassword'; E={$_."ms-Mcs-AdmPwd"}}, `
    @{N='PasswordExpirationTime'; E={[DateTime]::FromFileTime($_."ms-Mcs-AdmPwdExpirationTime")}}

  
  }
}