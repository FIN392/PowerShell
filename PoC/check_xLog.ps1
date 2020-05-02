Import-Module -Name '.\xLogClass.ps1' -Force


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







