Function Get-OutlookCalendar
{
    # load the required .NET types
    Add-Type -AssemblyName 'C:\Program Files (x86)\Microsoft Office\root\Office16\ADDINS\Microsoft Power Query for Excel Integrated\bin\Microsoft.Office.Interop.Outlook.dll'

    # access Outlook object model
    $outlook = New-Object -ComObject outlook.application

    # connect to the appropriate location
    $namespace = $outlook.GetNameSpace('MAPI')
    $Calendar = [Microsoft.Office.Interop.Outlook.OlDefaultFolders]::olFolderCalendar
    $folder = $namespace.getDefaultFolder($Calendar)
    # get calendar items
    $folder.items |
        Select-Object -Property Start, Categories, Subject, IsRecurring, Organizer
}

Get-OutlookCalendar | Out-GridView



