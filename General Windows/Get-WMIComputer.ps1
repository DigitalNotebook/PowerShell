Function  Get-WMIComputer
{
  [cmdletBinding()]
  param(

    [Parameter(Mandatory                =$True,
        ValueFromPipeline               =$true,
        ValueFromPipelineByPropertyName =$True)]
    [Alias('Hostname', 'cn', 'Name')]  # Flexible ByPropertyName or use Hastable @{ComputerName = "Name";Expression={$_.ComputerName}}
    [String[]]$Computername
  )
  
  
  Begin {}
  Process # Process block is needed to get more than one object out of the pipeline           
  { # Process block is ignored when there is no pipleline input
     
    Foreach ($Computer in $Computername) { 

      try {

        $CimSessionOption = New-CimSessionOption -Protocol Dcom
        $CimSession = New-CimSession -ComputerName $Computer -SessionOption $CimSessionOption -ErrorAction Stop             
   
        $ComputerSystem  = Get-CimInstance -Class Win32_ComputerSystem  -Namespace root\CIMv2 -CimSession $CimSession    
        $OperatingSystem = Get-CimInstance -Class Win32_OperatingSystem -Namespace root\CIMv2 -CimSession $CimSession  
       
    
          #Splatting hash table
          $Properties           =  @{
            Status              = 'Connected CimSession'
            Computername        = $Computer
            UserName            = $ComputerSystem.UserName
            TotalPhysicalMemory = [math]::round($ComputerSystem.TotalPhysicalMemory / 1gb)
            Manufacturer        = $ComputerSystem.Manufacturer
            model               = $ComputerSystem.Model 
            SystemType          = $ComputerSystem.SystemType
               
            
            OS                  = $OperatingSystem.Version
            PCSystemType        = $OperatingSystem.ProductType}     
            
         

      } catch {

          $Properties           = @{
            Status              = 'Failed CimSession'
            Computername        = $null
            UserName            = $null
            TotalPhysicalMemory = $null
            Manufacturer        = $null
            model               = $null
            SystemType          = $null
               
            
            OS                  = $null
            ProductType         = $null}
       
       
        Write-Verbose $error[0]                              
      
      } finally {
      
        $object = New-Object -TypeName psobject -Property $Properties              
      
      
  
        if ($object.status -eq 'Connected CimSession')
        {
          Remove-CimSession -CimSession $CimSession
       
        }
        Write-Output  $object
      
      }
 
    }
  }
  
 

  
  End {}

}  

  "localhost", "127.0.0.1" | Get-WMIComputer  
 

