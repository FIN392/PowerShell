$sXLSXPath = "C:\TEMP\TEST.XLSX"

$oExcel = New-Object -ComObject Excel.Application
$oExcel.Visible = $false
$oWorkbook = $oExcel.Workbooks.Add() # or $oWorkbook = $excel.Workbooks.Open($sXLSXPath)
$oWorksheet = $oWorkbook.Worksheets.Item(1)

# do work with Excel...
$oWorksheet.Cells.Item(1,1) = "HOLA"


$oWorkbook.SaveAs($sXLSXPath)
$oExcel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($oExcel)
# no $ needed on variable name in Remove-Variable call
Remove-Variable oExcel

