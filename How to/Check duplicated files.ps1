#
#
#

Measure-Command {
    $v0 = '.' | Get-ChildItem -File -Recurse |
        Get-FileHash -ErrorAction SilentlyContinue |
            Group-Object 'Hash' |
                Where-Object { $_.Count -gt 1 } |
                    Select-Object -Property Group -ExpandProperty Group
}

#
# 
#
Measure-Command {
    $v1 = '.' | Get-ChildItem -File -Recurse |
        Group-Object 'Length' |
            Where-Object { $_.Count -gt 1 } |
                Select-Object -Property Group -ExpandProperty Group |
                    Get-FileHash -ErrorAction SilentlyContinue |
                        Group-Object 'Hash' |
                            Where-Object { $_.Count -gt 1 } |
                                Select-Object -Property Group -ExpandProperty Group
}                

