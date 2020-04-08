




# Initialize-xLog [-LogID] <string> [-File] <string> [-Format] {TXT | CSV | XML | HTML | JSON} [-UTC]
function Initialize-xLog {
<# 
    .SYNOPSIS
        Initialize a log file.

    .DESCRIPTION
        A global variable with name 'xLogID_+{Log ID}' is created with information to be used by functions 'Write-xLog' and 'Close-xLog'.
        This global variable is an array with 3 values:
            - Log file name
            - Log format
            - UTC value
        The specified file is created (including the full path if necessary) and first headers lines are written in.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER LogID
        A name that will identify the log.
        Mandatory.
        Example: 'Log01', 'MasterLog', 'LogTransactions', etc.

    .PARAMETER File
        File name where log entries will be written.
        ATTENTION: If the file already exists will be overwritten without notice.
        Mandatory.
        Example: 'C:\TEMP\Log.xt', '\\SERVER\SHARE\output.html', 'C:\Apps\Events.json', etc.

    .PARAMETER Format
        Log file format.
        It can be:
            TXT   To be seen on a console.
            CSV   To be exported to other applications.
            XML   To be managed by XML viewers.
            HTML  To be displayed on a web browser.
            JSON  To exchange infomation with Java applications.
        Mandatory.

    .PARAMETER UTC
        Establish what will be the time zone and format of the timestamp.
        If UTC parameter is present, timestamp will be on UTC time zone (aka Zulu time) and format ISO 8601, '{yyyyMMdd}T{HHmmssffff}Z'.
        Otherwise timestamp will be on local time zone and format '{yyyy}-{MM}-{dd} {HH}:{mm}:{ss}.{ffff}'. Column header will include the time zone. For example '(UTC+02:00)'.
        Optional.

    .INPUTS
        None.

    .OUTPUTS
        Log file created and global variable defined.

    .EXAMPLE
        Initialize-xLog -LogID MasterLog -File '.\Logs\20200407.txt' -Format TXT
        Create a log file named '20200407.txt' on folder '.\Logs'.
        Add header with this format:
            Timestamp (UTC+02:00)    Severity Message                                      
            ------------------------ -------- ---------------------------------------------
            2020-04-07 22:51:18.4794 DEBUG    This is a debug text                         
            2020-04-07 22:51:18.4904 INFO     This is a information text                   
            2020-04-07 22:51:18.5014 WARN     This is a warning text                       
            2020-04-07 22:51:18.5374 ERROR    This is a information long text with many cha
                                              racters and many information                 
            2020-04-07 22:51:18.5604 FATAL    This is an error text                        
            ------------------------ -------- ---------------------------------------------

    .EXAMPLE
        Initialize-xLog -LogID LogProcess01 -File 'C:\Outputs\Process01.csv' -Format CSV -UTC
        Create a log file named 'Process01.csv' on folder 'C:\Outputs'.
        Add header with this format:
            "Timestamp","Severity","Message"
            "20200405T2356267118Z","DEBUG","This is a debug text"
            "20200405T2356267338Z","INFO","This is a information text"
            "20200405T2356267558Z","WARN","This is a warning text"
            "20200405T2356267788Z","ERROR","This is a information long text with many characters and many information"
            "20200405T2356268028Z","FATAL","This is an error text"
            "","","***EOF***"

    .EXAMPLE
        Initialize-xLog -LogID ERRORS -File '.\ErrorLog.xml' -Format XML -UTC
        Create a log file named 'ErrorLog.xml' on current folder.
        Add header with this format:
            <?xml version="1.0"?>
            <Log>
	            <Entry><Timestamp>20200405T2356269568Z</Timestamp><Severity>DEBUG</Severity><Message>This is a debug text</Message></Entry>
	            <Entry><Timestamp>20200405T2356269808Z</Timestamp><Severity>INFO</Severity><Message>This is a information text</Message></Entry>
	            <Entry><Timestamp>20200405T2356270048Z</Timestamp><Severity>WARN</Severity><Message>This is a warning text</Message></Entry>
	            <Entry><Timestamp>20200405T2356270318Z</Timestamp><Severity>ERROR</Severity><Message>This is a information long text with many characters and many information</Message></Entry>
	            <Entry><Timestamp>20200405T2356270598Z</Timestamp><Severity>FATAL</Severity><Message>This is an error text</Message></Entry>
            </Log>

    .EXAMPLE
        Initialize-xLog -LogID L001 -File '\\THOR\APPS\Logs\001.html' -Format HTML
        Create a log file named '001.html' on folder '\\THOR\APPS\Logs'.
        Add header with this format:
            <!DOCTYPE html>
            <html>
	            <head>
		            <style>
			            table, th, td {border:1px solid black;border-collapse:collapse;}
			            th, td {padding:5px;text-align:left;}
		            </style>
	            </head>
	            <body>
		            <table>
			            <tr><th>Timestamp (UTC+02:00)</th><th>Severity</th><th>Message</th></tr>
			            <tr><td>2020-04-06 01:56:27.1558</td><td style="background-color:Green;">DEBUG</td><td>This is a debug text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2028</td><td style="background-color:Green;">INFO</td><td>This is a information text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2428</td><td style="background-color:Yellow;">WARN</td><td>This is a warning text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2878</td><td style="background-color:Red;">ERROR</td><td>This is a information long text with many characters and many information</td></tr>
			            <tr><td>2020-04-06 01:56:27.3168</td><td style="background-color:Red;">FATAL</td><td>This is an error text</td></tr>
		            </table>
	            </body>
            </html>

    .EXAMPLE
        Initialize-xLog -LogID GeneralLog -File 'X:\EXIT\OUT.json' -Format JSON -UTC
        Create a log file named 'OUT.json' on folder 'X:\EXIT'.
        Add header with this format:
            [
                {"Timestamp":"20200405T2356276228Z","Severity":"DEBUG","Message":"This is a debug text"},
                {"Timestamp":"20200405T2356276658Z","Severity":"INFO","Message":"This is a information text"},
                {"Timestamp":"20200405T2356276888Z","Severity":"WARN","Message":"This is a warning text"},
                {"Timestamp":"20200405T2356277158Z","Severity":"ERROR","Message":"This is a information long text with many characters and many information"},
                {"Timestamp":"20200405T2356277338Z","Severity":"FATAL","Message":"This is an error text"},
            ]

    .LINK
        https://github.com/FIN392/PowerShell

    .NOTES
        Author: FIN392
        Last Edit: 2020-04-07
        Version 1.0 - Iinitial release
#>
    [CmdletBinding()]
    param (
        [Parameter ( Mandatory=$true, Position=1 )][ValidateScript({
            if( (Test-Path variable:xLogID_$_) ){
                throw "LogID already initialized"
            }
            return $true
        })][String]$LogID,
        [Parameter ( Mandatory=$true, Position=2 )][ValidateScript({
            if( -Not ($_ | Test-Path -IsValid) ){
                throw "Path name is not valid"
            }
            return $true
        })][String]$File,
        [Parameter ( Mandatory=$true, Position=3 )][ValidateSet('TXT','CSV','XML','HTML','JSON')][String]$Format,
        [Parameter ( Mandatory=$false,Position=4 )][Switch]$UTC
    )

    Write-Verbose ( 'Initializing log ' + $LogID + '...' )

    # Create xLogID_ variable 
    New-Variable -Name xLogID_$LogID -Value @($File,$Format,$UTC) -Scope Global -Force

    # Get xLogID_ variable 
    $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Create folder
    if ( -Not ( Test-Path -Path ( split-path -Path ($LogInfo[0]) -Parent ) ) ) {
        [void]( New-Item -ItemType Directory -Force -Path (split-path -Path $LogInfo[0] -Parent) )
        Write-Verbose ( '    Created path "' + (split-path -Path $LogInfo[0] -Parent) + '"' )
    }
    
    # Create file
    if ( -Not (Test-Path -Path $LogInfo[0]) ) {
        [void]( New-Item -Path (split-path -Path $LogInfo[0] -Parent) -Name (split-path -Path $LogInfo[0] -Leaf) -ItemType 'file' )
        Write-Verbose ( '    Created file "' + (split-path -Path $LogInfo[0] -Leaf) + '"' )
    }

    Write-Verbose ( '    Set log file to "' + (Resolve-Path -Path $LogInfo[0]) + '"' )

    # Set TimestampHeader
    $TimestampHeader = 'Timestamp' + ( &{ If( -Not $LogInfo[2] ) { ' ' + (Get-Date -Format '(UTCK)') } } )
    
    # Add headers to the file based on type of log
    switch ( $LogInfo[1].ToUpper() ) {
        'TXT'   {
            Out-File -FilePath $LogInfo[0]         -InputObject ( $TimestampHeader.PadRight(24) + ' Severity Message' + " "*38 )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
        }
        'CSV'   {
            Out-File -FilePath $LogInfo[0]         -InputObject ( '"' + $TimestampHeader + '","Severity","Message"' )
        }
        'XML'   {
            Out-File -FilePath $LogInfo[0]         -InputObject ( '<?xml version="1.0"?>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '<Log>' )
        }
        'HTML'  {
            Out-File -FilePath $LogInfo[0]         -InputObject ( '<!DOCTYPE html>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '<html>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '	<head>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '		<style>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '			table, th, td {border:1px solid black;border-collapse:collapse;}' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '			th, td {padding:5px;text-align:left;}' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '		</style>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '	</head>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '	<body>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '		<table>' )
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( '			<tr><th>' + $TimestampHeader + '</th><th>Severity</th><th>Message</th></tr>' )
        }
        'JSON'   {
            Out-File -FilePath $LogInfo[0]         -InputObject ('[')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Added ' + $LogInfo[1].ToUpper() + ' headers to log file "' + $LogInfo[0] + '"' )

    Write-Verbose ( '    Log ' + $LogID + ' initialized' )

}
Export-ModuleMember -Function Initialize-xLog



# Write-xLog [-LogID] <string> [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] <string> [-Console]
function Write-xLog {
<# 
    .SYNOPSIS
        Write a message in a log file.

    .DESCRIPTION
        A new entry is appended to the log file with following information: timestamp (Local time or UTC based on -UTC parameter during initialation), severety and message.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER LogID
        A name that will identify the log.
        Mandatory.
        Example: 'Log01', 'MasterLog', 'LogTransactions', etc.

    .PARAMETER Severity
        Type of log entry to be added:
                DEBUG: Fine-grained informational events that are most useful to debug an application.
                INFO: Informational messages that highlight the progress of the application at coarse-grained level.
                WARN: Potentially harmful situations.
                ERROR: Error events that might still allow the application to continue running.
                FATAL: Very severe error events that will presumably lead the application to abort.
        Mandatory.

    .PARAMETER Message
        Description of the event.
        Mandatory.

    .PARAMETER Console
        Establish if the entry should be displayed on console.
        Message will be displayed in the following format:
            2020-04-08 07:27:31.7145 | DEBUG | This is a debug text
            2020-04-08 07:27:31.7334 | INFO  | This is a information text
            2020-04-08 07:27:31.7524 | WARN  | This is a warning text
            2020-04-08 07:27:31.7665 | ERROR | This is a information long text with many characters and many information
            2020-04-08 07:27:31.8014 | FATAL | This is an error text
        Severity is shown in color.
        Optional.

    .INPUTS
        None.

    .OUTPUTS
        New line added to log file.

    .EXAMPLE
        Write-xLog -LogID MasterLog -Severity DEBUG -Message 'This is a debug text' -Console
        Display this line on console:
            2020-04-07 22:51:18.4794 | DEBUG | This is a debug text
        Add a line with this format:
            Timestamp (UTC+02:00)    Severity Message                                      
            ------------------------ -------- ---------------------------------------------
            2020-04-07 22:51:18.4794 DEBUG    This is a debug text                         
            2020-04-07 22:51:18.4904 INFO     This is a information text                   
            2020-04-07 22:51:18.5014 WARN     This is a warning text                       
            2020-04-07 22:51:18.5374 ERROR    This is a information long text with many cha
                                              racters and many information                 
            2020-04-07 22:51:18.5604 FATAL    This is an error text                        
            ------------------------ -------- ---------------------------------------------

    .EXAMPLE
        Write-xLog -LogID LogProcess01 -Severity INFO -Message 'This is a information text'
        Add a line with this format:
            "Timestamp","Severity","Message"
            "20200405T2356267118Z","DEBUG","This is a debug text"
            "20200405T2356267338Z","INFO","This is a information text"
            "20200405T2356267558Z","WARN","This is a warning text"
            "20200405T2356267788Z","ERROR","This is a information long text with many characters and many information"
            "20200405T2356268028Z","FATAL","This is an error text"
            "","","***EOF***"

    .EXAMPLE
        Write-xLog -LogID ERRORS -Severity WARN -Message 'This is a warning text' -Console
        Display this line on console:
            2020-04-05 23:56:27.0048 | WARN  | This is a warning text
        Add a line with this format:
            <?xml version="1.0"?>
            <Log>
	            <Entry><Timestamp>20200405T2356269568Z</Timestamp><Severity>DEBUG</Severity><Message>This is a debug text</Message></Entry>
	            <Entry><Timestamp>20200405T2356269808Z</Timestamp><Severity>INFO</Severity><Message>This is a information text</Message></Entry>
	            <Entry><Timestamp>20200405T2356270048Z</Timestamp><Severity>WARN</Severity><Message>This is a warning text</Message></Entry>
	            <Entry><Timestamp>20200405T2356270318Z</Timestamp><Severity>ERROR</Severity><Message>This is a information long text with many characters and many information</Message></Entry>
	            <Entry><Timestamp>20200405T2356270598Z</Timestamp><Severity>FATAL</Severity><Message>This is an error text</Message></Entry>
            </Log>

    .EXAMPLE
        Write-xLog -LogID L001 -Severity ERROR -Message 'This is a information long text with many characters and many information'
        Add a line with this format:
            <!DOCTYPE html>
            <html>
	            <head>
		            <style>
			            table, th, td {border:1px solid black;border-collapse:collapse;}
			            th, td {padding:5px;text-align:left;}
		            </style>
	            </head>
	            <body>
		            <table>
			            <tr><th>Timestamp (UTC+02:00)</th><th>Severity</th><th>Message</th></tr>
			            <tr><td>2020-04-06 01:56:27.1558</td><td style="background-color:Green;">DEBUG</td><td>This is a debug text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2028</td><td style="background-color:Green;">INFO</td><td>This is a information text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2428</td><td style="background-color:Yellow;">WARN</td><td>This is a warning text</td></tr>
			            <tr><td>2020-04-06 01:56:27.2878</td><td style="background-color:Red;">ERROR</td><td>This is a information long text with many characters and many information</td></tr>
			            <tr><td>2020-04-06 01:56:27.3168</td><td style="background-color:Red;">FATAL</td><td>This is an error text</td></tr>
		            </table>
	            </body>
            </html>

    .EXAMPLE
        Write-xLog -LogID GeneralLog -Severity FATAL -Message 'This is an error text'
        Add a line with this format:
            [
                {"Timestamp":"20200405T2356276228Z","Severity":"DEBUG","Message":"This is a debug text"},
                {"Timestamp":"20200405T2356276658Z","Severity":"INFO","Message":"This is a information text"},
                {"Timestamp":"20200405T2356276888Z","Severity":"WARN","Message":"This is a warning text"},
                {"Timestamp":"20200405T2356277158Z","Severity":"ERROR","Message":"This is a information long text with many characters and many information"},
                {"Timestamp":"20200405T2356277338Z","Severity":"FATAL","Message":"This is an error text"},
            ]

    .LINK
        https://github.com/FIN392/PowerShell

    .NOTES
        Author: FIN392
        Last Edit: 2020-04-07
        Version 1.0 - Iinitial release
#>
    [CmdletBinding()]
    param (
        [Parameter ( Mandatory=$true, Position=1 )][String]$LogID,
        [Parameter ( Mandatory=$true, Position=2 )][ValidateSet('DEBUG','INFO','WARN','ERROR','FATAL')][String]$Severity,
        [Parameter ( Mandatory=$true, Position=3 )][String]$Message,
        [Parameter ( Mandatory=$false,Position=4 )][Switch]$Console
    )

    Write-Verbose ( 'Adding entry to log ' + $LogID + '...' )

    # Get xLogID_ variable 
    $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Set color based in severity
    $EntryColor = switch ( $Severity ) {
        'DEBUG' { 'Green' }
        'INFO'  { 'Green' }
        'WARN'  { 'Yellow' }
        'ERROR' { 'Red' }
        'FATAL' { 'Red' }
        Default { Write-Error ('"' + $_ + '" is not a valid log severity') }
    }

    # Write text in console (if set)
    if ( $Console ) {
        Write-Host ( ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) + ' | ' ) -NoNewline
        Write-Host ( '{0,-5}' -f $Severity ) -NoNewline -ForegroundColor $EntryColor
        Write-Host ( ' | ' + $Message )
    }

    # Set TimestampHeader
    $TimestampHeader = 'Timestamp' + ( &{ If( -Not $LogInfo[2] ) { ' ' + (Get-Date -Format '(UTCK)') } } )

    # Set TimestampString
    $TimestampString = ( &{ If( -Not $LogInfo[2] ) { ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) } else { ( Get-Date -Format FileDateTimeUniversal ) } } )
    
    # Add text formated based on type of log
    switch ( $LogInfo[1].ToUpper() ) {
        'TXT'   {
            $Line = $TimestampString.PadRight(24) + ' ' + $Severity.PadRight(8) + ' ' + ($Message+" "*45).Substring(0,45)
            Out-File -FilePath $LogInfo[0] -Append -InputObject $Line
            for($i=1; $i*45 -le $Message.Length; $i++){
                $Line = ((" "*34)+($Message+" "*45).Substring($i*45,45))
                Out-File -FilePath $LogInfo[0] -Append -InputObject $line
            }
        }
        'CSV'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('"' + $TimestampString + '","' + $Severity + '","' + $Message + '"')
        }
        'XML'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('	<Entry><' + $TimestampHeader + '>' + $TimestampString + '</Timestamp><Severity>' + $Severity + '</Severity><Message>' + $Message + '</Message></Entry>')
        }
        'HTML'  {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('			<tr><td>' + $TimestampString + '</td><td style="background-color:' + $EntryColor + ';">' + $Severity + '</td><td>' + $Message + '</td></tr>')
        }
        'JSON'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('	{"' + $TimestampHeader + '":"' + $TimestampString + '","Severity":"' + $Severity + '","Message":"' + $Message + '"},')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Entry added to log ' + $LogID )

}
Export-ModuleMember -Function Write-xLog



# Close-xLog [-LogID] <string>
function Close-xLog {
<# 
    .SYNOPSIS
        Close a log file.

    .DESCRIPTION
        The global variable with name 'xLogID_+{Log ID}' is deleted.
        Footer lines are written in the log file.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER LogID
        A name that will identify the log.
        Mandatory.
        Example: 'Log01', 'MasterLog', 'LogTransactions', etc.

    .INPUTS
        None.

    .OUTPUTS
        Footer lines are written in the log file.

    .EXAMPLE
        Close-xLog -LogID MasterLog
        Add footer lines to log file.

    .LINK
        https://github.com/FIN392/PowerShell

    .NOTES
        Author: FIN392
        Last Edit: 2020-04-07
        Version 1.0 - Iinitial release
#>
    [CmdletBinding()]
    param (
        [Parameter ( Mandatory=$true, Position=1 )][String]$LogID
    )

    Write-Verbose ( 'Closing log ' + $LogID + '...' )

    # Get xLogID_ variable 
    $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Add footer based on type of log
    switch ( $LogInfo[1].ToUpper() ) {
        'TXT'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
        }
        'CSV'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('"","","***EOF***"')
        }
        'XML'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('</Log>')
        }
        'HTML'  {
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('		</table>')
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('	</body>')
            Out-File -FilePath $LogInfo[0] -Append -InputObject ('</html>')
        }
        'JSON'   {
            Out-File -FilePath $LogInfo[0] -Append -InputObject (']')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Added ' + $LogInfo[1].ToUpper() + ' footer to log file "' + $LogInfo[0] + '"' )

    # Remove xLogID_ variable 
    Remove-Variable -Name xLogID_$LogID -Scope Global

    Write-Verbose ( '    Log ' + $LogID + ' closed' )

}
Export-ModuleMember -Function Close-xLog


