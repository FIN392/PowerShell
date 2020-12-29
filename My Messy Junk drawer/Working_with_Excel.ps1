

# Open Excel
$Excel = New-Object -comobject Excel.Application

#  Make it visible
$Excel.Visible = $false
$excel.DisplayAlerts = $false

#  Create a workbook
$MyWorkbook = $Excel.Workbooks.Add()

# Create a worksheet
$MyWorksheet = $MyWorkbook.Worksheets.Add()
$MyWorksheet.Name = 'Processes'

# Header
$MyWorksheet.Cells.Item( 1,  1 ) = 'Name'
$MyWorksheet.Cells.Item( 1,  2 ) = 'Id'
$MyWorksheet.Cells.Item( 1,  3 ) = 'PriorityClass'
$MyWorksheet.Cells.Item( 1,  4 ) = 'FileVersion'
$MyWorksheet.Cells.Item( 1,  5 ) = 'HandleCount'
$MyWorksheet.Cells.Item( 1,  6 ) = 'WorkingSet'
$MyWorksheet.Cells.Item( 1,  7 ) = 'PagedMemorySize'
$MyWorksheet.Cells.Item( 1,  8 ) = 'PrivateMemorySize'
$MyWorksheet.Cells.Item( 1,  9 ) = 'VirtualMemorySize'
$MyWorksheet.Cells.Item( 1, 10 ) = 'TotalProcessorTime'
$MyWorksheet.Cells.Item( 1, 11 ) = 'SI'
$MyWorksheet.Cells.Item( 1, 12 ) = 'Handles'
$MyWorksheet.Cells.Item( 1, 13 ) = 'VM'
$MyWorksheet.Cells.Item( 1, 14 ) = 'WS'
$MyWorksheet.Cells.Item( 1, 15 ) = 'PM'
$MyWorksheet.Cells.Item( 1, 16 ) = 'NPM'
$MyWorksheet.Cells.Item( 1, 17 ) = 'Path'
$MyWorksheet.Cells.Item( 1, 18 ) = 'Parent'
$MyWorksheet.Cells.Item( 1, 19 ) = 'Company'
$MyWorksheet.Cells.Item( 1, 20 ) = 'CPU'
$MyWorksheet.Cells.Item( 1, 21 ) = 'ProductVersion'
$MyWorksheet.Cells.Item( 1, 22 ) = 'Description'
$MyWorksheet.Cells.Item( 1, 23 ) = 'Product'
$MyWorksheet.Cells.Item( 1, 24 ) = '__NounName'
$MyWorksheet.Cells.Item( 1, 25 ) = 'SafeHandle'
$MyWorksheet.Cells.Item( 1, 26 ) = 'Handle'
$MyWorksheet.Cells.Item( 1, 27 ) = 'BasePriority'
$MyWorksheet.Cells.Item( 1, 28 ) = 'ExitCode'
$MyWorksheet.Cells.Item( 1, 29 ) = 'HasExited'
$MyWorksheet.Cells.Item( 1, 30 ) = 'StartTime'
$MyWorksheet.Cells.Item( 1, 31 ) = 'ExitTime'
$MyWorksheet.Cells.Item( 1, 32 ) = 'MachineName'
$MyWorksheet.Cells.Item( 1, 33 ) = 'MaxWorkingSet'
$MyWorksheet.Cells.Item( 1, 34 ) = 'MinWorkingSet'
$MyWorksheet.Cells.Item( 1, 35 ) = 'Modules'
$MyWorksheet.Cells.Item( 1, 36 ) = 'NonpagedSystemMemorySize64'
$MyWorksheet.Cells.Item( 1, 37 ) = 'NonpagedSystemMemorySize'
$MyWorksheet.Cells.Item( 1, 38 ) = 'PagedMemorySize64'
$MyWorksheet.Cells.Item( 1, 39 ) = 'PagedSystemMemorySize64'
$MyWorksheet.Cells.Item( 1, 40 ) = 'PagedSystemMemorySize'
$MyWorksheet.Cells.Item( 1, 41 ) = 'PeakPagedMemorySize64'
$MyWorksheet.Cells.Item( 1, 42 ) = 'PeakPagedMemorySize'
$MyWorksheet.Cells.Item( 1, 43 ) = 'PeakWorkingSet64'
$MyWorksheet.Cells.Item( 1, 44 ) = 'PeakWorkingSet'
$MyWorksheet.Cells.Item( 1, 45 ) = 'PeakVirtualMemorySize64'
$MyWorksheet.Cells.Item( 1, 46 ) = 'PeakVirtualMemorySize'
$MyWorksheet.Cells.Item( 1, 47 ) = 'PriorityBoostEnabled'
$MyWorksheet.Cells.Item( 1, 48 ) = 'PrivateMemorySize64'
$MyWorksheet.Cells.Item( 1, 49 ) = 'ProcessName'
$MyWorksheet.Cells.Item( 1, 50 ) = 'ProcessorAffinity'
$MyWorksheet.Cells.Item( 1, 51 ) = 'SessionId'
$MyWorksheet.Cells.Item( 1, 52 ) = 'StartInfo'
$MyWorksheet.Cells.Item( 1, 53 ) = 'Threads'
$MyWorksheet.Cells.Item( 1, 54 ) = 'VirtualMemorySize64'
$MyWorksheet.Cells.Item( 1, 55 ) = 'EnableRaisingEvents'
$MyWorksheet.Cells.Item( 1, 56 ) = 'StandardInput'
$MyWorksheet.Cells.Item( 1, 57 ) = 'StandardOutput'
$MyWorksheet.Cells.Item( 1, 58 ) = 'StandardError'
$MyWorksheet.Cells.Item( 1, 59 ) = 'WorkingSet64'
$MyWorksheet.Cells.Item( 1, 60 ) = 'SynchronizingObject'
$MyWorksheet.Cells.Item( 1, 61 ) = 'MainModule'
$MyWorksheet.Cells.Item( 1, 62 ) = 'PrivilegedProcessorTime'
$MyWorksheet.Cells.Item( 1, 63 ) = 'UserProcessorTime'
$MyWorksheet.Cells.Item( 1, 64 ) = 'MainWindowHandle'
$MyWorksheet.Cells.Item( 1, 65 ) = 'MainWindowTitle'
$MyWorksheet.Cells.Item( 1, 66 ) = 'Responding'
$MyWorksheet.Cells.Item( 1, 67 ) = 'Site'
$MyWorksheet.Cells.Item( 1, 68 ) = 'Container'

#Lines
$i = 2
Get-Process | ForEach-Object -Process {
	$MyWorksheet.Cells.Item( $i,  1 ) = $_.Name
	$MyWorksheet.Cells.Item( $i,  2 ) = $_.Id
	$MyWorksheet.Cells.Item( $i,  3 ) = $_.PriorityClass
	$MyWorksheet.Cells.Item( $i,  4 ) = $_.FileVersion
	$MyWorksheet.Cells.Item( $i,  5 ) = $_.HandleCount
	$MyWorksheet.Cells.Item( $i,  6 ) = $_.WorkingSet
	$MyWorksheet.Cells.Item( $i,  7 ) = $_.PagedMemorySize
	$MyWorksheet.Cells.Item( $i,  8 ) = $_.PrivateMemorySize
	$MyWorksheet.Cells.Item( $i,  9 ) = $_.VirtualMemorySize
	$MyWorksheet.Cells.Item( $i, 10 ) = $_.TotalProcessorTime
	$MyWorksheet.Cells.Item( $i, 11 ) = $_.SI
	$MyWorksheet.Cells.Item( $i, 12 ) = $_.Handles
	$MyWorksheet.Cells.Item( $i, 13 ) = $_.VM
	$MyWorksheet.Cells.Item( $i, 14 ) = $_.WS
	$MyWorksheet.Cells.Item( $i, 15 ) = $_.PM
	$MyWorksheet.Cells.Item( $i, 16 ) = $_.NPM
	$MyWorksheet.Cells.Item( $i, 17 ) = $_.Path
	$MyWorksheet.Cells.Item( $i, 18 ) = $_.Parent
	$MyWorksheet.Cells.Item( $i, 19 ) = $_.Company
	$MyWorksheet.Cells.Item( $i, 20 ) = $_.CPU
	$MyWorksheet.Cells.Item( $i, 21 ) = $_.ProductVersion
	$MyWorksheet.Cells.Item( $i, 22 ) = $_.Description
	$MyWorksheet.Cells.Item( $i, 23 ) = $_.Product
	$MyWorksheet.Cells.Item( $i, 24 ) = $_.__NounName
	$MyWorksheet.Cells.Item( $i, 25 ) = $_.SafeHandle
	$MyWorksheet.Cells.Item( $i, 26 ) = $_.Handle
	$MyWorksheet.Cells.Item( $i, 27 ) = $_.BasePriority
	$MyWorksheet.Cells.Item( $i, 28 ) = $_.ExitCode
	$MyWorksheet.Cells.Item( $i, 29 ) = $_.HasExited
	$MyWorksheet.Cells.Item( $i, 30 ) = $_.StartTime
	$MyWorksheet.Cells.Item( $i, 31 ) = $_.ExitTime
	$MyWorksheet.Cells.Item( $i, 32 ) = $_.MachineName
	$MyWorksheet.Cells.Item( $i, 33 ) = $_.MaxWorkingSet
	$MyWorksheet.Cells.Item( $i, 34 ) = $_.MinWorkingSet
	$MyWorksheet.Cells.Item( $i, 35 ) = $_.Modules
	$MyWorksheet.Cells.Item( $i, 36 ) = $_.NonpagedSystemMemorySize64
	$MyWorksheet.Cells.Item( $i, 37 ) = $_.NonpagedSystemMemorySize
	$MyWorksheet.Cells.Item( $i, 38 ) = $_.PagedMemorySize64
	$MyWorksheet.Cells.Item( $i, 39 ) = $_.PagedSystemMemorySize64
	$MyWorksheet.Cells.Item( $i, 40 ) = $_.PagedSystemMemorySize
	$MyWorksheet.Cells.Item( $i, 41 ) = $_.PeakPagedMemorySize64
	$MyWorksheet.Cells.Item( $i, 42 ) = $_.PeakPagedMemorySize
	$MyWorksheet.Cells.Item( $i, 43 ) = $_.PeakWorkingSet64
	$MyWorksheet.Cells.Item( $i, 44 ) = $_.PeakWorkingSet
	$MyWorksheet.Cells.Item( $i, 45 ) = $_.PeakVirtualMemorySize64
	$MyWorksheet.Cells.Item( $i, 46 ) = $_.PeakVirtualMemorySize
	$MyWorksheet.Cells.Item( $i, 47 ) = $_.PriorityBoostEnabled
	$MyWorksheet.Cells.Item( $i, 48 ) = $_.PrivateMemorySize64
	$MyWorksheet.Cells.Item( $i, 49 ) = $_.ProcessName
	$MyWorksheet.Cells.Item( $i, 50 ) = $_.ProcessorAffinity
	$MyWorksheet.Cells.Item( $i, 51 ) = $_.SessionId
	$MyWorksheet.Cells.Item( $i, 52 ) = $_.StartInfo
	$MyWorksheet.Cells.Item( $i, 53 ) = $_.Threads
	$MyWorksheet.Cells.Item( $i, 54 ) = $_.VirtualMemorySize64
	$MyWorksheet.Cells.Item( $i, 55 ) = $_.EnableRaisingEvents
	$MyWorksheet.Cells.Item( $i, 56 ) = $_.StandardInput
	$MyWorksheet.Cells.Item( $i, 57 ) = $_.StandardOutput
	$MyWorksheet.Cells.Item( $i, 58 ) = $_.StandardError
	$MyWorksheet.Cells.Item( $i, 59 ) = $_.WorkingSet64
	$MyWorksheet.Cells.Item( $i, 60 ) = $_.SynchronizingObject
	$MyWorksheet.Cells.Item( $i, 61 ) = $_.MainModule
	$MyWorksheet.Cells.Item( $i, 62 ) = $_.PrivilegedProcessorTime
	$MyWorksheet.Cells.Item( $i, 63 ) = $_.UserProcessorTime
	$MyWorksheet.Cells.Item( $i, 64 ) = $_.MainWindowHandle
	$MyWorksheet.Cells.Item( $i, 65 ) = $_.MainWindowTitle
	$MyWorksheet.Cells.Item( $i, 66 ) = $_.Responding
	$MyWorksheet.Cells.Item( $i, 67 ) = $_.Site
	$MyWorksheet.Cells.Item( $i, 68 ) = $_.Container
	Write-Debug -Message $i
	$i += 1
}

# Save the workbook
$MyWorkbook.SaveAs( "$PWD\Test.xlsx" )

# Close the workbook
$MyWorkbook.Close()

# Close Excel
$Excel.Quit()

# Kill Excel. No required
Get-Process Excel | Stop-Process

