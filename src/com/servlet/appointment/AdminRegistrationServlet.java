package com.servlet.appointment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminRegistrationServlet")
public class AdminRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        String role = request.getParameter("role");

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



        // Insert data into database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/appointment_db", "root", "root");

            PreparedStatement stmt = con.prepareStatement("INSERT INTO admins (name, email, password, role) VALUES (?, ?, ?, ?)");
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, role);
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                request.setAttribute("errorMessage", "Failed to register admin");
                request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            } else {
                request.setAttribute("successMessage", "Admin registered successfully");
                request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            System.out.println(e);
            request.setAttribute("errorMessage", "Failed to register admin");
            request.getRequestDispatcher("/admin_registration.jsp").forward(request, response);
        }
    }
}