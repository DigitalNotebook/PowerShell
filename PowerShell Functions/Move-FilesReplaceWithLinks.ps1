function Move-FilesReplaceWithLinks {


  [cmdletBinding()]
  param
  (
   
    [String[]]
    [Parameter(Mandatory = $true)]
    $SourceFolder,
    [String]
    [Parameter(Mandatory = $true)]
    $TargetFolder,       
    [Double]
    [Parameter(Mandatory = $true)]
    $LastModified,
    [Parameter(Mandatory = $false)]
    [Switch]$Recurse
    
  )
   
  
  
    if ($Recurse -eq $true )
    {
      $GetSourceFiles = Get-ChildItem -Path $SourceFolder -file -Recurse | Where-Object  {(Get-Date).AddDays(-$LastModified) -le $_.LastWriteTime}
    }
    else {
    
      $GetSourceFiles = Get-ChildItem -Path $SourceFolder -File | Where-Object  {(Get-Date).AddDays(-$LastModified) -le $_.LastWriteTime}
    }
     
     
    
 
    

      foreach ($SourceFile in $GetSourceFiles)
      { 
       
        try
        {
          Move-Item -Path $sourceFile.FullName -Destination  (Join-Path -Path $TargetFolder -ChildPath ($sourceFile.Name)) -ErrorAction Stop  
          New-Item -ItemType SymbolicLink -Path $sourceFile.FullName  -Target (Join-Path -Path $TargetFolder -ChildPath ($sourceFile.Name))      
        }
        catch
        {
          Write-Warning -Message "Cannot create file $sourceFile.name, file already exists!"
        }    
             

      }

    }
        
  
  

  Move-FilesReplaceWithLinks -SourceFolder C:\Powershell\TestFolder1 -Recurse -TargetFolder C:\Powershell\TestFolder3 -LastModified 6
