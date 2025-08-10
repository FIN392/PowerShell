#
# v0 - Check the hash of all files to identify duplicates
#
# Get all the files
#     Get the hash of all of them
#         Group them by hash
#             Take thos groups with more than 1 object
#                 Expand the groups
#

Measure-Command {
    $v0 = '.' | Get-ChildItem -File -Recurse |
        Get-FileHash -ErrorAction SilentlyContinue |
            Group-Object 'Hash' |
                Where-Object { $_.Count -gt 1 } |
                    Select-Object -Property Group -ExpandProperty Group
}

#
# v1 - Check the length and then take the hash only for those that have the same
#
# Get all the files
#     Group them by length
#         Take thos groups with more than 1 object
#             Expand the groups
#                 Get the hash of all of them
#                     Group them by hash
#                         Take thos groups with more than 1 object
#                             Expand the groups
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
