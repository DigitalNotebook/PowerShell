   
   
   
Function Send-SecurityEventID {
  [cmdletBinding()]
  param(

    [Parameter(Mandatory=$True,
    ValueFromPipeline=$true,
    ValueFromPipelineByPropertyName =$True)]
    [int]$ID
  )   
   
 $Event = Get-WinEvent -MaxEvents 1 -FilterHashTable @{LogName = 'Security';ID = $ID}                  

 $HashArguments = @{   #Splatting with hash table (Enter Properties) 
 To         =  ''                    
 From       =  ''                           
 Subject    =  'Security Alert'                                           
                 
 SmtpServer =  ''}  

 Send-MailMessage @HashArguments -Body $Event.Message

} 
 
    
    
4798 | Send-SecurityEventID 


 
 
 

  
                    
                                   
 
   


  
 

  

   