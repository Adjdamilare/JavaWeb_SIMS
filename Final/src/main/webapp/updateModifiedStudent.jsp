<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String studentNumber = request.getParameter("studentNumber");
    String fullname = request.getParameter("fullname");
    String birthYear = request.getParameter("birthYear");
    String sex = request.getParameter("sex");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    if (studentNumber != null && !studentNumber.isEmpty()) {
        // Connect to the database
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_management", "root", "@Joshua6775");

            String query = "UPDATE students SET fullname = ?, birthYear = ?, sex = ?, address = ?, phone = ?, email = ? WHERE studentNumber = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, fullname);
            ps.setString(2, birthYear);
            ps.setString(3, sex);
            ps.setString(4, address);
            ps.setString(5, phone);
            ps.setString(6, email);
            ps.setString(7, studentNumber);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.print("<p class='text-success'>Student details updated successfully.</p>");
            } else {
                out.print("<p class='text-danger'>Failed to update student details.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<p class='text-danger'>Error updating student details.</p>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.print("<p class='text-danger'>Invalid student number.</p>");
    }
%>
