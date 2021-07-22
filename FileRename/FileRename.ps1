<#
.SYNOPSIS
	.
.DESCRIPTION
	.
.PARAMETER Path
	.
.PARAMETER LiteralPath
	.
.EXAMPLE
	.
.NOTES
    Author: FIN392 - fin392@gmail.com
#>
[version]$ScriptVersion = "1.2.3.4"
[uri]$ScriptURI = "https://raw.githubusercontent.com/FIN392/My-Messy-Junk-drawer/main/PowerShell/FileRename/FileRename.ps1?token=APAZGJQPIWEJU2YWFA5FKSLA7BWVO"
[guid]$ScriptGUID = "f778fc3c-f29c-4704-8b9f-0d86b5c6a492"



# Get script version in URL
# [version]$URLScriptVersion = Get-URLScriptVersion -URL $ScriptURI.AbsoluteUri
[version]$URLScriptVersion = "2.2.3.4"

# If newer then download and install
if ( $URLScriptVersion -gt $ScriptVersion ) {

	Write-Host "Download and install"
	$TempFile = "$env:temp\$($ScriptURI.AbsolutePath | Split-Path  -leaf)"
	Invoke-WebRequest -Uri $ScriptURI.AbsoluteUri -OutFile $TempFile
	
	
}






