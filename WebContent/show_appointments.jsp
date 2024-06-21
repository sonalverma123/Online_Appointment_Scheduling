<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.bean.appointment.Appointment" %>
<%@ page import="java.util.List" %>
 <%@ page import="java.sql.*" %>


    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Appointment History</title>
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
                        <a class="text-decoration-none text-body px-3" href=""><i class="bi bi-envelope me-2"></i>AppointEase@example.com</a>
                    </div>
                </div>
                <div class="col-md-6 text-center text-lg-end">
    <div class="d-inline-flex align-items-center">
        <a class="text-body px-2" href="https://www.facebook.com">
            <i class="fab fa-facebook-f"></i>
        </a>
        <a class="text-body px-2" href="https://www.twitter.com">
            <i class="fab fa-twitter"></i>
        </a>
        <a class="text-body px-2" href="https://www.linkedin.com">
            <i class="fab fa-linkedin-in"></i>
        </a>
        <a class="text-body px-2" href="https://www.instagram.com">
            <i class="fab fa-instagram"></i>
        </a>
        <a class="text-body ps-2" href="https://www.youtube.com">
            <i class="fab fa-youtube"></i>
        </a>
    </div>
</div>

            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid sticky-top bg-white shadow-sm">
        <div class="container">
            <nav class="navbar navbar-expand-lg bg-white navbar-light py-3 py-lg-0">
                <a href="index.jsp" class="navbar-brand">
                    <h1 class="m-0 text-uppercase text-primary"><i class="fa fa-clinic-medical me-2"></i>AppointEase</h1>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                              <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto py-0">
                         <a href="user_dashboard.jsp" class="nav-item nav-link">Dashboard</a>
                        <a href="appointment.jsp" class="nav-item nav-link">Book an Appointment</a>
                        <a href="show_appointments.jsp" class="nav-item nav-link">Appointment History</a>
                        <a href="Service1.jsp" class="nav-item nav-link">Find</a>
                     
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->
    
    <style>
    .sub-menu {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}
.nav-item:hover .sub-menu {
    display: block;
}

.sub-menu li {
    padding: 10px;
}

.sub-menu li a {
    color: #333;
    text-decoration: none;
}

.sub-menu li a:hover {
    color: #000;
    font-weight: bold;
}
    
    </style>
  
                <!-- Appointment information Start -->
  
<%
  // Set up database connection
  Class.forName("com.mysql.jdbc.Driver");
  String url = "jdbc:mysql://localhost:3306/appointment_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String username = "root";
  String password = "root";
  Connection conn = DriverManager.getConnection(url, username, password);
  
//Get the email of the current user from the session
String currentUserEmail = (String) session.getAttribute("email");

//Check if the user is logged in
if (currentUserEmail == null) {
 // Handle the case where the user is not logged in, e.g., redirect to a login page
 response.sendRedirect("user_login.jsp");
 return;
}

  // Check if delete request was sent
  if (request.getParameter("delete_id") != null) {
    int delete_id = Integer.parseInt(request.getParameter("delete_id"));
    String delete_query = "DELETE FROM appointments WHERE id=? AND email=?";
    PreparedStatement delete_stmt = conn.prepareStatement(delete_query);
    delete_stmt.setInt(1, delete_id);
    delete_stmt.setString(2, currentUserEmail);
    delete_stmt.executeUpdate();
  }

  // Execute query to fetch appointments data for the current user
  String query = "SELECT * FROM appointments WHERE email=?";
  PreparedStatement stmt = conn.prepareStatement(query);
  stmt.setString(1, currentUserEmail);
  ResultSet rs = stmt.executeQuery();

  // Display data in an HTML table
%>
<div class="col-lg-6">
  <div class="bg-light text-center rounded p-5">
    <h1 class="mb-4">Appointment Information</h1>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>Department</th>
          <th>Phone Number</th>
          <th>Name</th>
          <th>Email</th>
          <th>Appointment Date</th>
          <th>Appointment Time</th>
          <th>Created At</th>
          <th>Edit</th>
          <th>Cancel</th>
        </tr>
      </thead>
      <tbody>
         <% while (rs.next()) { %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("department") %></td>
            <td><%= rs.getString("phone_number") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getDate("appointment_date") %></td>
            <td><%= rs.getTime("appointment_time") %></td>
            <td><%= rs.getTimestamp("created_at") %></td>
            <td>
              <button type="button" class="btn btn-primary" onclick="toggleForm(<%= rs.getInt("id") %>)">Edit</button>
              <div id="form-<%= rs.getInt("id") %>" style="display: none;">
                <form method="post" action="update_appointment.jsp">
                  <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                  <input type="text" name="department" value="<%= rs.getString("department") %>">
                  <input type="text" name="phone_number" value="<%= rs.getString("phone_number") %>">
                  <input type="text" name="name" value="<%= rs.getString("name") %>">
                  <input type="text" name="email" value="<%= rs.getString("email") %>">
                  <input type="date" name="appointment_date" value="<%= rs.getDate("appointment_date") %>">
                  <input type="time" name="appointment_time" value="<%= rs.getTime("appointment_time") %>">
                  <input type="hidden" name="appointment_id" value="<%= rs.getInt("id") %>">
                  <button type="submit" class="btn btn-primary">Update</button>
                </form>
              </div>
            </td>
            <td>
              <button type="button" class="btn btn-danger" onclick="deleteAppointment(<%= rs.getInt("id") %>)">Delete</button>
              <div class="delete-confirm" style="display: none;">
                <p>Are you sure you want to delete this appointment?</p>
                <button class="btn btn-danger" onclick="confirmDelete(<%= rs.getInt("id") %>)">Yes</button>
                <button class="btn btn-secondary cancel-delete-btn">No</button>
              </div>
            </td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>

<style>
  /* Updated table styling */
  .table {
    width: 100%;
    border-collapse: collapse;
  }

  .table th,
  .table td {
    padding: 8px;
    text-align: left;
  }

  .table th {
    background-color: #f2f2f2;
    color: #333;
  }

  .table tbody tr:nth-child(odd) {
    background-color: #f9f9f9;
  }

  /* Button styling */
  .btn-primary {
    background-color: #007bff;
    border-color: #007bff;
    color: #fff;
  }

  .btn-primary:hover {
    background-color: #0069d9;
    border-color: #0062cc;
  }

  .btn-danger {
    background-color: #dc3545;
    border-color: #dc3545;
    color: #fff;
  }

  .btn-danger:hover {
    background-color: #c82333;
    border-color: #bd2130;
  }

  .btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
    color: #fff;
  }

  .btn-secondary:hover {
    background-color: #5a6268;
    border-color: #545b62;
  }

  /* Additional styles for delete confirmation */
  .delete-confirm {
    margin-top: 10px;
    text-align: center;
  }

  .delete-confirm p {
    margin-bottom: 10px;
  }
</style>

<script>
  function toggleForm(id) {
    var form = document.getElementById("form-" + id);
    form.style.display = form.style.display === "none" ? "block" : "none";
  }

  function deleteAppointment(id) {
    var confirmDelete = confirm("Are you sure you want to delete this appointment?");
    if (confirmDelete) {
      window.location.href = "delete_appointment.jsp?id=" + id;
    }
  }
</script>


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