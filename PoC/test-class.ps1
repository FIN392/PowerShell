# param (
#     [Parameter ( Mandatory=$true, Position=2 )]
#         [ValidateScript({
#             if( -Not ($_ | Test-Path -IsValid) ){
#                 throw "Path name is not valid"
#             }
#             return $true
#         })]
#         [String]$File,
#     [Parameter ( Mandatory=$true, Position=3 )]
#         [ValidateSet('TXT','CSV','XML','HTML','JSON')]
#         [String]$Format,
#     [Parameter ( Mandatory=$false,Position=4 )]
#         [Switch]$UTC
# )



class xLog {
    [string]$File
    [ValidateSet('TXT','CSV','XML','HTML','JSON')][string]$Format
    [boolean]$UTC

    xlog(){
        Write-Host 'START (empty)'
    }

    xlog(
        [string]$File,
        [string]$Format,
        [boolean]$UTC
    ){
        $this.File = $File
        $this.Format = $Format
        $this.UTC = $UTC

        Write-Host 'START (with)'
    }

    Write(
        [string]$Severity,
        [string]$Message,
        [boolean]$Console
    ){
        Write-Host $Severity, $Message, $Console, $this.File, $this.Format, $this.UTC 
    }
}

$MyLog = [xLog]::new()
$MyLog.File = 'log.txt'
$MyLog.Format = 'TXT'
# $MyLog.UTC = $false

$OtherLog = [xLog]::new('other-log.csv','CSV',$true)

$MyLog.Write('DEBxxxUG','Texto de la entrada',$false)
$OtherLog.Write('DEBUG','Texto de la entrada',$false)

