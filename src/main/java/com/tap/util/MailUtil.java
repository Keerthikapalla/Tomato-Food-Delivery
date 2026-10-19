
package com.tap.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public final class MailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    private MailUtil() {
        // Utility class; do not create objects.
    }

    public static void sendEmail(
            String recipient,
            String subject,
            String body) throws MessagingException {

        final String username =
                System.getenv("TOMATO_MAIL_USERNAME");

        final String appPassword =
                System.getenv("TOMATO_MAIL_APP_PASSWORD");

        if (username == null || username.trim().isEmpty()
                || appPassword == null || appPassword.trim().isEmpty()) {
            throw new IllegalStateException(
                    "Mail credentials are missing. Configure "
                    + "TOMATO_MAIL_USERNAME and "
                    + "TOMATO_MAIL_APP_PASSWORD.");
        }

        if (recipient == null || recipient.trim().isEmpty()
                || subject == null || body == null) {
            throw new IllegalArgumentException(
                    "Recipient, subject and body are required.");
        }

        final String mailUsername = username.trim();
        final String mailPassword = appPassword.trim();

        Properties properties = new Properties();
        properties.put("mail.smtp.host", SMTP_HOST);
        properties.put("mail.smtp.port", SMTP_PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.starttls.required", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        properties.put("mail.smtp.connectiontimeout", "10000");
        properties.put("mail.smtp.timeout", "10000");
        properties.put("mail.smtp.writetimeout", "10000");

        Session session = Session.getInstance(
                properties,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication
                            getPasswordAuthentication() {
                        return new PasswordAuthentication(
                                mailUsername, mailPassword);
                    }
                });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(mailUsername));
        message.setRecipient(
                Message.RecipientType.TO,
                new InternetAddress(recipient.trim()));
        message.setSubject(subject, "UTF-8");
        message.setText(body, "UTF-8");

        Transport.send(message);
    }
}
