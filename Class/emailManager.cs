using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
namespace SbirkaPrikladuEU
{
    public class emailManager
    {
        public static void sendEmail(string from, string to, string subject, string body)
        {
            if (string.IsNullOrEmpty(from)) from = "SbírkaPříkladů.eu <podpora@sbirkaprikladu.eu>";
            if (string.IsNullOrEmpty(to)) return;

            body = "<img src='http://sbirkaprikladu.eu/App_Themes/Gray/imgs/emailLogo.jpg' alt='Sbírka Příkladů' /><br />" + body;

            MailMessage message = new MailMessage(from, to, subject, body);
            message.IsBodyHtml = true;
            SmtpClient client = new SmtpClient("smtp.virtualzone.eu");
            client.Credentials = new System.Net.NetworkCredential("primmat.smtp@client.virtualzone.eu", "2t$dpAWx");
            client.Port = 587;
            client.EnableSsl = true;            
            client.Send(message);
        }
    }
}