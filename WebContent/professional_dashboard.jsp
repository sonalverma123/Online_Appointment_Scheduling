<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="com.bean.appointment.User" %>
    <%@ page import="com.servlet.appointment.NotificationUtils" %>
    
    
    <%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Professional Dashboard</title>
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
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String email = (String) request.getSession().getAttribute("email");

    if (email != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
            stmt = conn.prepareStatement("SELECT * FROM healthcare_professionals WHERE email=?");
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String profession = rs.getString("profession");
                String bio = rs.getString("bio");
                String location = rs.getString("location");
                String availability = rs.getString("availability");

                if (request.getParameter("updateProfile") != null) {
                    // Update profile
                    name = request.getParameter("name");
                    profession = request.getParameter("profession");
                    bio = request.getParameter("bio");
                    location = request.getParameter("location");
                    availability = request.getParameter("availability");

                    PreparedStatement updateStmt = conn.prepareStatement(
                            "UPDATE healthcare_professionals SET name=?, profession=?, bio=?, location=?, availability=? WHERE email=?");
                    updateStmt.setString(1, name);
                    updateStmt.setString(2, profession);
                    updateStmt.setString(3, bio);
                    updateStmt.setString(4, location);
                    updateStmt.setString(5, availability);
                    updateStmt.setString(6, email);
                    updateStmt.executeUpdate();

                    // Refresh the ResultSet after update
                    rs = stmt.executeQuery();
                }

                request.setAttribute("name", name);
                request.setAttribute("email", email);
                request.setAttribute("profession", profession);
                request.setAttribute("bio", bio);
                request.setAttribute("location", location);
                request.setAttribute("availability", availability);
                
                // Get unread notification count
                int healthcareProfessionalId = rs.getInt("id");
                int unreadNotificationCount = NotificationUtils.getUnreadNotificationCount(conn, healthcareProfessionalId);
                request.setAttribute("unreadAppointmentCount", unreadNotificationCount);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
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
    }
%>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>Professional Dashboard</h1>
            <hr>
            <%-- Profile section --%>
            <c:if test="${email != null}">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card bg-primary text-white">
                            <div class="card-header">
                                    <h3>Welcome, ${name}!</h3>
                                </div>
                            <div class="card-body">
                                <form method="post" action="">
                                    <div class="form-group">
                                        <label for="name">Name:</label>
                                        <input type="text" name="name" class="form-control"
                                               value="<c:out value="${name}"/>">
                                    </div>
                                    <div class="form-group">
                                        <label for="profession">Profession:</label>
                                        <input type="text" name="profession" class="form-control"
                                               value="<c:out value="${profession}"/>">
                                    </div>
                                    <div class="form-group">
                                        <label for="bio">Bio:</label>
                                        <textarea name="bio" class="form-control" rows="3">
                                            <c:out value="${bio}"/>
                                        </textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="location">Location:</label>
                                        <input type="text" name="location" class="form-control"
                                               value="<c:out value="${location}"/>">
                                    </div>
                                    <div class="form-group">
                                        <label for="availability">Availability:</label>
                                        <input type="text" name="availability" class="form-control"
                                               value="<c:out value="${availability}"/>">
                                    </div>
                                    <!-- Message with a link to show the button -->
<p id="updateMessage" style="font-weight: bold; margin-bottom: 10px; color: #000000;">Please update your profile. <a href="#" onclick="showUpdateButton()" style="color: #333333;">Click here</a> to update.</p>


        <!-- Update Profile button (initially hidden) -->
        <button id="updateButton" type="submit" name="updateProfile" class="btn btn-success" style="display: none;">Update Profile</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <script>
function showUpdateButton() {
    // Show the Update Profile button
    document.getElementById("updateButton").style.display = "block";
    // Hide the message
    document.getElementById("updateMessage").style.display = "none";
}
</script>
                  <div class="col-md-8">
                  <!-- Other sections of the dashboard go here -->
                  <div class="card">
                     <div class="card-header">
                        <h3>Appointments</h3>
                     </div>
                     <div class="card-header">
    <h3>Upcoming Appointments</h3>
    <button id="notificationBtn" class="btn btn-primary">Notifications (<c:out value="${unreadAppointmentCount}"/>)</button>
</div>
<div class="card-body">
        <p>Notification count: <span id="unreadAppointmentCount"><c:out value="${unreadAppointmentCount}"/></span></p>
        <!-- Add your appointment list here -->
        <!-- ... -->
    </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <hr>
            <div class="profile-buttons">
              <a href="change_password.jsp" class="btn btn-primary" style="background-color: #FF0000;">Change Password</a>


                
            </div>
        </div>
    </div>
</div>

 

      <%
   conn = null;
 stmt = null;
  rs = null;
   
   // Get the professional's ID from the session
   int professionalId = (int) session.getAttribute("healthcare_professional_id");
   
   try {
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
      
      // Retrieve the feedback for the professional based on appointment ID
      stmt = conn.prepareStatement("SELECT * FROM reviews WHERE healthcare_professional_id = ?");
      stmt.setInt(1, professionalId);
      rs = stmt.executeQuery();
%>


<style>
   .custom-table thead th {
      background-color: #f8f9fa;
      color: #212529;
   }

   .custom-table tbody tr:nth-child(even) {
      background-color: #f3f3f3;
   }

   .custom-table tbody tr:nth-child(odd) {
      background-color: #ffffff;
   }

   .custom-table td,
   .custom-table th {
      color: #333333;
   }
</style>



   <hr>
<div class="feedback-section">
   <h3>Feedback</h3>
   <button class="btn btn-primary" id="toggle-feedback">View Feedback</button>
   <div id="feedback-details" style="display: none;">
    <% if (!rs.next()) { %>
         <p>You have no feedback.</p>
      <% } else { %>
      <table class="table table-striped custom-table">
         <thead>
            <tr>
               <th>ID</th>
               <th>Email</th>
               <th>Rating</th>
               <th>Feedback</th>
            </tr>
         </thead>
         <tbody>
            <% while (rs.next()) { %>
               <tr>
                  <td><%= rs.getString("id") %></td>
                  <td><%= rs.getString("patient_email") %></td>
                  <td><%= rs.getInt("rating") %></td>
                  <td><%= rs.getString("review") %></td>
               </tr>
           <% } while (rs.next()); %>
         </tbody>
      </table>
           <% } %>
   </div>
</div>

<%
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
<script>
   document.getElementById("toggle-feedback").addEventListener("click", function() {
      var feedbackDetails = document.getElementById("feedback-details");
      if (feedbackDetails.style.display === "none") {
         feedbackDetails.style.display = "block";
      } else {
         feedbackDetails.style.display = "none";
      }
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
    <script>
    document.getElementById('notificationBtn').addEventListener('click', function() {
        window.location.href = 'show_appointment_professional.jsp';
    });
</script>
    
</body>

</html>