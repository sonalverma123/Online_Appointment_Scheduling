<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html lang="en">

<head>
<!-- Add the following script within the <head> section -->
<script>
// Check if the page was loaded from a previous page using the back button
if (window.history && window.history.pushState) {
  $(window).on('popstate', function () {
    // Redirect the user to the desired page
    window.location.href = 'admin_registration.jsp';
  });

  // Add a new entry to the browser history
  window.history.pushState('forward', null, '');
}
</script>

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
                        <a href="index.jsp" class="nav-item nav-link active">Home</a>
                        <a href="about.jsp" class="nnav-item nav-link active">About</a>
                   <a href="blog.jsp" class="nav-item nav-link active">Blog</a>
                               <a href="team.jsp" class="nav-item nav-link active">Professionals</a>
                                <a href="testimonial.jsp" class="nav-item nav-link active">Testimonial</a>
                        <div class="nav-item">
    <a class="nav-link active" href="#">Register</a>
    <ul class="sub-menu">
        <li><a class="nav-link" href="admin_registration.jsp">Admin Registration</a></li>
        <li><a class="nav-link" href="register_healthcare_professional.jsp">Professional Registration</a></li>
        <li><a class="nav-link" href="user_register.jsp">User Registration</a></li>
    </ul>
</div>
                           <a href="user_login.jsp" class="nav-item nav-link active">Login</a>
                   
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
    



 <div class="col-lg-6">
  <div class="bg-light text-center rounded p-5" style="background-color: #f8f9fa;">
    <h1 class="mb-4" style="color: #333;">Registration Form</h1>
    <h2 style="color: #007bff;">Admin Registration Form</h2>
    <form  id="registrationForm" action="AdminRegistrationServlet" method="POST">
      <div style="margin-bottom: 15px;">
        <label for="name" style="color: #333;">Name:</label><br>
        <input type="text" name="name" required style="padding: 8px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
      </div>

      <div style="margin-bottom: 15px;">
        <label for="email" style="color: #333;">Email:</label><br>
        <input type="email" name="email" required style="padding: 8px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
      </div>

      <div style="margin-bottom: 15px;">
        <label for="password" style="color: #333;">Password:</label><br>
        <input type="password" name="password" required style="padding: 8px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
      </div>

      <div style="margin-bottom: 15px;">
        <label for="confirm_password" style="color: #333;">Confirm Password:</label><br>
        <input type="password" name="confirm_password" required style="padding: 8px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
      </div>

      <div style="margin-bottom: 15px;">
        <label for="role" style="color: #333;">Role:</label><br>
        <select name="role" required style="padding: 8px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
          <option value="">Select Role</option>
          <option value="admin">Admin</option>
          <option value="professional">Healthcare Professional</option>
          <option value="user">User</option>
        </select>
      </div>

      <input type="submit" value="Register" style="padding: 10px 20px; background-color: #007bff; border: none; color: #fff; border-radius: 4px; cursor: pointer;">
    </form>
  </div>
</div>

<script>
$(document).ready(function() {
  $('#registrationForm').submit(function(e) {
    e.preventDefault(); // Prevent form submission

    // Get form data
    var formData = $(this).serialize();

    // Send form data to server using AJAX
    $.ajax({
      url: 'AdminRegistrationServlet', // Replace with the actual URL for form submission
      type: 'POST',
      data: formData,
      success: function(response) {
        // Show success message or perform any desired action
        alert('Registration successful!');
        window.location.href = 'user_login.jsp'; // Redirect to user_login.jsp
      },
      error: function(xhr, status, error) {
        // Handle error, if any
        alert('Registration failed. Please try again.');
      }
    });
  });
});
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