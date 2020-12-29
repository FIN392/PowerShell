[CmdletBinding()]
Param (
	[Parameter(Mandatory=$True,Position=0)]
	[String]$AccessItem
)
$ErrorActionPreference = "SilentlyContinue"
If ($Error) {
	$Error.Clear()
}
$RepPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepPath = $RepPath.Trim()
$FinalReport = "$RepPath\NTFSPermission_Report.csv"
$ReportFile1 = "$RepPath\NTFSPermission_Report.txt"

If (!(Test-Path $AccessItem)) {
	Write-Host
	Write-Host "`t Item $AccessItem Not Found." -ForegroundColor "Yellow"
	Write-Host
}
Else {
	If (Test-Path $FinalReport) {
		Remove-Item $FinalReport
	}
	If (Test-Path $ReportFile1) {
		Remove-Item $ReportFile1
	}
	Write-Host
	Write-Host "`t Working. Please wait ... " -ForegroundColor "Yellow"
	Write-Host
	## -- Create The Report File
	$ObjFSO = New-Object -ComObject Scripting.FileSystemObject
	$ObjFile = $ObjFSO.CreateTextFile($ReportFile1, $True)
	$ObjFile.Write("NTFS Permission Set On -- $AccessItem `r`n")
	$ObjFile.Close()
	$ObjFile = $ObjFSO.CreateTextFile($FinalReport, $True)
	$ObjFile.Close()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ObjFSO) | Out-Null
	Remove-Variable ObjFile
	Remove-Variable ObjFSO
	If((Get-Item $AccessItem).PSIsContainer -EQ $True) {
		$Result = "ItemType -- Folder"
	}
	Else {
		$Result = "ItemType -- File"
	}
	$DT = Get-Date -Format F
	Add-Content $ReportFile1 -Value ("Report Created As On $DT")
	Add-Content $ReportFile1 "=================================================================="
	$Owner = (Get-Item -LiteralPath $AccessItem).GetAccessControl() | Select Owner
	$Owner = $($Owner.Owner)
	$Result = "$Result `t Owner -- $Owner"
	Add-Content $ReportFile1 "$Result `n"
	(Get-Item -LiteralPath $AccessItem).GetAccessControl() | Select * -Expand Access | Select IdentityReference, FileSystemRights, AccessControlType, IsInherited, InheritanceFlags, PropagationFlags | Export-CSV -Path "$RepPath\NTFSPermission_Report2.csv" -NoTypeInformation
	Add-Content $FinalReport -Value (Get-Content $ReportFile1)
	Add-Content $FinalReport -Value (Get-Content "$RepPath\NTFSPermission_Report2.csv")
	Remove-Item $ReportFile1
	Remove-Item "$RepPath\NTFSPermission_Report2.csv"
	Invoke-Item $FinalReport
}
If ($Error) {
	$Error.Clear()
}