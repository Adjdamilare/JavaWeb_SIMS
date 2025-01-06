<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Get search parameters from the form
    String queryType = request.getParameter("queryType");
    String searchTerm = request.getParameter("searchTerm");

    // Initialize searchResults list
    List<Map<String, String>> searchResults = new ArrayList<>();

    if (queryType != null && searchTerm != null) {
        // Establish connection to MySQL database
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Database connection setup
            String dbUrl = "jdbc:mysql://localhost:3306/student_management";
            String dbUser = "root"; // MySQL default username
            String dbPassword = "@Joshua6775"; // Provided password
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Construct the query based on the search type
            String query = "";
            if ("studentNumber".equals(queryType)) {
                query = "SELECT * FROM students WHERE studentNumber LIKE ?";
            } else if ("name".equals(queryType)) {
                query = "SELECT * FROM students WHERE fullname LIKE ?";
            }

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, "%" + searchTerm + "%");
            resultSet = preparedStatement.executeQuery();

            // Process the result set and store the results in a map
            while (resultSet.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("studentNumber", resultSet.getString("studentNumber"));
                student.put("fullname", resultSet.getString("fullname"));
                student.put("birthYear", resultSet.getString("birthYear"));
                student.put("sex", resultSet.getString("sex"));
                student.put("address", resultSet.getString("address"));
                student.put("phone", resultSet.getString("phone"));
                student.put("email", resultSet.getString("email"));

                searchResults.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    session.setAttribute("currentPage", "IndexMenu/query.jsp");

    // Forward results back to query.jsp
    request.setAttribute("searchResults", searchResults);
    request.getRequestDispatcher("index.jsp").forward(request, response);
%>
