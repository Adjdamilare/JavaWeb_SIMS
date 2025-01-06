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
import java.sql.ResultSet;
import java.sql.SQLException;

import com.SMS.database.DatabaseConnection;


/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        
        try {
			DatabaseConnection newConnection = new DatabaseConnection();
			Connection loginConnection = newConnection.getConnection();
			
			PreparedStatement statement = loginConnection.prepareStatement(sql);
			statement.setString(1, email);
	        statement.setString(2, password);
	        
	        try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    // Successful login
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", email);

                    // Redirect to home page
                    response.sendRedirect("index.jsp");
                } else {
                    // Failed login
                    request.setAttribute("errorMessage", "Invalid email or password");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
                newConnection.closeConnection();
            }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}

}

