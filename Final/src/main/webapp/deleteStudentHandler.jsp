<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Get the student number from the request
    String studentNumber = request.getParameter("studentNumber");

    // Initialize the response object to send back to the AJAX call
    boolean success = false;
    String message = "Student deletion failed.";

    if (studentNumber != null && !studentNumber.isEmpty()) {
        // Database connection setup
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/student_management";
            String dbUser = "root"; // MySQL default username
            String dbPassword = "@Joshua6775"; // Password for the MySQL database
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // SQL query to delete the student by student number
            String query = "DELETE FROM students WHERE studentNumber = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, studentNumber);

            int rowsAffected = preparedStatement.executeUpdate();

            // If rowsAffected > 0, the student was deleted successfully
            if (rowsAffected > 0) {
                success = true;
                message = "Student deleted successfully.";
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Set the response content type to JSON
    response.setContentType("application/json");
    
    // Create a JSON response object
    String jsonResponse = "{ \"success\": " + success + ", \"message\": \"" + message + "\" }";
    
    // Write the JSON response to the output
    response.getWriter().write(jsonResponse);
%>
