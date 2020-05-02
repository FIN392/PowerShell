
enum Format {
    TXT
    CSV
    XML
    HTML
    JSON
}

enum Severity {
    DEBUG
    INFO
    WARN
    ERROR
    FATAL
}

class xLog {
    Hidden [boolean]$IsOpen = $false
    [string]$File
    [Format]$Format
    [boolean]$UTC
    [boolean]$Console

    # 
    # Open
    # 
    Open(
        [string]$File,
        [Format]$Format,
        [boolean]$UTC,
        [boolean]$Console
    ){

        if ( $this.IsOpen ){
            Write-Error 'This xLog is already open'
        } else {
            
            $this.IsOpen = $true
            $this.File = $File
            $this.Format = $Format
            $this.UTC = $UTC
            $this.Console = $Console
    
            # Create folder
            if ( -Not ( Test-Path -Path ( split-path -Path ($this.File) -Parent ) ) ) {
                [void]( New-Item -ItemType Directory -Force -Path (split-path -Path $this.File -Parent) )
                Write-Verbose ( '    Created path "' + (split-path -Path $this.File -Parent) + '"' )
            }
            
            # Create file
            if ( -Not (Test-Path -Path $this.File) ) {
                [void]( New-Item -Path (split-path -Path $this.File -Parent) -Name (split-path -Path $this.File -Leaf) -ItemType 'file' )
                Write-Verbose ( '    Created file "' + (split-path -Path $this.File -Leaf) + '"' )
            }

            Write-Verbose ( '    Set log file to "' + (Resolve-Path -Path $this.File) + '"' )

            # Set TimestampHeader
            $TimestampHeader = 'Timestamp' + ( &{ If( -Not $this.UTC ) { ' ' + (Get-Date -Format '(UTCK)') } } )
            
            # Add headers to the file based on type of log
            switch ( $this.Format ) {
                'TXT'   {
                    Out-File -FilePath $this.File         -InputObject ( $TimestampHeader.PadRight(24) + ' Severity Message' + " "*38 )
                    Out-File -FilePath $this.File -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
                }
                'CSV'   {
                    Out-File -FilePath $this.File         -InputObject ( '"' + $TimestampHeader + '","Severity","Message"' )
                }
                'XML'   {
                    Out-File -FilePath $this.File         -InputObject ( '<?xml version="1.0"?>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '<Log>' )
                }
                'HTML'  {
                    Out-File -FilePath $this.File         -InputObject ( '<!DOCTYPE html>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '<html>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '	<head>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '		<style>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '			table, th, td {border:1px solid black;border-collapse:collapse;}' )
                    Out-File -FilePath $this.File -Append -InputObject ( '			th, td {padding:5px;text-align:left;}' )
                    Out-File -FilePath $this.File -Append -InputObject ( '		</style>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '	</head>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '	<body>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '		<table>' )
                    Out-File -FilePath $this.File -Append -InputObject ( '			<tr><th>' + $TimestampHeader + '</th><th>Severity</th><th>Message</th></tr>' )
                }
                'JSON'   {
                    Out-File -FilePath $this.File         -InputObject ('[')
                }
                default { Write-Error ('"' + $_ + '" is not a valid log format') }
            }

            Write-Verbose ( '    Added ' + $this.Format + ' headers to log file "' + $this.File + '"' )

            Write-Verbose ( '    Log opened' )

        }

    }

    # 
    # Write
    # 
    [void] Write(
        [Severity]$Severity,
        [string]$Message
    ){
        if ( $this.IsOpen ){

            Write-Verbose ( 'Adding entry to log ' + $this.File + '...' )

            # Set color based in severity
            $EntryColor = switch ( $Severity ) {
                'DEBUG' { 'Blue' }
                'INFO'  { 'Green' }
                'WARN'  { 'Yellow' }
                'ERROR' { 'Red' }
                'FATAL' { 'Red' }
                Default { Write-Error ('"' + $_ + '" is not a valid log severity') }
            }
        
            # Write text in console (if set)
            if ( $this.Console ) {
                Write-Host ( ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) + ' | ' ) -NoNewline
                Write-Host ( '{0,-5}' -f $Severity ) -NoNewline -ForegroundColor $EntryColor
                Write-Host ( ' | ' + $Message )
            }
        
            # Set TimestampHeader
            $TimestampHeader = 'Timestamp' + ( &{ If( -Not $this.UTC ) { ' ' + (Get-Date -Format '(UTCK)') } } )
        
            # Set TimestampString
            $TimestampString = ( &{ If( -Not $this.UTC ) { ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) } else { ( Get-Date -Format FileDateTimeUniversal ) } } )
            
            # Add text formated based on type of log
            switch ( $this.Format ) {
                'TXT'   {
                    $Line = $TimestampString.PadRight(24) + ' ' + $Severity.ToString().PadRight(8) + ' ' + ($Message+" "*45).Substring(0,45)
                    Out-File -FilePath $this.File -Append -InputObject $Line
                    for($i=1; $i*45 -le $Message.Length; $i++){
                        $Line = ((" "*34)+($Message+" "*45).Substring($i*45,45))
                        Out-File -FilePath $this.File -Append -InputObject $line
                    }
                }
                'CSV'   {
                    Out-File -FilePath $this.File -Append -InputObject ('"' + $TimestampString + '","' + $Severity + '","' + $Message + '"')
                }
                'XML'   {
                    Out-File -FilePath $this.File -Append -InputObject ('	<Entry><' + $TimestampHeader + '>' + $TimestampString + '</Timestamp><Severity>' + $Severity + '</Severity><Message>' + $Message + '</Message></Entry>')
                }
                'HTML'  {
                    Out-File -FilePath $this.File -Append -InputObject ('			<tr><td>' + $TimestampString + '</td><td style="background-color:' + $EntryColor + ';">' + $Severity + '</td><td>' + $Message + '</td></tr>')
                }
                'JSON'   {
                    Out-File -FilePath $this.File -Append -InputObject ('	{"' + $TimestampHeader + '":"' + $TimestampString + '","Severity":"' + $Severity + '","Message":"' + $Message + '"},')
                }
                default { Write-Error ('"' + $_ + '" is not a valid log format') }
            }
        
            Write-Verbose ( '    Entry added to log' )

        } else {
            Write-Error 'This xLog is not open'
        }
    }

    # 
    # Close
    # 
    Close(){

        if ( $this.IsOpen ){

            Write-Verbose ( 'Closing log ' + $this.File + '...' )

            # Add footer based on type of log
            switch ( $this.Format ) {
                'TXT'   {
                    Out-File -FilePath $this.File -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
                }
                'CSV'   {
                    Out-File -FilePath $this.File -Append -InputObject ('"","","***EOF***"')
                }
                'XML'   {
                    Out-File -FilePath $this.File -Append -InputObject ('</Log>')
                }
                'HTML'  {
                    Out-File -FilePath $this.File -Append -InputObject ('		</table>')
                    Out-File -FilePath $this.File -Append -InputObject ('	</body>')
                    Out-File -FilePath $this.File -Append -InputObject ('</html>')
                }
                'JSON'   {
                    Out-File -FilePath $this.File -Append -InputObject (']')
                }
                default { Write-Error ('"' + $_ + '" is not a valid log format') }
            }
        
            Write-Verbose ( '    Added ' + $this.Format + ' footer to log file "' + $this.File + '"' )

            Write-Verbose ( '    Log closed' )

            $this.IsOpen = $false            

        } else {
            Write-Error 'This xLog is not open'
        }
    }

}

$MyLogTXT = [xLog]::new()
$MyLogCSV = [xLog]::new()
$MyLogXML = [xLog]::new()
$MyLogHTML = [xLog]::new()
$MyLogJSON = [xLog]::new()

$MyLogTXT.Open( '.\Logs\xLog.txt', 'TXT', $false, $false )
$MyLogCSV.Open( '.\Logs\xLog.csv', 'CSV', $false, $true )
$MyLogXML.Open( '.\Logs\xLog.xml', 'XML', $true, $false )
$MyLogHTML.Open( '.\Logs\xLog.html', 'HTML', $true, $true )
$MyLogJSON.Open( '.\Logs\xLog.json', 'JSON', $false, $false )

$MyLogTXT.Write( 'DEBUG', 'This is the text message' )
$MyLogCSV.Write( 'DEBUG', 'This is the text message' )
$MyLogXML.Write( 'DEBUG', 'This is the text message' )
$MyLogHTML.Write( 'DEBUG', 'This is the text message' )
$MyLogJSON.Write( 'DEBUG', 'This is the text message' )

$MyLogTXT.Write( 'INFO', 'This is the text message' )
$MyLogCSV.Write( 'INFO', 'This is the text message' )
$MyLogXML.Write( 'INFO', 'This is the text message' )
$MyLogHTML.Write( 'INFO', 'This is the text message' )
$MyLogJSON.Write( 'INFO', 'This is the text message' )

$MyLogTXT.Write( 'WARN', 'This is a entry with a text message too long for a single line' )
$MyLogCSV.Write( 'WARN', 'This is a entry with a text message too long for a single line' )
$MyLogXML.Write( 'WARN', 'This is a entry with a text message too long for a single line' )
$MyLogHTML.Write( 'WARN', 'This is a entry with a text message too long for a single line' )
$MyLogJSON.Write( 'WARN', 'This is a entry with a text message too long for a single line' )

$MyLogTXT.Write( 'ERROR', 'This is the text message' )
$MyLogCSV.Write( 'ERROR', 'This is the text message' )
$MyLogXML.Write( 'ERROR', 'This is the text message' )
$MyLogHTML.Write( 'ERROR', 'This is the text message' )
$MyLogJSON.Write( 'ERROR', 'This is the text message' )

$MyLogTXT.Write( 'FATAL', 'This is the text message' )
$MyLogCSV.Write( 'FATAL', 'This is the text message' )
$MyLogXML.Write( 'FATAL', 'This is the text message' )
$MyLogHTML.Write( 'FATAL', 'This is the text message' )
$MyLogJSON.Write( 'FATAL', 'This is the text message' )

$MyLogTXT.Close()
$MyLogCSV.Close()
$MyLogXML.Close()
$MyLogHTML.Close()
$MyLogJSON.Close()


# $MyLog.Open( '.\any.csv', 'CSV', $true, $true )
# $MyLog.Open( '.\any.csv', 'CSV', $true, $true )

# $MyLog.Close()
# $MyLog.Close()

# $MyLog.Write( 'DEBUG', 'This is the text message' )

# $MyLog | Get-Member







