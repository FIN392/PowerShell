xLog is a PowerShell module to create log files.

Multiple logs files can be created in a script at the same time and in multiple formats. Additionaly the entry can be displayed in console (host).

First, the module needs to be imported:

    Import-Module -Name '.\xLog.psm1' -Force

Then log should be initialized. At this stage log identification name, filename, format and timestamp format should be defined.

    Initialize-xLog -LogID LOG01 -File '.\Logs\Log_TXT.txt' -Format TXT -UTC

At the end of this document examples of each file format can be found.

Once initialized, entries can be added as required:

    Write-xLog -LogID LOG01 -Console -Severity DEBUG -Message 'This is a debug text'
    Write-xLog -LogID LOG01 -Console -Severity INFO  -Message 'This is a information text'
    Write-xLog -LogID LOG01 -Console -Severity WARN  -Message 'This is a warning text'
    Write-xLog -LogID LOG01 -Console -Severity ERROR -Message 'This is a error long text with many characters and many information'
    Write-xLog -LogID LOG01 -Console -Severity FATAL -Message 'This is an fatal text'

Finally, the log should be closed. This step is required because foot lines are added and some file format could be not valid without those lines (for example HTML files).

    Close-xLog -LogID LOG01

If there are not more scripts running in the session, the module can be removed.

    Remove-Module -Name xLog -Force

ENJOY IT!!! and please contact me for any doubt or improvement proposal.

************************
* FILE FORMAT EXAMPLES *
************************

*
* TXT (with timestamp in local time)
*

Timestamp (UTC+02:00)    Severity Message                                      
------------------------ -------- ---------------------------------------------
2020-04-08 11:01:31.8987 DEBUG    This is a debug text                         
2020-04-08 11:01:31.9277 INFO     This is a information text                   
2020-04-08 11:01:31.9527 WARN     This is a warning text                       
2020-04-08 11:01:31.9797 ERROR    This is a error long text with many character
                                  s and many information                       
2020-04-08 11:01:32.0267 FATAL    This is an fatal text                        
------------------------ -------- ---------------------------------------------

*
* CSV (with UTC timestamp)
*

"Timestamp","Severity","Message"
"20200408T0901323177Z","DEBUG","This is a debug text"
"20200408T0901323417Z","INFO","This is a information text"
"20200408T0901323727Z","WARN","This is a warning text"
"20200408T0901323957Z","ERROR","This is a error long text with many characters and many information"
"20200408T0901324287Z","FATAL","This is an fatal text"
"","","***EOF***"

*
* XML (with UTC timestamp)
*

<?xml version="1.0"?>
<Log>
	<Entry><Timestamp>20200408T0901326117Z</Timestamp><Severity>DEBUG</Severity><Message>This is a debug text</Message></Entry>
	<Entry><Timestamp>20200408T0901326467Z</Timestamp><Severity>INFO</Severity><Message>This is a information text</Message></Entry>
	<Entry><Timestamp>20200408T0901326788Z</Timestamp><Severity>WARN</Severity><Message>This is a warning text</Message></Entry>
	<Entry><Timestamp>20200408T0901327167Z</Timestamp><Severity>ERROR</Severity><Message>This is a error long text with many characters and many information</Message></Entry>
	<Entry><Timestamp>20200408T0901327448Z</Timestamp><Severity>FATAL</Severity><Message>This is an fatal text</Message></Entry>
</Log>

*
* HTML (with timestamp in local time)
* 

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
			<tr><td>2020-04-08 11:01:32.8028</td><td style="background-color:Green;">DEBUG</td><td>This is a debug text</td></tr>
			<tr><td>2020-04-08 11:01:32.8358</td><td style="background-color:Green;">INFO</td><td>This is a information text</td></tr>
			<tr><td>2020-04-08 11:01:32.8688</td><td style="background-color:Yellow;">WARN</td><td>This is a warning text</td></tr>
			<tr><td>2020-04-08 11:01:32.8997</td><td style="background-color:Red;">ERROR</td><td>This is a error long text with many characters and many information</td></tr>
			<tr><td>2020-04-08 11:01:32.9428</td><td style="background-color:Red;">FATAL</td><td>This is an fatal text</td></tr>
		</table>
	</body>
</html>

*
* JSON (with UTC timestamp)
*

[
	{"Timestamp":"20200408T0901339186Z","Severity":"DEBUG","Message":"This is a debug text"},
	{"Timestamp":"20200408T0901339416Z","Severity":"INFO","Message":"This is a information text"},
	{"Timestamp":"20200408T0901339666Z","Severity":"WARN","Message":"This is a warning text"},
	{"Timestamp":"20200408T0901339986Z","Severity":"ERROR","Message":"This is a error long text with many characters and many information"},
	{"Timestamp":"20200408T0901340316Z","Severity":"FATAL","Message":"This is an fatal text"},
]
