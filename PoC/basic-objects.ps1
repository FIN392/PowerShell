function Get-SystemInfo {
	
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$true)]
		[string]$ComputerName = 'localhost'
	)

	BEGIN{}
	PROCESS{
		$os = Get-WmiObject -Class win32_operatingsystem -ComputerName $ComputerName
		$cs = Get-WmiObject -Class win32_computersystem -ComputerName $ComputerName
		$props = @{
			'ComputerName'=$ComputerName;
			'OSVersion'=$os.version;
			'OSBuild'=$os.buildnumber;
			'SPVersion'=$os.servicepackmajorversion;
			'Model'=$cs.model;
			'Manufacturer'=$cs.manufacturer;
			'RAM'=$cs.totalphysicalmemory;
			'Sockets'=$cs.numberofprocessors;
			'Cores'=$cs.numberoflogicalprocessors
		}
		$obj = New-Object -TypeName psobject -Property $props
		write-output $obj
	}
	END{}
}


# 'SilentlyContinue' example
Remove-Item -Path "C:\NoExist.Hopeso" -ErrorAction SilentlyContinue
Write-Warning "The error was: $($error[0])"

# DNS
[system.net.dns]::GetHostAddresses('www.bing.com')

# Object
Get-SystemInfo -ComputerName localhost | Format-List -Property *,@{n='RAM(GB)';e={$_.RAM / 1GB -as [int]}}

# Object
$Env:COMPUTERNAME | Get-SystemInfo
