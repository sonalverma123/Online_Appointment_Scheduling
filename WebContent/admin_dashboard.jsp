<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.List" %>
<%@ page import="com.bean.appointment.User" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Admin Dashboard</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">
   
    

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">
    
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    

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
                        <a href="appointment.jsp" class="nav-item nav-link">Book an Appointment</a>
                      <a href="logout.jsp" class="nav-item nav-link " style="color: red;">Logout</a>
                    
                    </div>
                </div>
            </nav>
        </div>
        </div>
        
        
<%@ page import="java.sql.*" %>
<%
// Set up database connection
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/appointment_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
String username = "root";
String password = "root";
Connection conn = DriverManager.getConnection(url, username, password);

// Process update request
if (request.getParameter("update") != null) {
    String updateType = request.getParameter("update");
    int id = Integer.parseInt(request.getParameter("id"));
    
    // Update user
    if (updateType.equals("user")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        // Update user in the database
        String updateUserQuery = "UPDATE users SET name=?, email=? WHERE id=?";
        PreparedStatement updateStmt = conn.prepareStatement(updateUserQuery);
        updateStmt.setString(1, name);
        updateStmt.setString(2, email);
        updateStmt.setInt(3, id);
        updateStmt.executeUpdate();
    }
    
    // Update healthcare professional
    else if (updateType.equals("professional")) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String profession = request.getParameter("profession");
        String bio = request.getParameter("bio");
        String location = request.getParameter("location");
        String availability = request.getParameter("availability");
        
        // Update healthcare professional in the database
        String updateProfessionalQuery = "UPDATE healthcare_professionals SET name=?, email=?, profession=?, bio=?, location=?, availability=? WHERE id=?";
        PreparedStatement updateStmt = conn.prepareStatement(updateProfessionalQuery);
        updateStmt.setString(1, name);
        updateStmt.setString(2, email);
        updateStmt.setString(3, profession);
        updateStmt.setString(4, bio);
        updateStmt.setString(5, location);
        updateStmt.setString(6, availability);
        updateStmt.setInt(7, id);
        updateStmt.executeUpdate();
    }
    
    // Update appointment
    else if (updateType.equals("appointment")) {
        String department = request.getParameter("department");
        String phoneNumber = request.getParameter("phone_number");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String appointmentDate = request.getParameter("appointment_date");
        String appointmentTime = request.getParameter("appointment_time");
        String appointmentStatus = request.getParameter("appointment_status");
        String notes = request.getParameter("notes");
        String notificationStatus = request.getParameter("notification_status");
        
        // Update appointment in the database
        String updateAppointmentQuery = "UPDATE appointments SET department=?, phone_number=?, name=?, email=?, appointment_date=?, appointment_time=?, appointment_status=?, notes=?, notification_status=? WHERE id=?";
        PreparedStatement updateStmt = conn.prepareStatement(updateAppointmentQuery);
        updateStmt.setString(1, department);
        updateStmt.setString(2, phoneNumber);
        updateStmt.setString(3, name);
        updateStmt.setString(4, email);
        updateStmt.setString(5, appointmentDate);
        updateStmt.setString(6, appointmentTime);
        updateStmt.setString(7, appointmentStatus);
        updateStmt.setString(8, notes);
        updateStmt.setString(9, notificationStatus);
        updateStmt.setInt(10, id);
        updateStmt.executeUpdate();
    }
}
//Process delete request
else if (request.getParameter("delete") != null) {
 String deleteType = request.getParameter("delete");
 int id = Integer.parseInt(request.getParameter("id"));
 
 // Delete user
 if (deleteType.equals("user")) {
     // Delete user from the database
     String deleteUserQuery = "DELETE FROM users WHERE id=?";
     PreparedStatement deleteStmt = conn.prepareStatement(deleteUserQuery);
     deleteStmt.setInt(1, id);
     deleteStmt.executeUpdate();
     
     response.sendRedirect("admin_dashboard.jsp");
 }
 
 // Delete healthcare professional
 else if (deleteType.equals("professional")) {
     // Delete healthcare professional from the database
     String deleteProfessionalQuery = "DELETE FROM healthcare_professionals WHERE id=?";
     PreparedStatement deleteStmt = conn.prepareStatement(deleteProfessionalQuery);
     deleteStmt.setInt(1, id);
     deleteStmt.executeUpdate();
     
     response.sendRedirect("admin_dashboard.jsp");
 }
 
 // Delete appointment
 else if (deleteType.equals("appointment")) {
     // Delete appointment from the database
     String deleteAppointmentQuery = "DELETE FROM appointments WHERE id=?";
     PreparedStatement deleteStmt = conn.prepareStatement(deleteAppointmentQuery);
     deleteStmt.setInt(1, id);
     deleteStmt.executeUpdate();
     
     response.sendRedirect("admin_dashboard.jsp");
 }
}


//Fetch total number of registered users
String countUsersQuery = "SELECT COUNT(*) as total FROM users";
String activeUsersQuery = "SELECT COUNT(*) as activeCount FROM users WHERE active = 1";
String inactiveUsersQuery = "SELECT COUNT(*) as inactiveCount FROM users WHERE active = 0";

Statement countStmt = conn.createStatement();
ResultSet countRs = countStmt.executeQuery(countUsersQuery);
int totalUsers = 0;
if (countRs.next()) {
 totalUsers = countRs.getInt("total");
}
countStmt.close();
countRs.close();

Statement activeUsersStmt = conn.createStatement();
ResultSet activeUsersRs = activeUsersStmt.executeQuery(activeUsersQuery);
int activeUsersCount = 0;
if (activeUsersRs.next()) {
 activeUsersCount = activeUsersRs.getInt("activeCount");
}
activeUsersStmt.close();
activeUsersRs.close();

Statement inactiveUsersStmt = conn.createStatement();
ResultSet inactiveUsersRs = inactiveUsersStmt.executeQuery(inactiveUsersQuery);
int inactiveUsersCount = 0;
if (inactiveUsersRs.next()) {
 inactiveUsersCount = inactiveUsersRs.getInt("inactiveCount");
}
inactiveUsersStmt.close();
inactiveUsersRs.close();


//Fetch users with search, filter, and sort options
String search = request.getParameter("search");
String filter = request.getParameter("filter");
String sort = request.getParameter("sort");

String getUsersQuery = "SELECT * FROM users WHERE 1=1";
if (search != null && !search.isEmpty()) {
 getUsersQuery += " AND (name LIKE ? OR email LIKE ?)";
}
if (filter != null && !filter.isEmpty()) {
 getUsersQuery += " AND role = ?";
}
if (sort != null && !sort.isEmpty()) {
 getUsersQuery += " ORDER BY " + sort;
}

PreparedStatement userStmt = conn.prepareStatement(getUsersQuery);

int paramIndex = 1;
if (search != null && !search.isEmpty()) {
 String searchParam = "%" + search + "%";
 userStmt.setString(paramIndex++, searchParam);
 userStmt.setString(paramIndex++, searchParam);
}
if (filter != null && !filter.isEmpty()) {
 userStmt.setString(paramIndex++, filter);
}

ResultSet userRs1 = userStmt.executeQuery();

//Fetch users
String getUsersQuery1 = "SELECT * FROM users";
Statement userStmt1 = conn.createStatement();
ResultSet userRs2 = userStmt1.executeQuery(getUsersQuery1);

//Fetch total number of registered professionals
String countUsersQuery1 = "SELECT COUNT(*) as total FROM healthcare_professionals";
Statement countStmt1 = conn.createStatement();
ResultSet countRs1 = countStmt1.executeQuery(countUsersQuery1);
int totalProfessionals1 = 0;
if (countRs1.next()) {
 totalProfessionals1 = countRs1.getInt("total");
}
countStmt1.close();
countRs1.close();

//Fetch counts for each specialty
String getSpecialtyCountsQuery = "SELECT COUNT(*) AS count FROM healthcare_professionals WHERE profession = ?";
PreparedStatement specialtyStmt = conn.prepareStatement(getSpecialtyCountsQuery);

int nephrologist = 0;
int cardiologyCount = 0;
int dentalCount = 0;
int generalHealthCount = 0;
int neurologyCount = 0;
int opthamologist = 0;
int ENT_specialist = 0;
int dermatologist = 0;
int orthologist = 0;



//nephrologist count
specialtyStmt.setString(1, "nephrologist");
ResultSet nephrologistRs = specialtyStmt.executeQuery();
if (nephrologistRs.next()) {
	nephrologist = nephrologistRs.getInt("count");
}
nephrologistRs.close();

//Cardiology count
specialtyStmt.setString(1, "cardiologist");
ResultSet cardiologyRs = specialtyStmt.executeQuery();
if (cardiologyRs.next()) {
 cardiologyCount = cardiologyRs.getInt("count");
}
cardiologyRs.close();

//Dental count
specialtyStmt.setString(1, "Dentist");
ResultSet dentalRs = specialtyStmt.executeQuery();
if (dentalRs.next()) {
 dentalCount = dentalRs.getInt("count");
}
dentalRs.close();

//General Health count
specialtyStmt.setString(1, "General_doctor");
ResultSet generalHealthRs = specialtyStmt.executeQuery();
if (generalHealthRs.next()) {
 generalHealthCount = generalHealthRs.getInt("count");
}
generalHealthRs.close();

//Neurology count
specialtyStmt.setString(1, "neurologist");
ResultSet neurologyRs = specialtyStmt.executeQuery();
if (neurologyRs.next()) {
 neurologyCount = neurologyRs.getInt("count");
}
neurologyRs.close();


//Opthamologist count
specialtyStmt.setString(1, "opthamologist");
ResultSet opthamologistRs = specialtyStmt.executeQuery();
if (opthamologistRs.next()) {
	opthamologist = opthamologistRs.getInt("count");
}
opthamologistRs.close();

//ENT_specialist count
specialtyStmt.setString(1, "ent_specialist");
ResultSet ENT_specialistRs = specialtyStmt.executeQuery();
if (ENT_specialistRs.next()) {
	ENT_specialist= ENT_specialistRs.getInt("count");
}
ENT_specialistRs.close();

//Dermatologist count
specialtyStmt.setString(1, "dermatologist");
ResultSet dermatologistRs = specialtyStmt.executeQuery();
if (dermatologistRs.next()) {
	dermatologist = dermatologistRs.getInt("count");
}
dermatologistRs.close();

//Orthologist count
specialtyStmt.setString(1, "orthologist");
ResultSet orthologistRs = specialtyStmt.executeQuery();
if (orthologistRs.next()) {
	orthologist = orthologistRs.getInt("count");
}
orthologistRs.close();

specialtyStmt.close();

//Fetch healthcare professionals with search, filter, and sort options
String searchProfessional = request.getParameter("searchProfessional");
String filterProfessional = request.getParameter("filterProfessional");
String sortProfessional = request.getParameter("sortProfessional");

String getProfessionalsQuery = "SELECT * FROM healthcare_professionals WHERE 1=1";
if (searchProfessional != null && !searchProfessional.isEmpty()) {
  getProfessionalsQuery += " AND (name LIKE ? OR email LIKE ?)";
}
if (filterProfessional != null && !filterProfessional.isEmpty()) {
  getProfessionalsQuery += " AND profession = ?";
}
if (sortProfessional != null && !sortProfessional.isEmpty()) {
  getProfessionalsQuery += " ORDER BY " + sortProfessional;
}

PreparedStatement professionalStmt = conn.prepareStatement(getProfessionalsQuery);

int paramIndexProfessional = 1;
if (searchProfessional != null && !searchProfessional.isEmpty()) {
  String searchProfessionalParam = "%" + searchProfessional + "%";
  professionalStmt.setString(paramIndexProfessional++, searchProfessionalParam);
  professionalStmt.setString(paramIndexProfessional++, searchProfessionalParam);
}
if (filterProfessional != null && !filterProfessional.isEmpty()) {
  professionalStmt.setString(paramIndexProfessional++, filterProfessional);
}

ResultSet professionalRs = professionalStmt.executeQuery();


//Fetch healthcare professionals
String getProfessionalsQuery1 = "SELECT * FROM healthcare_professionals";
Statement professionalStmt1 = conn.createStatement();
ResultSet professionalRs1 = professionalStmt1.executeQuery(getProfessionalsQuery1);

//Fetch total number of past and upcoming appointments
String pastAppointmentsQuery = "SELECT COUNT(*) as pastCount FROM appointments WHERE appointment_date < CURDATE()";
String upcomingAppointmentsQuery = "SELECT COUNT(*) as upcomingCount FROM appointments WHERE appointment_date >= CURDATE()";

Statement pastAppointmentsStmt = conn.createStatement();
ResultSet pastAppointmentsRs = pastAppointmentsStmt.executeQuery(pastAppointmentsQuery);
int pastAppointmentsCount = 0;
if (pastAppointmentsRs.next()) {
 pastAppointmentsCount = pastAppointmentsRs.getInt("pastCount");
}

Statement upcomingAppointmentsStmt = conn.createStatement();
ResultSet upcomingAppointmentsRs = upcomingAppointmentsStmt.executeQuery(upcomingAppointmentsQuery);
int upcomingAppointmentsCount = 0;
if (upcomingAppointmentsRs.next()) {
 upcomingAppointmentsCount = upcomingAppointmentsRs.getInt("upcomingCount");
}

pastAppointmentsStmt.close();
pastAppointmentsRs.close();
upcomingAppointmentsStmt.close();
upcomingAppointmentsRs.close();

//Fetch total number of appointments
String countUsersQuery2 = "SELECT COUNT(*) as total FROM appointments";
Statement countStmt2 = conn.createStatement();
ResultSet countRs2 = countStmt2.executeQuery(countUsersQuery2);
int totalAppointments = 0;
if (countRs2.next()) {
 totalAppointments = countRs2.getInt("total");
}
countStmt2.close();
countRs2.close();

//Fetch appointments with search, filter, and sort options
String searchAppointment = request.getParameter("searchAppointment");
String filterAppointment = request.getParameter("filterAppointment");
String sortAppointment = request.getParameter("sortAppointment");

String getAppointmentsQuery = "SELECT * FROM appointments WHERE 1=1";
if (searchAppointment != null && !searchAppointment.isEmpty()) {
  getAppointmentsQuery += " AND (name LIKE ? OR email LIKE ?)";
}
if (filterAppointment != null && !filterAppointment.isEmpty()) {
  getAppointmentsQuery += " AND department = ?";
}
if (sortAppointment != null && !sortAppointment.isEmpty()) {
  getAppointmentsQuery += " ORDER BY " + sortAppointment;
}

PreparedStatement appointmentStmt = conn.prepareStatement(getAppointmentsQuery);

int paramIndexAppointment = 1;
if (searchAppointment != null && !searchAppointment.isEmpty()) {
  String searchAppointmentParam = "%" + searchAppointment + "%";
  appointmentStmt.setString(paramIndexAppointment++, searchAppointmentParam);
  appointmentStmt.setString(paramIndexAppointment++, searchAppointmentParam);
}
if (filterAppointment != null && !filterAppointment.isEmpty()) {
  appointmentStmt.setString(paramIndexAppointment++, filterAppointment);
}

ResultSet appointmentRs = appointmentStmt.executeQuery();



//Fetch appointments
String getAppointmentsQuery1 = "SELECT * FROM appointments";
Statement appointmentStmt1 = conn.createStatement();
ResultSet appointmentRs1 = appointmentStmt1.executeQuery(getAppointmentsQuery1);
%>
<div class="box-container">
  <div class="box" id="users-box" onclick="showUsersTable()" title="Please click to view details of users">
    <h4>User Management</h4>
    <p><span id="total-users"><h6>Total Users: <%= totalUsers %></h6></span></p>
    <p><span id="Active Users"><h6>Active Users: <%= activeUsersCount %></h6></span></p>
    <p><span id="Inactive Users"><h6>Inactive Users: <%= inactiveUsersCount %></h6></span></p>
  </div>
  <div class="box" id="professionals-box" onclick="showProfessionalsTable()" title="Please click to view details of healthcare professionals">
    <h4>Healthcare Professional Management</h4>
    <p><span id="Total Professionals"><h6>Total Healthcare Professionals: <%= totalProfessionals1 %></h6></span></p>
  </div>
  <div class="box" id="appointments-box" onclick="showAppointmentsTable()" title="Please click to view details of appointments">
    <h5>Appointment Management</h5>
    <p><span id="Total Appointments"><h6>Total Appointments: <%= totalAppointments %></h6></span></p>
    <p><span id="pastAppointments"><h6>Past Appointments: <%= pastAppointmentsCount %></h6></span></p>
    <p><span id="upcomingAppointments"><h6>Upcoming Appointments: <%= upcomingAppointmentsCount %></h6></span></p>
  </div>
</div>


<div class="chart-container">
  <div class="chart">
    <div id="users-chart"></div>
  </div>
  <div class="chart">
    <div id="professionals-chart"></div>
  </div>
  <div class="chart">
    <div id="appointments-chart"></div>
  </div>
</div>
<style>
  .box-container {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
  }

  .box {
    width: 200px;
    height: 200px;
    margin: 10px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
  }

  #users-box {
    background-color: #FF0000;
  }

  #professionals-box {
    background-color: #00FF00;
  }

  #appointments-box {
    background-color: #0000FF;
  }

  .chart-container {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: flex-start;
  }

  .chart {
    width: 300px;
    height: 300px;
    margin: 10px;
  }
</style>

<script>
  function showUsersTable() {
    toggleTable("users-container");
  }

  function showProfessionalsTable() {
    toggleTable("professionals-container");
  }

  function showAppointmentsTable() {
    toggleTable("appointments-container");
  }

  function toggleTable(tableId) {
    var table = document.getElementById(tableId);

    // Toggle the display of the table
    if (table.style.display === "block") {
      table.style.display = "none";
    } else {
      hideTables();
      table.style.display = "block";
    }
  }

  function hideTables() {
    var containers = document.getElementsByClassName("container");
    for (var i = 0; i < containers.length; i++) {
      containers[i].style.display = "none";
    }
  }
</script>



<!-- Users table -->
<div id="users-container" style="display: none;">
  <form action="admin_dashboard.jsp" method="GET" style="background-color: #f2f2f2; padding: 10px; border-radius: 5px;">
    <label for="search">Search:</label>
    <input type="text" id="search" name="search" placeholder="Search by Name or Email" style="padding: 5px; border: none; border-radius: 3px;">
    
    <label for="filter">Filter:</label>
    <select id="filter" name="filter" style="padding: 5px; border: none; border-radius: 3px;">
      <option value="">All</option>
      <option value="admin">Admin</option>
      <option value="user">User</option>
      <!-- Add more options for other roles -->
    </select>
    
    <label for="sort">Sort:</label>
    <select id="sort" name="sort" style="padding: 5px; border: none; border-radius: 3px;">
      <option value="">None</option>
      <option value="name ASC">Name (Ascending)</option>
      <option value="name DESC">Name (Descending)</option>
      <option value="email ASC">Email (Ascending)</option>
      <option value="email DESC">Email (Descending)</option>
    </select>
    
    <button type="submit" style="padding: 5px 10px; background-color: #4CAF50; color: white; border: none; border-radius: 3px; cursor: pointer;">Apply</button>
  </form>




<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }

  th {
    background-color: #f2f2f2;
  }

  input[type="text"] {
    width: 100%;
    padding: 4px;
    border: none;
    border-radius: 4px;
    box-sizing: border-box;
  }

  .action-button {
    padding: 6px 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .action-button:hover {
    background-color: #45a049;
  }

  a {
    color: #4CAF50;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
  }
</style>

<table>
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Actions</th>
  </tr>
  <% while (userRs1.next()) { %>
  <tr>
    <form action="admin_dashboard.jsp" method="POST">
        <input type="hidden" name="update" value="user">
        <input type="hidden" name="id" value="<%= userRs1.getInt("id") %>">
        <td><%= userRs1.getInt("id") %></td>
        <td><input type="text" name="name" value="<%= userRs1.getString("name") %>"></td>
        <td><input type="text" name="email" value="<%= userRs1.getString("email") %>"></td>
        <td>
          <button type="submit" class="action-button">Update</button>
          <button type="submit" class="action-button" formaction="?delete=user&id=<%= userRs1.getInt("id") %>"
            onclick="return confirm('Are you sure you want to delete this user?')">Delete</button>
        </td>
    </form>
  </tr>
  <% } %>
</table>



</div>



<!-- Users chart -->
<script>
  // Load the visualization library
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback function to run when the Google Charts library is loaded
  google.charts.setOnLoadCallback(drawChart);

  // Callback function to create and draw the chart
  function drawChart() {
    // Create the data table
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Status');
    data.addColumn('number', 'Count');
    data.addRows([
      ['Active Users', <%= activeUsersCount %>], // Replace with actual data values
      ['Inactive Users', <%= inactiveUsersCount %>], // Replace with actual data values
    ]);

    // Set chart options
    var options = {
      title: 'User Status',
      pieHole: 0.4,
      colors: ['#FF0000', '#00FF00'], // Customize the colors
      backgroundColor: 'transparent', // Set background color to transparent
    };

    // Instantiate and draw the chart
    var chart = new google.visualization.PieChart(document.getElementById('users-chart'));
    chart.draw(data, options);
  }
</script>



<div id="professionals-container" style="display: none;">
 <form action="admin_dashboard.jsp" method="GET" style="background-color: #f2f2f2; padding: 10px; border-radius: 5px;">
   
   <label for="search">Search:</label>
    <input type="text" name="searchProfessional" placeholder="Search by Name or Email" style="padding: 5px; border: none; border-radius: 3px;">
   
    <label for="filter">Filter:</label>
    <select id="filter" name="filterProfessional" style="padding: 5px; border: none; border-radius: 3px;">
        <option value="">All</option>
          <option value="Cardiologist">Cardiologist</option>
    <option value="Neurologist">Neurologist</option>
    <option value="Dentist">Dentist</option>
    <option value="Nephrologist">Nephrologist</option>
    <option value="Opthamologist">Opthamologist</option>
    <option value="General Doctor">General Doctor</option>
    <option value="ENT Specialist">ENT Specialist</option>
    <option value="Dermatologist">Dermatologist</option>
    <option value="Orthologist">Orthologist</option>
        <!-- Add more options for other professions -->
    </select>
    
       <label for="sort">Sort:</label>
    <select name="sortProfessional" id="sort" style="padding: 5px; border: none; border-radius: 3px;">
        <option value="">None</option>
        <option value="name ASC">Name (Ascending)</option>
        <option value="name DESC">Name (Descending)</option>
        <option value="email ASC">Email (Ascending)</option>
        <option value="email DESC">Email (Descending)</option>
    </select>
    <button type="submit" style="padding: 5px 10px; background-color: #4CAF50; color: white; border: none; border-radius: 3px; cursor: pointer;">Apply</button>
</form>

<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }

  th {
    background-color: #f2f2f2;
  }

  input[type="text"] {
    width: 100%;
    padding: 4px;
    border: none;
    border-radius: 4px;
    box-sizing: border-box;
  }

 .action-button {
    padding: 6px 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .action-button:hover {
    background-color: #45a049;
  }

  a {
    color: #4CAF50;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
  }
</style>
 <table>
     <tr>
         <th>ID</th>
         <th>Name</th>
         <th>Email</th>
         <th>Profession</th>
         <th>Bio</th>
         <th>Location</th>
         <th>Availability</th>
     </tr>
  <% while (professionalRs.next()) { %>
         <tr>
             <form action="admin_dashboard.jsp" method="POST">
                 <input type="hidden" name="update" value="professional">
                 <input type="hidden" name="id" value="<%= professionalRs.getInt("id") %>">
                 <td><%= professionalRs.getInt("id") %></td>
                 <td><input type="text" name="name" value="<%= professionalRs.getString("name") %>"></td>
                 <td><input type="text" name="email" value="<%= professionalRs.getString("email") %>"></td>
                 <td><input type="text" name="profession" value="<%= professionalRs.getString("profession") %>"></td>
                 <td><input type="text" name="bio" value="<%= professionalRs.getString("bio") %>"></td>
                 <td><input type="text" name="location" value="<%= professionalRs.getString("location") %>"></td>
                 <td><input type="text" name="availability" value="<%= professionalRs.getString("availability") %>"></td>
                 <td><button type="submit" class="action-button">Update</button></td>
                 <td>
                 <button type="submit" class="action-button" formaction="?delete=professional&id=<%= professionalRs.getInt("id") %>"
                   onclick="return confirm('Are you sure you want to delete this healthcare professional?')">Delete</button>
            </td>
             </form>
         </tr>
     <% } %>
 </table>
 </div>
 
 <!-- Professionals chart -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', { 'packages': ['bar'] });
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Profession', 'Count'],
    ['Neurologist', <%= neurologyCount %>],
    ['Nephrologist', <%= nephrologist %>],
    ['Cardiologist', <%= cardiologyCount %>],
    ['Dentals', <%= dentalCount %>],
    ['General Health Professionals', <%= generalHealthCount %>],
    ['Opthamologist', <%= opthamologist %>],
    ['ENT Specialist', <%= ENT_specialist %>],
    ['Dermatologist', <%= dermatologist %>],
    ['Orthologist', <%= orthologist %>]
  ]);

  var options = {
    title: 'Healthcare Professionals',
    legend: { position: 'none' },
    chart: {
      title: 'Healthcare Professionals',
      
    },
    bars: 'horizontal',
    vAxis: {
      textPosition: 'in',
    },
    chartArea: {
      width: '80%',
      height: '70%'
    },
    height: 300
  };

  var chart = new google.charts.Bar(document.getElementById('professionals-chart'));
  chart.draw(data, google.charts.Bar.convertOptions(options));
}

</script>


    
<div id="appointments-container" style="display: none;">
<form action="admin_dashboard.jsp" method="GET" style="background-color: #f2f2f2; padding: 10px; border-radius: 5px;">
    <input type="text" name="searchAppointment" placeholder="Search by Name or Email" style="padding: 5px; border: none; border-radius: 3px;">
    
     <label for="filter">Filter:</label>
    <select id="filter" name="filterAppointment" style="padding: 5px; border: none; border-radius: 3px;">
        <option value="">All</option>
        <option value="Cardiologist">Cardiologist</option>
    <option value="Neurologist">Neurologist</option>
    <option value="Dentist">Dentist</option>
    <option value="Nephrologist">Nephrologist</option>
    <option value="Opthamologist">Opthamologist</option>
    <option value="General Doctor">General Doctor</option>
    <option value="ENT Specialist">ENT Specialist</option>
    <option value="Dermatologist">Dermatologist</option>
    <option value="Orthologist">Orthologist</option>
    </select>
    <select id="sort" name="sortAppointment" style="padding: 5px; border: none; border-radius: 3px;">
        <option value="">None</option>
        <option value="appointment_date ASC">Appointment Date (Ascending)</option>
        <option value="appointment_date DESC">Appointment Date (Descending)</option>
        <option value="appointment_time ASC">Appointment Time (Ascending)</option>
        <option value="appointment_time DESC">Appointment Time (Descending)</option>
    </select>
    <button type="submit" style="padding: 5px 10px; background-color: #4CAF50; color: white; border: none; border-radius: 3px; cursor: pointer;">Apply</button>
</form>


<!-- Appointments table -->

<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }

  th {
    background-color: #f2f2f2;
  }

  input[type="text"] {
    width: 100%;
    padding: 4px;
    border: none;
    border-radius: 4px;
    box-sizing: border-box;
  }

  .action-button {
    padding: 6px 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .action-button:hover {
    background-color: #45a049;
  }

  a {
    color: #4CAF50;
    text-decoration: none;
  }

  a:hover {
    text-decoration: underline;
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
    <th>Appointment Status</th>
    <th>Notes</th>
    <th>Notification Status</th>
  </tr>
  <% while (appointmentRs.next()) { %>
  <tr>
    <form action="admin_dashboard.jsp" method="POST">
      <input type="hidden" name="update" value="appointment">
      <input type="hidden" name="id" value="<%= appointmentRs.getInt("id") %>">
      <td><%= appointmentRs.getInt("id") %></td>
      <td><input type="text" name="department" value="<%= appointmentRs.getString("department") %>"></td>
      <td><input type="text" name="phone_number" value="<%= appointmentRs.getString("phone_number") %>"></td>
      <td><input type="text" name="name" value="<%= appointmentRs.getString("name") %>"></td>
      <td><input type="text" name="email" value="<%= appointmentRs.getString("email") %>"></td>
      <td><input type="text" name="appointment_date" value="<%= appointmentRs.getString("appointment_date") %>"></td>
      <td><input type="text" name="appointment_time" value="<%= appointmentRs.getString("appointment_time") %>"></td>
      <td><input type="text" name="appointment_status" value="<%= appointmentRs.getString("appointment_status") %>"></td>
      <td><input type="text" name="notes" value="<%= appointmentRs.getString("notes") %>"></td>
      <td><input type="text" name="notification_status" value="<%= appointmentRs.getString("notification_status") %>"></td>
      <td><button type="submit" class="action-button">Update</button></td>
      <td>
                 <button type="submit" class="action-button" formaction="?delete=appointment&id=<%= appointmentRs.getInt("id") %>"
          class="delete"
          onclick="return confirm('Are you sure you want to delete this appointment?')">Delete</button>
      </td>
    </form>
  </tr>
  <% } %>
</table>
</div>

 

<!-- Appointments chart -->
<script>
  // Load the visualization library
  google.charts.load('current', {'packages':['corechart']});

  // Set a callback function to run when the Google Charts library is loaded
  google.charts.setOnLoadCallback(drawChart);

  // Callback function to create and draw the chart
  function drawChart() {
    // Create the data table
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Status');
    data.addColumn('number', 'Count');
    data.addRows([
      ['Past', <%= pastAppointmentsCount %>], // Replace with actual data value
      ['Upcoming Appointments', <%= upcomingAppointmentsCount %>], // Replace with actual data value
    ]);

    // Set chart options
    var options = {
      title: 'Appointments',
      pieHole: 0.4,
      colors: ['#FF0000', '#00FF00'], // Customize the colors
      backgroundColor: 'transparent', // Set background color to transparent
    };

    // Instantiate and draw the chart
    var chart = new google.visualization.PieChart(document.getElementById('appointments-chart'));
    chart.draw(data, options);
  }
</script>


 <% 
 // Close all database resources
 userRs1.close();
userStmt.close();
professionalRs.close();
professionalStmt.close();
appointmentRs.close();
appointmentStmt.close();
conn.close();
 %>
</body>
</html>


   
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