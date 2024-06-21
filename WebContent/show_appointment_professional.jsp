<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>MEDINOVA - Hospital Website Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@400;700&family=Roboto:wght@400;700&display=swap" rel="stylesheet">  

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Topbar Start -->
    <div class="container-fluid py-2 border-bottom d-none d-lg-block">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-lg-start mb-2 mb-lg-0">
                    <div class="d-inline-flex align-items-center">
                        <a class="text-decoration-none text-body pe-3" href=""><i class="bi bi-telephone me-2"></i>+012 345 6789</a>
                        <span class="text-body">|</span>
                        <a class="text-decoration-none text-body px-3" href=""><i class="bi bi-envelope me-2"></i>info@example.com</a>
                    </div>
                </div>
                <div class="col-md-6 text-center text-lg-end">
                    <div class="d-inline-flex align-items-center">
                        <a class="text-body px-2" href="">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="text-body px-2" href="">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="text-body px-2" href="">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a class="text-body px-2" href="">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a class="text-body ps-2" href="">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid sticky-top bg-white shadow-sm mb-5">
        <div class="container">
            <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0">
                <a href="index.html" class="navbar-brand">
                    <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-clinic-medical me-2"></i>Medinova</h1>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
<div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto py-0">
                                  <a href="professional_dashboard.jsp" class="nav-item nav-link">Dashboard</a>
                        <a href="show_appointment_professional.jsp" class="nav-item nav-link">Appointment History</a>
                        
                        <a href="logout.jsp" class="nav-item nav-link " style="color: red;">Logout</a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->


<%
// Get healthcare professional's ID from session
int healthcare_professional_id = (int) session.getAttribute("healthcare_professional_id");

// Query the database for appointments associated with the professional
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
    Statement stmt = con.createStatement();
    String query = "SELECT id, department, phone_number, name, email, appointment_date, appointment_time, appointment_status, notes, notification_status FROM appointments WHERE healthcare_professional_id = " + healthcare_professional_id;

    ResultSet rs = stmt.executeQuery(query);
    // Display the appointments or the message
    if (!rs.next()) {
        %>
        <p style="font-weight: bold; color: #007bff;">You have no appointments.</p>
        <%
    } else {
        %>
    // Display the appointments in a table
%>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
    }

    th {
        background-color: #007bff;
        color: #fff;
        padding: 10px;
    }

    td {
        padding: 8px;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #e2e2e2;
    }

    .confirmed {
        background-color: #28a745;
        color: #fff;
        padding: 6px 10px;
        border-radius: 4px;
    }

    .cancelled {
        background-color: #dc3545;
        color: #fff;
        padding: 6px 10px;
        border-radius: 4px;
    }

    .pending {
        background-color: #ffc107;
        color: #000;
        padding: 6px 10px;
        border-radius: 4px;
    }
</style>

<table>

    <tr>
        <th>ID</th>
        <th>Department</th>
        <th>Phone Number</th>
        <th>Name</th>
        <th>Email</th>
        <th>Appointment Date</th>
        <th>Appointment Time</th>
        <th>Status</th>
        <th>Notes</th>
        <th>Notification Status</th> <!-- Added column -->
        <th>Action</th> <!-- Added column for status update -->
    </tr>
    <% while (rs.next()) {
        String status = rs.getString("appointment_status");
        String notificationStatus = rs.getString("notification_status");
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("department") %></td>
            <td><%= rs.getString("phone_number") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("appointment_date") %></td>
            <td><%= rs.getString("appointment_time") %></td>
            <td>
                <% if (status.equalsIgnoreCase("confirmed")) { %>
                    <span class="confirmed">Confirmed</span>
                <% } else if (status.equalsIgnoreCase("cancelled")) { %>
                    <span class="cancelled">Cancelled</span>
                <% } else { %>
                    <span class="pending">Pending</span>
                <% } %>
            </td>
            <td><%= rs.getString("notes") %></td>
            <td><%= notificationStatus %></td>
            <td>
                <% if (status.equalsIgnoreCase("confirmed") && notificationStatus.equalsIgnoreCase("read")) { %>
                    <a href="update_appointment_status.jsp?appointmentId=<%= rs.getInt("id") %>&status=cancelled" class="btn btn-danger">Cancel</a>
                <% } else if (status.equalsIgnoreCase("cancelled") && notificationStatus.equalsIgnoreCase("read")) { %>
                    <a href="update_appointment_status.jsp?appointmentId=<%= rs.getInt("id") %>&status=confirmed" class="btn btn-success">Confirm</a>
                <% } else if (status.equalsIgnoreCase("pending")) { %>
                    <a href="update_appointment_status.jsp?appointmentId=<%= rs.getInt("id") %>&status=confirmed" class="btn btn-success">Confirm</a>
                    <a href="update_appointment_status.jsp?appointmentId=<%= rs.getInt("id") %>&status=cancelled" class="btn btn-danger">Cancel</a>
                <% } %>
            </td>
        </tr>
         <% } while (rs.next()); %>
        </table>
    <% }
    rs.close();
    stmt.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
</table>

<%
// Update notification status to 'read' for the logged-in healthcare professional
try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
    Statement updateStmt = con.createStatement();
    String updateQuery = "UPDATE appointments SET notification_status = 'read' WHERE healthcare_professional_id = " + healthcare_professional_id;
    updateStmt.executeUpdate(updateQuery);
    updateStmt.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>



   <!-- Footer Start -->
    <div class="container-fluid bg-dark text-light mt-5 py-5">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h4 class="d-inline-block text-primary text-uppercase border-bottom border-5 border-secondary mb-4">Get In Touch</h4>
                    <p class="mb-4">We would love to hear from you. Whether you have a question, feedback, or would like to discuss a potential collaboration, feel free to reach out to us using the contact details below</p>
                    <p class="mb-2"><i class="fa fa-map-marker-alt text-primary me-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-envelope text-primary me-3"></i>AppointEase@example.com</p>
                    <p class="mb-0"><i class="fa fa-phone-alt text-primary me-3"></i>+012 345 67890</p>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="d-inline-block text-primary text-uppercase border-bottom border-5 border-secondary mb-4">Quick Links</h4>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-light mb-2" href="index.jsp"><i class="fa fa-angle-right me-2"></i>Home</a>
                        <a class="text-light mb-2" href="about.jsp"><i class="fa fa-angle-right me-2"></i>About Us</a>
                        <a class="text-light mb-2" href="index.jsp"><i class="fa fa-angle-right me-2"></i>Our Services</a>
                        <a class="text-light mb-2" href="about.jsp"><i class="fa fa-angle-right me-2"></i>Meet The Team</a>
                        <a class="text-light mb-2" href="blog.jsp"><i class="fa fa-angle-right me-2"></i>Latest Blog</a>
                       
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="d-inline-block text-primary text-uppercase border-bottom border-5 border-secondary mb-4">Popular Links</h4>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-light mb-2" href="index.jsp"><i class="fa fa-angle-right me-2"></i>Home</a>
                        <a class="text-light mb-2" href="about.jsp"><i class="fa fa-angle-right me-2"></i>About Us</a>
                        <a class="text-light mb-2" href="index.jsp"><i class="fa fa-angle-right me-2"></i>Our Services</a>
                        <a class="text-light mb-2" href="about.jsp"><i class="fa fa-angle-right me-2"></i>Meet The Team</a>
                        <a class="text-light mb-2" href="blog.jsp"><i class="fa fa-angle-right me-2"></i>Latest Blog</a>
                        
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h4 class="d-inline-block text-primary text-uppercase border-bottom border-5 border-secondary mb-4">Follow Us</h4>

                    <div class="d-flex">
                        <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="https://www.twitter.com"><i class="fab fa-twitter"></i></a>
                        <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="https://www.facebook.com"><i class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-lg btn-primary btn-lg-square rounded-circle me-2" href="https://www.linkedin.com"><i class="fab fa-linkedin-in"></i></a>
                        <a class="btn btn-lg btn-primary btn-lg-square rounded-circle" href="https://www.instagram.com"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid bg-dark text-light border-top border-secondary py-4">
        <div class="container">
            <div class="row g-5">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-md-0">&copy; <a class="text-primary" href="#">AppointEase</a>. All Rights Reserved.</p>
                </div>
               
            </div>
        </div>
    </div>
    <!-- Footer End -->



    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>