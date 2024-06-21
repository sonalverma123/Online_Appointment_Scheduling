<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@ page import="java.sql.*" %>
<html lang="en">

<head>
    <meta charset="utf-8">
  <title>Online Appointment scheduling</title>
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


    <!-- Appointment Start -->
  <div class="container-fluid py-5">
        <div class="container">
            <div class="row gx-5">
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <div class="mb-4">
                        <h5 class="d-inline-block text-primary text-uppercase border-bottom border-5">Appointment</h5>
                        <h1 class="display-4">Make An Appointment For Your Family</h1>
                    </div>
                 
                    <p class="mb-5">Make an appointment for your family and ensure their well-being with our comprehensive healthcare services. Our experienced professionals are dedicated to providing personalized care and addressing all your family's medical needs. Schedule your appointment today and prioritize the health of your loved ones.</p>
                    <a class="btn btn-primary rounded-pill py-3 px-5 me-3" href="search.jsp">Find Doctor</a>
                    <a class="btn btn-outline-primary rounded-pill py-3 px-5" href="">Read More</a>
                </div>
                <%
   String email = (String) request.getSession().getAttribute("email");
   boolean isLoggedIn = (email != null);
%>

<script>
function submitForm() {
    if (<%= isLoggedIn %>) {
        document.getElementById("appointmentForm").submit();
        showSuccessMessage();
    } else {
        showLoginPopup();
    }
}

	function showLoginPopup() {
	   // Display a popup box asking the user to login
	   alert("Please login first before booking an appointment.");
	   
	   
       // Redirect to user_login.jsp
       window.location.href = "user_login.jsp";
	 
	}
	
	 function showSuccessMessage() {
	        // Display a success message after a successful booking
	        alert("Appointment booked successfully! Thank you.");
	        // Redirect to the user dashboard
	        window.location.href = "user_dashboard.jsp";
	    }
	 
</script>
           <div class="col-lg-6">
    <div class="bg-light text-center rounded p-5">
        <h1 class="mb-4">Book An Appointment</h1>
        <form id="appointmentForm" action="AppointmentServlet" method="post">
            <% if (!isLoggedIn) { %>
            <input type="hidden" name="isRegistered" value="false">
            <% } %>

            <div class="col-12 mb-4">
                <select class="form-select bg-white border-0 rounded-pill" name="health_professional" required>
                    <option selected>Choose Health Professional</option>
                    <% 
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
                        Statement stmt = con.createStatement();
                        String query = "SELECT name, profession FROM healthcare_professionals";
                        ResultSet rs = stmt.executeQuery(query);
                        while(rs.next()){
                            String name = rs.getString("name");
                            String department = rs.getString("profession");
                    %>
                    <option value="<%=name%>"><%=name%> - <%=department%></option>
                    <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </select>
            </div>

            <div class="row">
                <div class="col-12 col-sm-6 mb-4">
                    <select class="form-select bg-white border-0 rounded-pill" name="department" required>
                        <option selected>Choose Department</option>
                        
                        <option value="Cardiology">Cardiology</option>
                        <option value="Neurology">Neurology</option>
                        <option value="Dental">Dental</option>
                         <option value="Dermatologist">Dermatology</option>
                          <option value="Orthologist">Orthology</option>
                           <option value="Nephrology">Nephrology</option>
                           <option value="ENT Specialist">ENT Specialist</option>
                           <option value="General Doctor">General Health</option>
                           <option value="Opthamologist">Opthamalogy</option>
                         
                    </select>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <input type="text" class="form-control bg-white border-0 rounded-pill" placeholder="Your Number" name="phone_number" required>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <input type="text" class="form-control bg-white border-0 rounded-pill" placeholder="Your Name" name="name" required>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <input type="email" class="form-control bg-white border-0 rounded-pill" placeholder="Your Email" name="email" required>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <div class="date" id="date" data-target-input="nearest">
                        <input type="text" class="form-control bg-white border-0 rounded-pill datetimepicker-input" placeholder="Date" data-target="#date" data-toggle="datetimepicker" name="appointment_date" required>
                    </div>
                </div>
                <div class="col-12 col-sm-6 mb-4">
                    <div class="time" id="time" data-target-input="nearest">
                        <input type="text" class="form-control bg-white border-0 rounded-pill datetimepicker-input" placeholder="Time" data-target="#time" data-toggle="datetimepicker" name="appointment_time" required>
                    </div>
                </div>
                <div class="col-12">
                    <button class="btn btn-primary w-100 py-3 rounded-pill" type="button" onclick="submitForm()">Make An Appointment</button>
                </div>
            </div>
        </form>
    </div>
</div>

   
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