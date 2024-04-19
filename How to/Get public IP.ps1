# Public IP
( ( Invoke-WebRequest -Uri https://api.myip.com/ ).Content | ConvertFrom-Json ).ip

# IP + Country
( Invoke-WebRequest -Uri https://api.myip.com/ ).Content | ConvertFrom-Json

# Thanks to https://www.myip.com/
