<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>User Dashboard</title>
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
    
  
   
<!-- Navbar Start -->
<!-- Existing code for the navbar -->
<!-- Navbar End -->

<%
   Connection conn = null;
   PreparedStatement stmt = null;
   ResultSet rs = null;
   String email = (String) request.getSession().getAttribute("email");
   
   if (email != null) {
       try {
          Class.forName("com.mysql.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
          stmt = conn.prepareStatement("SELECT * FROM users WHERE email=?");
          stmt.setString(1, email);
          rs = stmt.executeQuery();

          if (rs.next()) {
             String name = rs.getString("name");
             String phone = rs.getString("phone");
             request.setAttribute("name", name);
             request.setAttribute("email", email);
             request.setAttribute("phone", phone);
          }
       } catch (ClassNotFoundException e) {
          e.printStackTrace();
       } catch (SQLException e) {
          e.printStackTrace();
       } finally {
          if (rs != null) {
             try {
                rs.close();
             } catch (SQLException e) {
                e.printStackTrace();
             }
          }
          if (stmt != null) {
             try {
                stmt.close();
             } catch (SQLException e) {
                e.printStackTrace();
             }
          }
          if (conn != null) {
             try {
                conn.close();
             } catch (SQLException e) {
                e.printStackTrace();
             }
          }
       }
   }
%>

<div class="container">
   <div class="row">
      <div class="col-md-12">
         <h1>User Dashboard</h1>
         <hr>
         <c:if test="${email != null}">
            <div class="row">
               <div class="col-md-4">
                  <div class="card">
                     <div class="card-header">
                        <h3>User Profile</h3>
                     </div>
                     <div class="card-body">
                        <h5>Name: <c:out value="${name}"/></h5>
                        <h5>Email: <c:out value="${email}"/></h5>
                          <h5>Phone: <c:out value="${phone}"/></h5>
                     </div>
                  </div>
               </div>
               <div class="col-md-8">
                  <h3>Appointments</h3>
                  <table class="table">
                     <thead>
                        <tr>
                           <th>ID</th>
                           <th>Department</th>
                           <th>Phone Number</th>
                           <th>Name</th>
                           <th>Email</th>
                           <th>Appointment Date</th>
                           <th>Appointment Time</th>
                           <th>Status</th>
                                <th>Actions</th>
                        </tr>
                     </thead>
                     <tbody>
                        <% 
                           conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
                           stmt = conn.prepareStatement("SELECT * FROM appointments WHERE email=?");
                           stmt.setString(1, email);
                           rs = stmt.executeQuery();

                           while (rs.next()) {
                              int appointmentId = rs.getInt("id");
                              String department = rs.getString("department");
                              String phoneNumber = rs.getString("phone_number");
                              String appointmentName = rs.getString("name");
                              String appointmentEmail = rs.getString("email");
                              String appointmentDate = rs.getString("appointment_date");
                              String appointmentTime = rs.getString("appointment_time");
                              String appointmentStatus = rs.getString("appointment_status");
                              String notificationStatus = rs.getString("notification_status");
                        %>
                           <tr>
                              <td><%= appointmentId %></td>
                              <td><%= department %></td>
                              <td><%= phoneNumber %></td>
                              <td><%= appointmentName %></td>
                              <td><%= appointmentEmail %></td>
                              <td><%= appointmentDate %></td>
                              <td><%= appointmentTime %></td>
                                <td><%= appointmentStatus %></td>
                              <td>
                                 <% if (appointmentStatus.equalsIgnoreCase("confirmed")) { %>
                                    <span class="badge bg-success">Confirmed</span>
                                 <% } else if (appointmentStatus.equalsIgnoreCase("cancelled")) { %>
                                    <span class="badge bg-danger">Cancelled</span>
                                 <% } else { %>
                                    <span class="badge bg-secondary">Pending</span>
                                 <% } %>
                                 
                              </td>
                              
                           </tr>
                        <% } %>
                     </tbody>
                  </table>
             <hr>
<h3>Submit Review</h3>
<form id= submitReview action="submit_review.jsp" method="post">
   <div class="form-group">
      <label for="professional">Select Professional:</label>
      <select name="professional" id="professional" class="form-control">
         <option value="">Select Professional</option>
         <% 
            conn = null;
            stmt = null;
           rs = null;
            
           try {
               conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
               stmt = conn.prepareStatement("SELECT id, name, profession FROM healthcare_professionals");
               rs = stmt.executeQuery();
               
               while (rs.next()) { 
                  %>
                  <option value="<%= rs.getInt("id") %>"><%= rs.getString("name")%> - <%=rs.getString("profession")%></option>
                  <% 
               } 
            } catch (SQLException e) {
               e.printStackTrace();
            } finally {
               // Close resources
               if (rs != null) {
                  try {
                     rs.close();
                  } catch (SQLException e) {
                     e.printStackTrace();
                  }
               }
               if (stmt != null) {
                  try {
                     stmt.close();
                  } catch (SQLException e) {
                     e.printStackTrace();
                  }
               }
               if (conn != null) {
                  try {
                     conn.close();
                  } catch (SQLException e) {
                     e.printStackTrace();
                  }
               }
            }
         %>
      </select>
   </div>
   <div class="form-group">
      <label for="rating">Rating:</label>
      <input type="number" name="rating" id="rating" class="form-control" min="1" max="5" required>
   </div>
   <div class="form-group">
      <label for="review">Review:</label>
      <textarea name="review" id="review" class="form-control" rows="5" required></textarea>
   </div>
   <button type="submit" class="btn btn-primary">Submit</button>
</form>

               </div>
            </div>
            <hr>
            <a href="edit_user.jsp" class="btn btn-primary">Edit Profile</a>
            <a href="change_password.jsp" class="btn btn-primary">Change Password</a>
            <a href="logout.jsp" class="btn btn-danger">Logout</a>
         </c:if>
      </div>
   </div>
</div>

<script>
$(document).ready(function() {
  $('#submitReview').submit(function(e) {
    e.preventDefault(); // Prevent form submission

    // Get form data
    var formData = $(this).serialize();

    // Send form data to server using AJAX
    $.ajax({
      url: 'submit_review.jsp', // Replace with the actual URL for form submission
      type: 'POST',
      data: formData,
      success: function(response) {
        // Show success message or perform any desired action
        alert('Feedback submitted successfully!');
        window.location.href = 'user_dashboard.jsp'; // Redirect to user_login.jsp
      },
      error: function(xhr, status, error) {
        // Handle error, if any
        alert('Feedback submission failed. Please try again.');
      }
    });
  });
});
</script>



<script>
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
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