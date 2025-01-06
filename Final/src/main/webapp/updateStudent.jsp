<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve student data from the form
    String studentNumber = request.getParameter("studentNumber");
    String fullName = request.getParameter("fullName");
    String birthYear = request.getParameter("birthYear");
    String sex = request.getParameter("sex");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/student_management";
    String username = "root";
    String password = "@Joshua6775";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to update student data
        String updateQuery = "UPDATE students SET fullName = ?, birthYear = ?, sex = ?, address = ?, phone = ?, email = ? WHERE studentNumber = ?";
        stmt = conn.prepareStatement(updateQuery);
        
        // Set the parameters for the update query
        stmt.setString(1, fullName);
        stmt.setString(2, birthYear);
        stmt.setString(3, sex);
        stmt.setString(4, address);
        stmt.setString(5, phone);
        stmt.setString(6, email);
        stmt.setString(7, studentNumber);

        // Execute the update query
        int rowsAffected = stmt.executeUpdate();

        // Check if the update was successful
        if (rowsAffected > 0) {
        	session.setAttribute("updateStatus", "success");
        	session.setAttribute("updateMessage", "Operation successful!");
        	session.setAttribute("currentPage", "IndexMenu/browse.jsp");
        } else {
        	session.setAttribute("updateStatus", "error");
            session.setAttribute("updateMessage", "Error: Student not deleted.");
        }
        
        
    } catch (SQLException | ClassNotFoundException e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        // Close the resources
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");
    }
%>
