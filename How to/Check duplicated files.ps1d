
'.' | Get-ChildItem -Recurse |
    Get-FileHash -ErrorAction SilentlyContinue |
        Group-Object 'Hash' |
            Where-Object { $_.Count -gt 1 } |
                Select-Object -Property Group -ExpandProperty Group
