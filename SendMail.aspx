<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
            mail.From = new System.Net.Mail.MailAddress("tnguyen482@hellomeo.net");
            mail.To.Add(new System.Net.Mail.MailAddress("trind06@gmail.com"));
            mail.CC.Add(new System.Net.Mail.MailAddress("tnguyen482@hellomeo.net"));
            mail.Bcc.Add(new System.Net.Mail.MailAddress("trind09@yahoo.com"));
            mail.IsBodyHtml = true;
            mail.Priority = System.Net.Mail.MailPriority.High;
            mail.Subject = "Test mail";
            mail.Body = "<h1>Hello world!</h1>";

            // The important part -- configuring the SMTP client
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
            smtp.Port = 587;   // [1] You can try with 465 also, I always used 587 and got success
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network; // [2] Added this
            smtp.UseDefaultCredentials = false; // [3] Changed this
            smtp.Credentials = new System.Net.NetworkCredential("dungtrin2@gmail.com", "P@ssword123!");  // [4] Added this. Note, first parameter is NOT string.
            smtp.Host = "smtp.gmail.com";

            string st = "Test";

            mail.Body = st;
            smtp.Send(mail);
            Label1.Text = "Success!";
        } catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="Send" OnClick="Button1_Click" /><br /><br />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
