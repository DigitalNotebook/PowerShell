   
Function Send-SecurityEventID {
  [cmdletBinding()]
  param(

    [Parameter(Mandatory=$True,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName =$True,
               Position=0)]
    [int]$ID,
    [string]$To,
    [string]$From,
    [string]$Subject,
    [string]$SmtpServer
  )   
   
 $HashArguments  = @{   #Splatting with hash table  
      To         =   $To                    
      From       =   $From                           
      Subject    =  "$Subject - Event ID $ID"
      SmtpServer =   $SmtpServer}  

 Send-MailMessage @HashArguments -Body ($Event = Get-WinEvent -MaxEvents 1 -FilterHashTable @{LogName = 'Security';ID = $ID}).message

} 