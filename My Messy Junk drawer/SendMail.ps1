$body = @'
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#9ABAD9;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 10px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#9ABAD9;color:#444;background-color:#EBF5FF;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 10px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#9ABAD9;color:#fff;background-color:#409cff;}
.tg .tg-k956{font-size:20px;font-family:"Comic Sans MS", cursive, sans-serif !important;;border-color:inherit;text-align:right;vertical-align:bottom}
.tg .tg-i79r{font-size:12px;font-family:"Comic Sans MS", cursive, sans-serif !important;;border-color:inherit;text-align:right;vertical-align:top}
.tg .tg-faqb{font-size:20px;font-family:"Comic Sans MS", cursive, sans-serif !important;;border-color:inherit;text-align:left;vertical-align:bottom}
.tg .tg-2emy{font-size:12px;font-family:"Comic Sans MS", cursive, sans-serif !important;;border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th class="tg-faqb">Firstname</th>
    <th class="tg-faqb">Lastname</th>
    <th class="tg-k956">Age</th>
  </tr>
  <tr>
    <td class="tg-2emy">Jill</td>
    <td class="tg-2emy">Smith</td>
    <td class="tg-i79r">50</td>
  </tr>
  <tr>
    <td class="tg-2emy">Eve</td>
    <td class="tg-2emy">Jackson</td>
    <td class="tg-i79r">92</td>
  </tr>
  <tr>
    <td class="tg-2emy">Jose</td>
    <td class="tg-2emy">Fernandez</td>
    <td class="tg-i79r">&lt;50</td>
  </tr>
</table>
'@

Send-MailMessage                                            `
	-SMTPServer mail.abbott.com                             `
	-From TEST20200116@abbott.com                           `
	-To jose.fernandez@abbott.com                           `
	-CC asd@asd.asd                           `
	-BCC zxc@zxc.zxc                          `
	-Subject 'Asunto'                                       `
	-Body $body                                             `
	-BodyAsHTML                                             `
	-Attachments 'C:\Users\FERNAJL\Desktop\SendMail.txt'

Send-MailMessage                                            `
	-SMTPServer mail.abbott.com                             `
	-From TEST20200116@abbott.com                           `
	-To qwe@qwe.qwe                           `
	-CC jose.fernandez@abbott.com                           `
	-BCC zxc@zxc.zxc                          `
	-Subject 'Asunto'                                       `
	-Body $body                                             `
	-BodyAsHTML                                             `
	-Attachments 'C:\Users\FERNAJL\Desktop\SendMail.txt'

Send-MailMessage                                            `
	-SMTPServer mail.abbott.com                             `
	-From TEST20200116@abbott.com                           `
	-To qwe@qwe.qwe                           `
	-CC asd@asd.asd                           `
	-BCC jose.fernandez@abbott.com                          `
	-Subject 'Asunto'                                       `
	-Body $body                                             `
	-BodyAsHTML                                             `
	-Attachments 'C:\Users\FERNAJL\Desktop\SendMail.txt'

<#
Send-MailMessage
    [-To] <string[]>
    [[-Subject] <string>]
    [[-Body] <string>]
    [[-SmtpServer] <string>]
    -From <string>
    [-Attachments <string[]>]
    [-Bcc <string[]>]
    [-BodyAsHtml]
    [-Encoding <Encoding>]
    [-Cc <string[]>]
    [-DeliveryNotificationOption <DeliveryNotificationOptions>]
    [-Priority <MailPriority>]
    [-ReplyTo <string[]>]
    [-Credential <pscredential>]
    [-UseSsl]
    [-Port <int>]
#>

