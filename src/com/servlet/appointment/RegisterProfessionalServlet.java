package com.servlet.appointment;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterProfessionalServlet")
public class RegisterProfessionalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	 // Database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/appointment_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        String profession = request.getParameter("profession");
        String bio = request.getParameter("bio");
        String role = request.getParameter("role");
        String location = request.getParameter("location");
        String availability = request.getParameter("availability");
        // Validate form data
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name cannot be empty");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email cannot be empty");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Password cannot be empty");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            return;
        }

        if (confirm_password == null || confirm_password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please confirm password");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm_password)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            return;
        }
        if (role == null || role.trim().isEmpty()) {
            response.getWriter().println("Role is required");
            return;
        }
        
        if (!role.equals("user") && !role.equals("professional") && !role.equals("admin")) {
            response.getWriter().println("Invalid role");
            return;
        }


        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Establish a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            // Check if the email address is already registered
            String checkEmailQuery = "SELECT * FROM healthcare_professionals WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailQuery);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	 out.println("<script type=\"text/javascript\">");
                out.println("alert('Email address is already registered. Please use different mail')");
                out.println("location='register_healthcare_professional.jsp';");
                out.println("</script>");
              //  response.getWriter().println("email_registered"); // Send response indicating email is already registered
            } else {
                // Insert the data into the database
                String insertQuery = "INSERT INTO healthcare_professionals (name, email, password, profession, bio, role, location, availability) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, password);
                pstmt.setString(4, profession);
                pstmt.setString(5, bio);
                pstmt.setString(6, role);
                pstmt.setString(7, location);
                pstmt.setString(8, availability);
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
                    
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Registration is successful')");
                    out.println("location='user_login.jsp';");
                    out.println("</script>");
                } else {
                   
                    
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Registration has failed')");
                    out.println("location='register_healthcare_professional.jsp';");
                    out.println("</script>");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
