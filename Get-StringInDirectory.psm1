<#
.Synopsis
   Search for a string in a directory recursively
.DESCRIPTION
   This function will search all files in a directory recursively and then lists the path to the files that contain the string
.EXAMPLE
   Get-StringInDirectory -SearchLocation C:\temp -SearchPattern "Test123"
.EXAMPLE
   Get-StringInDirectory -SearchLocation C:\temp -SearchPattern "Test123*"
#>
function Get-StringInDirectory
{
    [CmdletBinding()]
    Param
    (
        # FilePath 
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   ValueFromRemainingArguments=$false, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path $_})]
        [string]$SearchLocation,
        
        # SearchString 
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$SearchPattern
    )

    Begin
    {
    }
    Process
    {
    #region Main Program
        # Select all items in the SearchLocation
        Get-ChildItem -Recurse `
                      -Path $SearchLocation | 
        # Select all items that contain the SearchPattern
        Select-String -pattern $SearchPattern | 
        # Group objects by path to remove multi instances in results
        Group-Object path | 
        # Show the name of the found objects
        Select-Object name
    #endregion
    }
    End
    {
    }
}
