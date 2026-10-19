# 🍅 TOMATO — Food Delivery Web Application

A full-stack food delivery web application built using **Java, JSP, Servlets, JDBC, and MySQL**, with a responsive frontend developed using HTML, CSS, and JavaScript.

TOMATO brings restaurants, menus, shopping carts, checkout, and order management together in one food ordering experience.

## ✨ Features

- **User Authentication** — User registration, login, logout, and BCrypt password hashing.
- **Restaurant Browsing** — Explore restaurants and view restaurant information.
- **Menu Management** — Browse restaurant menus and available dishes.
- **Shopping Cart** — Add items, update quantities, review totals, and clear the cart.
- **Checkout** — Review order details and proceed through the checkout flow.
- **Order Management** — View orders and order confirmation pages.
- **User Profile** — View and manage profile information.
- **Forgot Password** — OTP-based password reset workflow.
- **Theme Support** — Theme switching functionality.
- **Responsive Interface** — A food-focused UI with TOMATO branding and reusable page components.

*Features depend on the current application configuration and database setup.*

## 🛠️ Technology Stack

| Layer | Technologies |
|---|---|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Java, Jakarta Servlets, JSP |
| Database | MySQL |
| Database Connectivity | JDBC, MySQL Connector/J |
| Authentication | BCrypt |
| Email / OTP | Jakarta Mail |
| Development Environment | Eclipse IDE |
| Application Server | Apache Tomcat 10.1 |
| Version Control | Git and GitHub |

## 📁 Project Structure

```text
Tomato-Food-Delivery/
├── .settings/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tap/
│       │       ├── controller/
│       │       ├── dao/
│       │       ├── daoImpl/
│       │       ├── model/
│       │       ├── test/
│       │       └── util/
│       └── webapp/
│           ├── WEB-INF/
│           ├── META-INF/
│           ├── images/
│           ├── cart.jsp
│           ├── checkout.jsp
│           ├── login.jsp
│           ├── menu.jsp
│           ├── orders.jsp
│           ├── profile.jsp
│           ├── restaurant.jsp
│           └── signup.jsp
├── .classpath
├── .gitignore
└── .project
```

## ⚙️ Prerequisites

Before running TOMATO locally, install:

- Java Development Kit (JDK)
- Eclipse IDE for Enterprise Java and Web Developers, or an Eclipse installation with web development tools
- Apache Tomcat 10.1
- MySQL Server
- MySQL Connector/J

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/Tomato-Food-Delivery.git
```

Replace `Keerthikapalla` with your GitHub username.

### 2. Import the project into Eclipse

1. Open Eclipse.
2. Select **File → Import → General → Existing Projects into Workspace**.
3. Browse to the cloned project directory.
4. Select the project and finish importing.

### 3. Configure the database

1. Start your MySQL server.
2. Create the required database and tables.
3. Configure the database connection using environment variables.

Set the following environment variables for the Tomcat process:

```text
TOMATO_DB_URL=jdbc:mysql://localhost:3306/tomato
TOMATO_DB_USERNAME=your_mysql_username
TOMATO_DB_PASSWORD=your_mysql_password
```

Use your local MySQL credentials. Do not commit real passwords or other secrets to GitHub.

### 4. Configure Tomcat

1. Add Apache Tomcat 10.1 to Eclipse.
2. Associate the project with the Tomcat server.
3. Confirm that the required libraries are available.
4. Start the server after resolving any configuration or compilation errors.

### 5. Run the application

Run the project on Tomcat and open the local application URL shown by Eclipse.

The exact URL depends on your configured context path and application deployment.

## 🔐 Security

- User passwords should be stored using BCrypt hashing, not as plain text.
- Database credentials and email credentials should be configured outside source control.
- Never commit API keys, access tokens, real user data, or private database exports.
- Use secure configuration and appropriate validation when deploying the application.

## 🎯 Project Objective

The goal of TOMATO is to demonstrate full-stack web development through the integration of a Java-based backend, a MySQL database, and an interactive frontend.

The project provides practical experience with MVC-style application organization, JDBC database operations, session-based cart management, authentication, and web application deployment.

## 👩‍💻 Author

Keerthikapalla

GitHub: https://github.com/Keerthikapalla

---

⭐ If you find this project interesting, feel free to explore the code and follow its development.
