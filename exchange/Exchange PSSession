$UserCredential = Get-Credential
$ESEX16 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://server/powershell -Authentication Kerberos -Credential $UserCredential
Import-PSSession $ESEX16 -allowclobber  
#remove-pssession $ESEX16
