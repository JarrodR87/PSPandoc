function Invoke-PandocDL {
    <#
        .SYNOPSIS
            Downloads the latest release of Pandoc from GitHub
        .DESCRIPTION
            Downloads the Zipped version of the latest release of Pandoc from GitHub
        .PARAMETER Path
            Path to save the Zip file to
        .EXAMPLE
            Invoke-PandocDL -Path 'C:\Temp'
    #>
    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory = $true)]$Path
    )
    BEGIN {        
        $Path = $Path.Trimend('\')
        $Path = $Path + '\'


        $Pandoc = invoke-restmethod 'https://api.github.com/repos/jgm/pandoc/releases/latest'
        $PandocW64Zip = $Pandoc.assets | Where-Object -FilterScript { $_.name -like '*Windows*64*zip*' }
        $DownloadLink = $PandocW64Zip.browser_download_url
        $DLPath = $Path + $PandocW64Zip.name
    } #BEGIN


    PROCESS {
        Invoke-WebRequest $DownloadLink -OutFile $DLPath
    } #PROCESS

    END { 

    } #END

} #FUNCTION