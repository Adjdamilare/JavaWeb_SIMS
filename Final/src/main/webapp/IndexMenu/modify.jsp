<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Student Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-header {
            background-color: #007aff !important;
            color: white !important;
        }
        .card {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                Modify Student Information
            </div>
            <div class="card-body">
                <!-- Form to search for a student by student number -->
                <form action="searchStudentToModify.jsp" method="POST">
                    <div class="mb-3">
                        <label for="modifyStudentNumber" class="form-label">Student Number</label>
                        <input type="text" class="form-control" id="modifyStudentNumber" name="modifyStudentNumber" placeholder="Enter student number" required>
                    </div>
                    <!-- Search Button -->
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>

                <%-- If student is found, display their information in editable form --%>
                <% 
                    String fullname = (String) request.getAttribute("fullname");
                    String birthYear = (String) request.getAttribute("birthYear");
                    String sex = (String) request.getAttribute("sex");
                    String address = (String) request.getAttribute("address");
                    String phone = (String) request.getAttribute("phone");
                    String email = (String) request.getAttribute("email");
                    if (fullname != null) {
                %>
                <form action="updateModifiedStudent.jsp" method="POST">
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" value="<%= fullname %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="birthYear" class="form-label">Birth Year</label>
                        <input type="text" class="form-control" id="birthYear" name="birthYear" value="<%= birthYear %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="sex" class="form-label">Sex</label>
                        <input type="text" class="form-control" id="sex" name="sex" value="<%= sex %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" name="address" value="<%= address %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="<%= phone %>" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
                    </div>
                    <input type="hidden" name="studentNumber" value="<%= request.getAttribute("studentNumber") %>">
                    <button type="submit" class="btn btn-success">Update Student</button>
                </form>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
