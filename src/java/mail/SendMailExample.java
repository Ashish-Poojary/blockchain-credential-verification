package mail;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.internet.MimeMessage.RecipientType;
import java.util.*;
import utils.ConfigReader;

public class SendMailExample {

    public void sendMail(String sendermail, String code) throws MessagingException {
        String smtpEmail = ConfigReader.getSmtpUsername();
        String smtpPassword = ConfigReader.getSmtpPassword();
        String senderHost = ConfigReader.getSmtpHost();
        String senderPort = ConfigReader.getSmtpPort();
        String recipientId = sendermail;
        String subject = "Student Certificate Password";
        String messageContent = code;

        Properties props = new Properties();
        props.put("mail.smtp.user", smtpEmail);
        props.put("mail.smtp.host", senderHost);
        props.put("mail.smtp.port", senderPort);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", senderPort);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        // 🔥 Fix: This line avoids SSL trust issue
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Authenticator auth = new SMTPAuthenticator(smtpEmail, smtpPassword);
        Session session = Session.getInstance(props, auth);

        MimeMessage msg = new MimeMessage(session);
        msg.setText(messageContent);
        msg.setSubject(subject);
        String fromEmail = ConfigReader.getFromEmail();
        if (fromEmail == null || fromEmail.isEmpty()) {
            fromEmail = smtpEmail;
        }
        msg.setFrom(new InternetAddress(fromEmail));
        msg.addRecipient(RecipientType.TO, new InternetAddress(recipientId));

        Transport.send(msg);

        System.out.println("Email sent successfully to " + sendermail);
    }

    public String getOTP() {
        StringBuilder otp = new StringBuilder();
        Random r = new Random();
        for (int i = 0; i < 8; i++) {
            otp.append(r.nextInt(10));
        }
        return otp.toString().trim();
    }

    class SMTPAuthenticator extends javax.mail.Authenticator {
        private final String smtpEmail;
        private final String smtpPassword;

        public SMTPAuthenticator(String smtpEmail, String smtpPassword) {
            this.smtpEmail = smtpEmail;
            this.smtpPassword = smtpPassword;
        }

        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(smtpEmail, smtpPassword);
        }
    }
}
