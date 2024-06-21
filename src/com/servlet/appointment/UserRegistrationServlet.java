package com.servlet.appointment;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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

@WebServlet("/user_register")
public class UserRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		// Get form data from request
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone"); 
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = request.getParameter("role");

        // Validate form data
        if (name == null || name.trim().isEmpty()) {
            response.getWriter().println("Name is required");
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().println("Email is required");
            return;
        }
        
        if (phone == null || phone.trim().isEmpty()) {
            response.getWriter().println("Phone is required");
            return;
        }
        
        if (!email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}")) {
            response.getWriter().println("Invalid email format");
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            response.getWriter().println("Password is required");
            return;
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            response.getWriter().println("Confirm Password is required");
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            response.getWriter().println("Passwords do not match");
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

        
        // Insert data into database
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            
            // Connect to the database
            String url = "jdbc:mysql://localhost:3306/appointment_db";
            String dbUsername = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
            
            // Check if email is already registered
            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Email is already registered
            	 out.println("<script type=\"text/javascript\">");
                 out.println("alert('Email address is already registered. Please use different mail')");
                 out.println("location='user_register.jsp';");
                 out.println("</script>");
            }
        

            // Insert user data into database
            sql = "INSERT INTO users (name, email, password, role, phone) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            ps.setString(5, phone);
            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                // Registration successful
            	
                out.println("<script type=\"text/javascript\">");
                out.println("alert('User registered successfully.')");
                out.println("location='user_login.jsp';");
                out.println("</script>");

            } else {
                // Registration failed
               
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error registering user. Please try again.')");
                out.println("location='user_register.jsp';");
                out.println("</script>");
            }

            
            // Close the database connection
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
