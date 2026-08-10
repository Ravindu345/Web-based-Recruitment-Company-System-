# 🇱🇰 LankaJobsHub.com — Job Portal Platform

A full-stack Web-based Recruitment Platform built with **Spring Boot** and **JSP + Tailwind CSS** tailored for the Sri Lankan job market. It seamlessly connects job seekers with recruiters, employers, and administrators.

---

## 🚀 Key Features

- 👤 **Role-Based Access & Dashboards**: Dedicated views and capabilities for **Admin**, **Employer**, **Recruiter**, and **Job Seeker**.
- 💼 **Job Management**: Complete job creation, modification, status update, and category/location search capabilities.
- 📋 **Job Applications**: Submit cover letters, manage job applications, and update application review statuses in real time.
- 🛡️ **User Security**: Password hashing with BCrypt encoder, secure session handling, and role validation.
- 🎨 **Modern Responsive UI**: Clean interface styled with Tailwind CSS across all device viewports.

---

## 🛠️ Tech Stack

- **Backend Framework**: Java 17, Spring Boot 3.2.0 (Spring MVC, Spring Security)
- **Frontend Layer**: JSP (JavaServer Pages), JSTL, Tailwind CSS
- **Persistence**: Spring Data JPA / Hibernate (SQLite / In-Memory Demo)
- **Build Tool**: Apache Maven

---

## 📁 Project Structure

```
LankaJobsHub.com/
├── src/
│   ├── main/
│   │   ├── java/com/lankajobshub/
│   │   │   ├── config/          # Security & DB Configurations
│   │   │   ├── controller/      # Spring MVC Controllers (User, Job, Dashboard, Home)
│   │   │   ├── model/           # Entities & Enums (User, Job, Company, Application)
│   │   │   ├── repository/      # Data Repositories
│   │   │   └── service/         # Business Logic Services
│   │   ├── resources/
│   │   │   └── application.properties # App Configurations
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           └── views/       # JSP Views (admin, dashboard, job, user)
└── pom.xml                      # Project Dependencies
```

---

## ⚙️ Quick Start

### 1. Prerequisites
- **JDK 17** or higher installed
- **Apache Maven 3.8+** installed

### 2. Build the Project
```bash
mvn clean compile
```

### 3. Run the Application
```bash
mvn spring-boot:run
```

### 4. Access in Browser
- **Home**: `http://localhost:8080/lankajobshub/`
- **Browse Jobs**: `http://localhost:8080/lankajobshub/jobs`
- **Login**: `http://localhost:8080/lankajobshub/users/login`

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).
