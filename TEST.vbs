Sub CreateContactGroupFromContactsOfSpecificCompany()
    Dim objContactsFolder As Folder
    Dim strCompany As String
    Dim objFoundContacts As Outlook.Items
    Dim objContact As Outlook.ContactItem
    Dim objContactGroup As DistListItem
    Dim objTempMail As MailItem
 
    Set objContactsFolder = Outlook.Application.ActiveExplorer.CurrentFolder
 
    If objContactsFolder.DefaultItemType = olContactItem Then
       If objContactsFolder.Items.count > 0 Then
          strCompany = InputBox("Input the specific company:", "Specify Company")
          'Get contacts only
          Set objFoundContacts = objContactsFolder.Items.Restrict("[Email1Address]>''")
          'Get the contacts of a specific company
          Set objFoundContacts = objFoundContacts.Restrict("[CompanyName] = '" & strCompany & "'")
 
          If objFoundContacts.count > 0 Then
             'Create a contact group in current folder
             Set objContactGroup = objContactsFolder.Items.Add("IPM.DistList")
             For Each objContact In objFoundContacts
 
                 Set objTempMail = Application.CreateItem(olMailItem)
                 objTempMail.Recipients.Add (objContact.Email1Address)
 
                 'Add the contacts to group
                 With objContactGroup
                      .DLName = strCompany
                      .AddMembers objTempMail.Recipients
                      .Display
                 End With
             Next
          Else
             MsgBox "There is no contact in this company!", vbExclamation
          End If
       Else
          MsgBox "There is no item in this Contacts folder!", vbExclamation
       End If
    Else
       MsgBox "Please access a Contacts folder!", vbExclamation
    End If
End Sub