
package com.tap.test;

import java.util.Scanner;

import com.tap.util.MailUtil;

public class MailTest {

    public static void main(String[] args) {

        // Read credentials from Windows environment variables.
        String username = System.getenv("TOMATO_MAIL_USERNAME");
        String appPassword = System.getenv("TOMATO_MAIL_APP_PASSWORD");

        System.out.println("======================================");
        System.out.println("       TOMATO EMAIL CONFIG TEST");
        System.out.println("======================================");

        // Check Gmail username.
        boolean usernameConfigured =
                username != null && !username.trim().isEmpty();

        System.out.println("Username configured: "
                + usernameConfigured);

        if (usernameConfigured) {
            System.out.println("Sender email: " + username.trim());
        }

        // Check App Password without printing its value.
        boolean passwordConfigured =
                appPassword != null && !appPassword.trim().isEmpty();

        System.out.println("App password configured: "
                + passwordConfigured);

        int passwordLength = passwordConfigured
                ? appPassword.trim().length()
                : 0;

        System.out.println("App password length after trimming: "
                + passwordLength);

        System.out.println("App password contains spaces: "
                + (passwordConfigured
                   && appPassword.trim().contains(" ")));

        System.out.println("======================================");

        // Stop if environment variables are missing.
        if (!usernameConfigured || !passwordConfigured) {
            System.out.println("CONFIGURATION ERROR:");
            System.out.println(
                    "Check TOMATO_MAIL_USERNAME and "
                    + "TOMATO_MAIL_APP_PASSWORD in Windows "
                    + "Environment Variables.");
            return;
        }

        // Ask for the recipient address.
        try (Scanner scanner = new Scanner(System.in)) {

            System.out.print(
                    "Enter an email address you can access: ");

            String recipient = scanner.nextLine().trim();

            if (recipient.isEmpty()) {
                System.out.println(
                        "ERROR: Recipient email cannot be empty.");
                return;
            }

            System.out.println("Sending test email...");

            // Send email using the existing MailUtil class.
            MailUtil.sendEmail(
                    recipient,
                    "TOMATO Email Test",
                    "Hello!\n\n"
                    + "This is a test email from the TOMATO "
                    + "food delivery application.\n\n"
                    + "If you received this email, Gmail SMTP "
                    + "is working successfully.\n\n"
                    + "TOMATO Team");

            System.out.println();
            System.out.println("SUCCESS!");
            System.out.println(
                    "The email was submitted successfully.");
            System.out.println(
                    "Please check your inbox and Spam folder.");

        } catch (Exception e) {

            System.out.println();
            System.out.println("EMAIL TEST FAILED");
            System.out.println("Error type: "
                    + e.getClass().getSimpleName());
            System.out.println("Reason: "
                    + e.getMessage());

            System.out.println();
            System.out.println(
                    "Check your Gmail App Password, sender "
                    + "account, and SMTP configuration.");
        }
    }
}
