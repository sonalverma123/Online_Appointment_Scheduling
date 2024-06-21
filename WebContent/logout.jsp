<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<head>
<script>
// Check if the page was loaded from a previous page using the back button
if (window.history && window.history.pushState) {
  $(window).on('popstate', function () {
    // Redirect the user to the desired page
    window.location.href = 'user_login.jsp';
  });

  // Add a new entry to the browser history
  window.history.pushState('forward', null, '');
}
</script>

</head>
<%
    HttpSession session1 = request.getSession();
    session.invalidate();
    String role = (String) request.getSession().getAttribute("role");
    if (role != null) {
        if (role.equals("user")) {
            response.sendRedirect("user_dashboard.jsp");
        } else if (role.equals("professional")) {
            response.sendRedirect("professional_dashboard.jsp");
        } else if (role.equals("admin")) {
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            response.sendRedirect("user_login.jsp");
        }
    } else {
        response.sendRedirect("user_login.jsp");
    }
%>

