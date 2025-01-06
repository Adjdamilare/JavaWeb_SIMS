<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String studentNumber = request.getParameter("modifyStudentNumber");

    if (studentNumber != null && !studentNumber.isEmpty()) {
        // Connect to the database
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_management", "root", "@Joshua6775");

            String query = "SELECT * FROM students WHERE studentNumber = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, studentNumber);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Retrieve student details
                String fullname = rs.getString("fullname");
                String birthYear = rs.getString("birthYear");
                String sex = rs.getString("sex");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String email = rs.getString("email");

                // Set attributes to forward to modifyStudent.jsp
                request.setAttribute("fullname", fullname);
                request.setAttribute("birthYear", birthYear);
                request.setAttribute("sex", sex);
                request.setAttribute("address", address);
                request.setAttribute("phone", phone);
                request.setAttribute("email", email);
                request.setAttribute("studentNumber", studentNumber);

                // Forward to modifyStudent.jsp
                session.setAttribute("currentPage", "IndexMenu/modify.jsp"); 
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                out.print("<p class='text-danger'>Student not found!</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<p class='text-danger'>Error fetching student details.</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.print("<p class='text-danger'>Please enter a valid student number.</p>");
    }
%>
