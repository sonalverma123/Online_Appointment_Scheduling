package com.servlet.appointment;

import java.io.IOException;
import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.annotation.WebServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the input values from the form
        String department = request.getParameter("department");

        // Check if the user is logged in
        HttpSession session = request.getSession();
        if (session.getAttribute("email") == null) {
            // User is not logged in, redirect to the login page
            response.sendRedirect("user_login.jsp");
            return;
        }

        
        System.out.println("Selected Department: " + department);
        
       
     

        String phoneNumber = request.getParameter("phone_number");
      //  String name = request.getParameter("name");
        String email = (String) session.getAttribute("email");
       // String name = (String) session.getAttribute("name");


        String date = request.getParameter("appointment_date");
        String time = request.getParameter("appointment_time");
        String health_professional = request.getParameter("health_professional");

        // Validate the input values
        if (department == null || department.trim().isEmpty() || phoneNumber == null || phoneNumber.trim().isEmpty()
                 || email == null || email.trim().isEmpty() || date == null
                || date.trim().isEmpty() || time == null || time.trim().isEmpty() || health_professional == null || health_professional.trim().isEmpty() ) {
        	 //  System.out.println("Validation Error: Please fill all the required fields."); // Debug statement
        	response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Please fill all the required fields.");
            return;
        }
        

     // Store the department in the session
     session.setAttribute("department", department);

        // Convert date and time to LocalDateTime object
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy h:mm a");
        LocalDateTime appointmentDateTime = LocalDateTime.parse(date + " " + time, formatter);


        Timestamp appointmentDateTimestamp = Timestamp.valueOf(appointmentDateTime);
        Timestamp appointmentTimeTimestamp = Timestamp.valueOf(appointmentDateTime);

        // Store the appointment in the database
        String name = "";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            // Retrieve the user's name from the database using the email
     
         
            try {
                // Load the MySQL driver and connect to the database
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");

                // Prepare the SQL statement to retrieve the user's name
                String retrieveNameQuery = "SELECT name FROM users WHERE email = ?";
                preparedStatement = connection.prepareStatement(retrieveNameQuery);
                preparedStatement.setString(1, email);

                // Execute the query
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    // User found, retrieve the name
                    name = resultSet.getString("name");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Failed to retrieve user's name. Please try again later.");
                return;
            } finally {
                // Close the database connection and prepared statement
                if (resultSet != null) {
                    try {
                        resultSet.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (preparedStatement != null) {
                    try {
                        preparedStatement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            
          connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/appointment_db", "root", "root");
          
          // Retrieve the healthcare professional ID
          String fetchProfessionalIdQuery = "SELECT id FROM healthcare_professionals WHERE name = ?";
          preparedStatement = connection.prepareStatement(fetchProfessionalIdQuery);
          preparedStatement.setString(1, health_professional);
          resultSet = preparedStatement.executeQuery();
          int healthcare_professional_id;
        

          if (resultSet.next()) {
              healthcare_professional_id = resultSet.getInt("id");
             
          } else {
              // Handle the case when the healthcare professional doesn't exist
              response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Healthcare professional not found.");
              return;
          }
     
          
          preparedStatement = connection.prepareStatement(
                  "INSERT INTO appointments(department, phone_number, name, email, appointment_date, appointment_time, created_at, health_professional, healthcare_professional_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, department);
            preparedStatement.setString(2, phoneNumber);
            preparedStatement.setString(3, name);
            preparedStatement.setString(4, email);
            preparedStatement.setTimestamp(5, appointmentDateTimestamp);
            preparedStatement.setTimestamp(6, appointmentTimeTimestamp);
          

            preparedStatement.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            preparedStatement.setString(8, health_professional);
            preparedStatement.setInt(9, healthcare_professional_id);
        
            
            preparedStatement.executeUpdate();
            response.sendRedirect("appointment.jsp"); // Redirect to success page
            
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Failed to save the appointment. Please try again later.");
        } finally {
            // Close the database connection and prepared statement
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

