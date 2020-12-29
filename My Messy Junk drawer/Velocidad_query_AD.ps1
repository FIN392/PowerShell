

Get-ADUser -Filter 'C -like "ES" -and Enabled -eq $True' -Properties mail -SearchBase 'DC=oneabbott,DC=com' -ResultPageSize 1000

Get-Job 
