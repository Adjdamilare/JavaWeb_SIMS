<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Query Student Information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <!-- Query Student Section -->
    <div class="container my-4">
        <div class="card">
            <div class="card-header">
                Query Student Information
            </div>
            <div class="card-body">
                <!-- Search Form -->
                <form action="searchStudent.jsp" method="POST">
                    <div class="row">
                        <!-- Search By Dropdown -->
                        <div class="col-md-6 mb-3">
                            <label for="queryType" class="form-label">Search By</label>
                            <select class="form-select" id="queryType" name="queryType" required>
                                <option value="studentNumber">Student Number</option>
                                <option value="name">Name</option>
                            </select>
                        </div>
                        <!-- Search Term Input -->
                        <div class="col-md-6 mb-3">
                            <label for="searchTerm" class="form-label">Search Term</label>
                            <input type="text" class="form-control" id="searchTerm" name="searchTerm" placeholder="Enter search term" required>
                        </div>
                    </div>
                    <!-- Search Button -->
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>
        </div>

        <%-- Display Search Results if any --%>
        <%
            // Get search results passed from searchStudent.jsp
            List<Map<String, String>> searchResults = (List<Map<String, String>>) request.getAttribute("searchResults");

            if (searchResults != null && !searchResults.isEmpty()) {
        %>
        <div class="card mt-4">
            <div class="card-header">
                Search Results
            </div>
            <div class="card-body">
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
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Display each student's information
                            for (Map<String, String> student : searchResults) {
                        %>
                        <tr>
                            <td><%= student.get("studentNumber") %></td>
                            <td><%= student.get("fullname") %></td>
                            <td><%= student.get("birthYear") %></td>
                            <td><%= student.get("sex") %></td>
                            <td><%= student.get("address") %></td>
                            <td><%= student.get("phone") %></td>
                            <td><%= student.get("email") %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <%
            } else if (searchResults != null && searchResults.isEmpty()) {
        %>
        <div class="alert alert-warning mt-4">
            No results found matching the search criteria.
        </div>
        <%
            }
        %>
    </div>

    <!-- Bootstrap JS and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
