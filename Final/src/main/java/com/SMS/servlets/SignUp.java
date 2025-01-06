package com.SMS.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.SMS.database.DatabaseConnection;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user input from the form
        String fname = request.getParameter("firstName");
        String lname = request.getParameter("lastName");
        String email = request.getParameter("email");
        String birthday = request.getParameter("birthday");
        String password = request.getParameter("password");

        String sql = "INSERT INTO user (fname, lname, email, age, password) VALUES (?, ?, ?, ?, ?)";

        Connection signUpConnection = null;
        PreparedStatement preparedStatement = null;

        try {
            DatabaseConnection newConnection = new DatabaseConnection();

            signUpConnection = newConnection.getConnection();

            // Create PreparedStatement
            preparedStatement = signUpConnection.prepareStatement(sql);
            preparedStatement.setString(1, fname);
            preparedStatement.setString(2, lname);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, birthday);
            preparedStatement.setString(5, password);

            // Execute the query
            int rowsInserted = preparedStatement.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("Sign-up successful! User information has been stored.");
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println("Sign-up failed! Please try again.");
            }

        } catch (SQLException e) {
            response.getWriter().println("Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (signUpConnection != null) signUpConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}