package com.SMS.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.SMS.database.DatabaseConnection;

@WebServlet("/InputStudents")
public class InputStudents extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user input from the form
        String studentNumber = request.getParameter("studentNumber");
        String fullName = request.getParameter("fullName");
        String birthYear = request.getParameter("birthYear");
        String sex = request.getParameter("sex");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        String sql = "INSERT INTO students (studentNumber, fullName, birthYear, sex, address, phone, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection inputConnection = null;
        PreparedStatement preparedStatement = null;

        // Get the session to set attributes
        HttpSession session = request.getSession();

        try {
            DatabaseConnection newConnection = new DatabaseConnection();
            inputConnection = newConnection.getConnection();

            // Create PreparedStatement
            preparedStatement = inputConnection.prepareStatement(sql);
            preparedStatement.setString(1, studentNumber);
            preparedStatement.setString(2, fullName);
            preparedStatement.setString(3, birthYear);
            preparedStatement.setString(4, sex);
            preparedStatement.setString(5, address);
            preparedStatement.setString(6, phone);
            preparedStatement.setString(7, email);

            // Execute the query
            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                // Successful insertion
            	session.setAttribute("updateStatus", "success");
            	session.setAttribute("updateMessage", "Operation successful!");
            	session.setAttribute("currentPage", "IndexMenu/input.jsp"); 
            } else {
                // Unsuccessful insertion
                session.setAttribute("updateStatus", "error");
                session.setAttribute("updateMessage", "Error: Student not inserted.");
                System.out.println("Input failed! Please try again.");
            }

            

        } catch (SQLException e) {
            // Handle database errors
            session.setAttribute("updateStatus", "error");
            session.setAttribute("updateMessage", "Database error: " + e.getMessage());
            
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
            

        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (inputConnection != null) inputConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
     // Redirect to index.jsp
        response.sendRedirect("index.jsp");
    }
}