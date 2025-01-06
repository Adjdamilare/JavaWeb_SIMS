<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Students</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .edit-btn, .delete-btn {
            cursor: pointer;
        }
        .form-container {
            margin-top: 20px;
        }
        /* Modal style */
        .modal-dialog {
            max-width: 800px;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                Browse and Edit Student Information
            </div>
            <div class="card-body">
                <!-- Table to display student information -->
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Student Number</th>
                            <th>Full Name</th>
                            <th>Birth Year</th>
                            <th>Sex</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            // Database connection details
                            String url = "jdbc:mysql://localhost:3306/student_management";
                            String username = "root";
                            String password = "@Joshua6775";
                            
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            
                            try {
                                // Load the JDBC driver
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                
                                // Establish the connection
                                conn = DriverManager.getConnection(url, username, password);
                                
                                // Query to fetch students, extracting only the year from the birthYear column
                                String query = "SELECT studentNumber, fullName, YEAR(birthYear) AS birthYear, sex, address, phone, email FROM students";
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(query);
                                
                                // Iterate over the result set and display students
                                while (rs.next()) {
                                    String studentNumber = rs.getString("studentNumber");
                                    String fullName = rs.getString("fullName");
                                    int birthYear = rs.getInt("birthYear"); // Now birthYear is just an integer year
                                    String sex = rs.getString("sex");
                                    String address = rs.getString("address");
                                    String phone = rs.getString("phone");
                                    String email = rs.getString("email");
                        %>
                            <tr>
                                <td><%= studentNumber %></td>
                                <td><%= fullName %></td>
                                <td><%= birthYear %></td>
                                <td><%= sex %></td>
                                <td><%= address %></td>
                                <td><%= phone %></td>
                                <td><%= email %></td>
                                <td>
                                    <button class="btn btn-warning edit-btn" data-id="<%= studentNumber %>" data-name="<%= fullName %>" data-birth="<%= birthYear %>" data-sex="<%= sex %>" data-address="<%= address %>" data-phone="<%= phone %>" data-email="<%= email %>">Edit</button>
                                    <button class="btn btn-danger delete-btn" data-id="<%= studentNumber %>">Delete</button>
                                </td>
                            </tr>
                        <% 
                                }
                            } catch (SQLException | ClassNotFoundException e) {
                        %>
                            <tr>
                                <td colspan="8" class="text-danger">
                                    Error loading data: <%= e.getMessage() %>
                                </td>
                            </tr>
                        <% 
                            } finally {
                                // Close the resources
                                try {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>

                <!-- Form to edit student info (hidden by default) -->
                <!-- Modal for Edit -->
                <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editModalLabel">Edit Student Information</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form method="post" action="updateStudent.jsp">
                                    <input type="hidden" name="studentNumber" id="studentNumber">
                                    <div class="mb-3">
                                        <label for="fullName" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="fullName" name="fullName">
                                    </div>
                                    <div class="mb-3">
                                        <label for="birthYear" class="form-label">Birth Year</label>
                                        <input type="date" class="form-control" id="birthYear" name="birthYear">
                                    </div>
                                    <div class="mb-3">
                                        <label for="sex" class="form-label">Sex</label>
                                        <select class="form-select" id="sex" name="sex">
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address">
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="text" class="form-control" id="phone" name="phone">
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Edit button functionality
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', function () {
                // Fill the form with the student's data
                document.getElementById('studentNumber').value = this.getAttribute('data-id');
                document.getElementById('fullName').value = this.getAttribute('data-name');
                document.getElementById('birthYear').value = this.getAttribute('data-birth');
                document.getElementById('sex').value = this.getAttribute('data-sex');
                document.getElementById('address').value = this.getAttribute('data-address');
                document.getElementById('phone').value = this.getAttribute('data-phone');
                document.getElementById('email').value = this.getAttribute('data-email');
                
                // Show the modal
                var myModal = new bootstrap.Modal(document.getElementById('editModal'));
                myModal.show();
            });
        });

        // Delete button functionality
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', function () {
                const studentNumber = this.getAttribute('data-id');
                if (confirm('Are you sure you want to delete this student?')) {
                    // Redirect to deleteStudent.jsp with the student number
                    window.location.href = 'deleteStudentHandler.jsp?studentNumber=' + studentNumber;
                }
            });
        });
    </script>
</body>
</html>
