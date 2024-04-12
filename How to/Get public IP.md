

(( Invoke-WebRequest -Uri https://api.myip.com/).Content | ConvertFrom-Json).ip


( Invoke-WebRequest -Uri https://api.myip.com/).Content | ConvertFrom-Json
