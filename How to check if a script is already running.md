```PowerShell
# Lock file name
$strLockFile = "$env:TEMP\" + $((Get-Item $PSCommandPath).Basename) + ".lck"

# Check if lock file if properly updated
if ( Test-Path $strLockFile -PathType Leaf ) {
    if ( (Get-Date) -le [DateTime](Get-Content -Path "$strLockFile") ) {
      "*"
      "* Another instance of this script appears to be running correctly."
      "* No additional instance should be run and therefore this script will be canceled."
      "*"
      exit -1
    }
}

# Set how long the script will take to run.
# If it takes longer, it is considered to have failed and therefore another instance of the script can be executed.
((Get-Date).Add((New-TimeSpan -Days 0 -Hours 0 -Minutes 0 -Seconds 10))).GetDateTimeFormats('o') `
    | Out-File -FilePath "$strLockFile"

#
#
# YOUR CODE GOES HERE
#
#
```
