package mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;
import utils.ConfigReader;

public class Sendmail {

    public void sendIssueEmail(String studentEmail, String adminEmail, String issueDetails, String studentUSN) throws MessagingException {
        String smtpEmail = ConfigReader.getSmtpUsername();
        String smtpPassword = ConfigReader.getSmtpPassword();
        String senderHost = ConfigReader.getSmtpHost();
        String senderPort = ConfigReader.getSmtpPort();

        String subject = "Certificate Issue Report";
        String messageContent = "Dear Admin,\n\n" +
                "The student with the following details has reported an issue with the downloaded certificate:\n\n" +
                "Student USN: " + studentUSN + "\n" +
                "Student Email: " + studentEmail + "\n" +
                "Issue Details: " + issueDetails + "\n\n" +
                "Please address this issue at the earliest.\n\nThank you.";

        Properties props = new Properties();
        props.put("mail.smtp.host", senderHost);
        props.put("mail.smtp.port", senderPort);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", senderPort);
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

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
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(adminEmail));
        Transport.send(msg);
    }

    class SMTPAuthenticator extends Authenticator {
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
