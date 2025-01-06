package com.SMS.servlets;
import com.SMS.database.DatabaseConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Classes.Student;

/**
* Servlet implementation class BrowseStudentsServlet
*/
@WebServlet("/BrowseStudentsServlet")
public class BrowseStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // List to store students
        List<Student> students = new ArrayList<>();

        // Database connection and resources
        Connection browseConnection = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM students"; // Adjust table name as necessary

        try {
            // Establish connection
            DatabaseConnection newConnection = new DatabaseConnection();
            browseConnection = newConnection.getConnection();

            // Prepare and execute query
            preparedStatement = browseConnection.prepareStatement(sql);
            rs = preparedStatement.executeQuery();

            // Process result set and populate student list
            while (rs.next()) {
                Student student = new Student();
                student.setStudentNumber(rs.getInt("studentNumber"));
                student.setFullName(rs.getString("fullName"));
                student.setBirthYear(rs.getInt("birthYear"));
                student.setSex(rs.getString("sex"));
                student.setPhone(rs.getString("phone"));
                student.setEmail(rs.getString("email"));
                students.add(student);
            }

            // Set the student list as a request attribute
            request.setAttribute("students", students);

            // Forward to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/browseStudents.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            // Log the error
            e.printStackTrace();
            
            // Set error attribute instead of writing directly to response
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            
            // Forward to an error page or back to the original page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (preparedStatement != null) preparedStatement.close();
                if (browseConnection != null) browseConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}