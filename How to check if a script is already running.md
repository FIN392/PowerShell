

`# Get a temp filename for the Extimated Upcoming Execution (EUE)
  $strFileEUE = "$env:temp\" + $((Get-Item $PSCommandPath).Basename) + "_ExtimatedUpcomingExecution.tmp"

  #
  # At the beginning of the script it is checked if the estimated date of the
  # next execution has already passed,
  # this would mean that the script is not working
  #
  if ( (Get-Date) -gt [DateTime](Get-Content -Path "$strFileEUE") ) {
    "*`n* No working`n*"
  } else {
    "*`n* Working fine`n*"
  }

  #
  # In each interaction of the script, the file is updated with
  # the estimated date for the next execution
  #
  ((Get-Date).Add((New-TimeSpan -Days 0 -Hours 0 -Minutes 0 -Seconds 10))).GetDateTimeFormats('o') | Out-File -FilePath "$strFileEUE"
``
 

 
