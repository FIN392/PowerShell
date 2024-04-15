# PowerShell learning for Windows Batch speakers

The first thing a language teacher tells you is that you shouldn't translate word for word from your mother tongue; you must *think in the new language*.

Fully agree, but this list will be a good starting point for that new *way of thinking*.

| Windows Batch   | PowerShell                                                                                 |
|-----------------|--------------------------------------------------------------------------------------------|
| HELP            | Get-Help                                                                                   |
| ASSOC           | Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts" |
| ATTRIB          | (Get-ChildItem).Attributes = 'ReadOnly, Hidden'                                            |
| CACLS           | Set-Acl                                                                                    |
| CALL            | function                                                                                   |
| CD              | Set-Location -Path C:\Temp                                                                 |
| CLS             | Clear-Host                                                                                 |
| COLOR           | $Host.UI.RawUI.BackgroundColor / $Host.UI.RawUI.ForegroundColor                            |
| COMP            | Get-FileHash                                                                               |
| COMPACT         | (Get-ChildItem).Attributes = 'Compressed'                                                  |
| COPY            | Copy-Item                                                                                  |
| DATE            | Get-Date                                                                                   |
| DEL             | Remove-Item                                                                                |
| DIR             | Get-ChildItem                                                                              |
| ECHO            | Write-Host                                                                                 |
| EXIT            | exit                                                                                       |
| FINDSTR         | Select-String                                                                              |
| FOR             | For-Each                                                                                   |
| GPRESULT        | Get-GPResultantSetOfPolicy                                                                 |
| ICACLS          | Set-Acl                                                                                    |
| IF              | if                                                                                         |
| LABEL           | Set-Volume                                                                                 |
| MD              | New-Item -ItemType Directory                                                               |
| MKLINK          | New-Item -ItemType SymbolicLink                                                            |
| MORE            | Out-Host -Paging                                                                           |
| MOVE            | Move-Item                                                                                  |
| OPENFILES       | Get-SmbOpenFile                                                                            |
| PATH            | Set-Item -Path Env:Path                                                                    |
| PAUSE           | Start-Sleep                                                                                |
| PING            | Test-Connection                                                                            |
| POPD            | Pop-Location                                                                               |
| PRINT           | Out-Printer                                                                                |
| PROMPT          | function prompt {}                                                                         |
| PUSHD           | Push-Location                                                                              |
| RD              | Remove-Item                                                                                |
| REM             | #                                                                                          |
| REN             | Rename-Item                                                                                |
| REPLACE         | Copy-Item                                                                                  |
| ROBOCOPY        | Copy-Item                                                                                  |
| SET             | Get-Item -Path Env:*                                                                       |
| SETLOCAL        | $script:VariableName                                                                       |
| SC              | Get-Service                                                                                |
| SCHTASKS        | New-ScheduledTaskAction                                                                    |
| SHUTDOWN        | Stop-Computer                                                                              |
| SORT            | Sort-Object                                                                                |
| START           | Start-Process                                                                              |
| SUBST           | New-PSDrive                                                                                |
| SYSTEMINFO      | Get-ComputerInfo                                                                           |
| TASKLIST        | Get-Process                                                                                |
| TASKKILL        | Stop-Process                                                                               |
| TIME            | Get-Date                                                                                   |
| TITLE           | $Host.UI.RawUI.WindowTitle                                                                 |
| TREE            | Get-ChildItem                                                                              |
| TYPE            | Get-Content                                                                                |
| VER             | $Host.Version.ToString()                                                                   |
| VOL             | Get-Volume                                                                                 |
| XCOPY           | Copy-Item                                                                                  |
| WMIC            | Get-WmiObject                                                                              |
| %~d0            | Split-Path -Path $PSCommandPath -Qualifier                                                 |
| %~p0            | (Get-Item $PSCommandPath ).Directory.Name                                                  |
| %~n0            | (Get-Item $PSCommandPath ).Basename                                                        |
| %~x0            | (Get-Item $PSCommandPath ).Extension                                                       |
| %CD%            | Get-Location                                                                               |
| %DATE%          | Get-Date -Format "yyyy/MM/dd"                                                              |
| %TIME%          | Get-Date -Format "HH::mm:ss"                                                               |
| %TEMP%          | $env:TEMP                                                                                  |
| %RANDOM%        | Get-Random -Minimum 0 -Maximum 32767                                                       |
| %USERDOMAIN%    | (Get-ADDomain -Current LoggedOnUser).NetBIOSName                                           |
| %USERNAME%      | [System.Security.Principal.WindowsIdentity]::GetCurrent().Name                             |
| %COMPUTERNAME%  | Get-ComputerInfo -Property CSName                                                          |

