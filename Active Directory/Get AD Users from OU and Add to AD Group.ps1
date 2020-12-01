Get-ADUser -Filter * -SearchBase 'OU=Office Users,DC=powershell,DC=com,DC=au' `
|Select-Object samaccountname | ForEach-Object {Add-ADGroupMember -Identity 'ADGroup' -Members $_.samaccountname } 