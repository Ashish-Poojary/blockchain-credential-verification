# Blockchain-Based Academic Credential Verification System

A secure, tamper-proof system for managing and verifying student academic certificates using blockchain technology. This system ensures the integrity and authenticity of academic credentials through cryptographic hashing and blockchain storage.

## 🚀 Features

- **Blockchain Integration**: Certificate hashes are stored in a custom blockchain for immutable verification
- **Tamper Detection**: SHA-256 hashing ensures any modification to certificates is immediately detectable
- **Multi-User Portal**: Separate interfaces for Students, Admins, and Guests
- **QR Code Generation**: Quick verification through QR codes
- **Email Notifications**: Automated email system for password delivery and notifications
- **Certificate Management**: Upload, download, and verify certificates with ease
- **Secure Authentication**: Role-based access control for different user types

## 🛠️ Technology Stack

- **Backend**: Java (JSP/Servlets)
- **Database**: MySQL 8.0
- **Blockchain**: Custom Java-based blockchain server
- **Email**: JavaMail API (Gmail SMTP)
- **PDF Processing**: Apache PDFBox
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap
- **Server**: Apache Tomcat 8.0

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Java JDK 8 or higher
- MySQL Server 8.0 or higher
- Apache Tomcat 8.0 or higher
- NetBeans IDE (or any Java IDE)
- Git (for version control)

## ⚙️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/blockchain-certificate-verification.git
cd blockchain-certificate-verification
```

### 2. Database Setup

1. Start MySQL server
2. Create the database:

```sql
CREATE DATABASE studentcertificate;
USE studentcertificate;
```

3. Create tables:

```sql
CREATE TABLE student (
    usn VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(10) NOT NULL,
    Emailid VARCHAR(100) NOT NULL,
    pwd VARCHAR(50) NOT NULL,
    imagepath VARCHAR(255)
);

CREATE TABLE admin (
    emailid VARCHAR(100) PRIMARY KEY,
    pwd VARCHAR(50) NOT NULL
);

-- Insert default admin (change password after first login)
INSERT INTO admin (emailid, pwd) VALUES ('admin@example.com', 'admin123');
```

### 3. Configuration

1. Copy the example configuration file:
   ```bash
   cp config.properties.example config.properties
   ```

2. Edit `config.properties` with your settings:

```properties
# Database Configuration
db.host=localhost
db.port=3306
db.name=studentcertificate
db.username=root
db.password=your_mysql_password

# Email Configuration (Gmail SMTP)
email.smtp.host=smtp.gmail.com
email.smtp.port=465
email.smtp.username=your_email@gmail.com
email.smtp.password=your_gmail_app_password
email.from.address=your_email@gmail.com

# Admin Email
admin.email=admin@example.com

# File Storage Paths
storage.certificates.path=C:/certificates
storage.images.path=C:/studentcertificate
storage.download.path=C:/download/certificates

# Blockchain Server
blockchain.server.host=localhost
blockchain.server.port=3000
```

**Important**: 
- For Gmail, you need to generate an [App Password](https://support.google.com/accounts/answer/185833)
- Create the storage directories as specified in the config file
- **Never commit `config.properties` to version control**

### 4. Gmail App Password Setup

1. Go to your Google Account settings
2. Enable 2-Step Verification
3. Go to App Passwords
4. Generate a new app password for "Mail"
5. Use this password in `config.properties`

### 5. Build and Deploy

1. Open the project in NetBeans IDE
2. Clean and Build the project
3. Deploy to Tomcat server
4. Start the blockchain server (if separate)
5. Access the application at `http://localhost:8084/studentcertificateblockchain`

## 📁 Project Structure

```
studentcertificateblockchain/
├── src/
│   └── java/
│       ├── blockchainServer/    # Blockchain implementation
│       ├── controller/          # Servlet controllers
│       ├── dbconnection/        # Database connection
│       ├── mail/                # Email services
│       ├── security/            # Security utilities
│       └── utils/               # Utility classes
├── web/
│   ├── css/                     # Stylesheets
│   ├── js/                      # JavaScript files
│   ├── *.jsp                    # JSP pages
│   └── WEB-INF/                 # Web configuration
├── config.properties.example    # Configuration template
├── .gitignore                   # Git ignore rules
└── README.md                    # This file
```

## 🔐 Security Features

- **SHA-256 Hashing**: All certificates are hashed using SHA-256 algorithm
- **Blockchain Storage**: Immutable storage of certificate hashes
- **Tamper Detection**: Automatic detection of certificate modifications
- **Secure Authentication**: Password-protected user accounts
- **Configuration Management**: Sensitive data stored in external config file

## 👥 User Roles

### Admin
- Register new students
- Upload certificates
- View all certificate hashes
- Manage system settings

### Student
- Login with USN and password
- View own certificates
- Download certificates
- Verify certificate authenticity

### Guest
- Verify certificates using hash or QR code
- View certificate details
- Report issues

## 🔄 Workflow

1. **Registration**: Admin registers students with their details
2. **Certificate Upload**: Admin uploads student certificates (PDF format)
3. **Hash Generation**: System generates SHA-256 hash of the certificate
4. **Blockchain Storage**: Hash is stored in the blockchain
5. **Verification**: Anyone can verify certificate authenticity using hash or QR code

## 🧪 Testing

1. Start the blockchain server
2. Access the application
3. Login as admin and register a test student
4. Upload a test certificate
5. Verify the certificate using the generated hash

## 📝 API Endpoints

- `/adminlogin.jsp` - Admin login page
- `/studentlogin.jsp` - Student login page
- `/guest.jsp` - Guest verification page
- `/registerstudent` - Student registration servlet
- `/uploadcertificate` - Certificate upload servlet
- `/validatehash` - Hash validation servlet

## 🐛 Troubleshooting

### Database Connection Issues
- Verify MySQL is running
- Check database credentials in `config.properties`
- Ensure database and tables exist

### Email Not Sending
- Verify Gmail app password is correct
- Check SMTP settings in `config.properties`
- Ensure 2-Step Verification is enabled on Gmail

### File Upload Issues
- Verify storage directories exist
- Check file permissions
- Ensure sufficient disk space

### Blockchain Server Connection
- Verify blockchain server is running on port 3000
- Check `blockchain.server.host` and `blockchain.server.port` in config

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Developed as an academic project for blockchain-based certificate verification.

## 🙏 Acknowledgments

- Apache PDFBox for PDF processing
- JavaMail API for email functionality
- Bootstrap for UI components
- All open-source contributors

## 📞 Support

For support, please open an issue in the GitHub repository.

---

**Note**: This is an academic project. For production use, additional security measures and testing are recommended.

