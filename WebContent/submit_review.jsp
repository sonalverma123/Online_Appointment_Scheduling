<%@ page import="java.sql.*" %>

<%
   // Retrieve form data
   int healthcareProfessionalId = Integer.parseInt(request.getParameter("professional"));
// Get the user's email from the session
String useremail = (String) session.getAttribute("email");
   int rating = Integer.parseInt(request.getParameter("rating"));
   String review = request.getParameter("review");
   java.util.Date currentDate = new java.util.Date();
   java.sql.Date date = new java.sql.Date(currentDate.getTime());

   Connection conn = null;
   PreparedStatement stmt = null;
 
   
  

   try {
      // Establish database connection
      Class.forName("com.mysql.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");

      // Insert review into the database
      stmt = conn.prepareStatement("INSERT INTO reviews (healthcare_professional_id, patient_email, rating, review, date) VALUES (?, ?, ?, ?, ?)");
      stmt.setInt(1, healthcareProfessionalId);
      stmt.setString(2, useremail);
      stmt.setInt(3, rating);
      stmt.setString(4, review);
      stmt.setDate(5, date);
      stmt.executeUpdate();

      // Redirect to user dashboard with success message
      response.sendRedirect("user_dashboard.jsp?reviewSuccess=true");
   } catch (ClassNotFoundException e) {
      e.printStackTrace();
   } catch (SQLException e) {
      e.printStackTrace();
      // Redirect to user dashboard with error message
      response.sendRedirect("user_dashboard.jsp?reviewError=true");
   } finally {
      // Close resources
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
