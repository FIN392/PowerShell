function Get-SystemInfo {
    
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$ComputerName = 'localhost'
    )

    BEGIN{
        Remove-Item -Path "C:\NoExist.Hopeso" -ErrorAction SilentlyContinue
        Write-Warning "The error was $($error[0])"

        [system.net.dns]::GetHostAddresses('www.bing.com')
    }
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
        $obj = New-Object  -TypeName psobject -Property $props
        write-output $obj
    }
    END{}
}

Get-SystemInfo -ComputerName localhost | Format-List -Property *,@{n='RAM(GB)';e={$_.RAM / 1GB -as [int]}}

$Env:COMPUTERNAME | Get-SystemInfo
