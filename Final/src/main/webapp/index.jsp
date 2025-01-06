<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color: #f4f6f9;
        }
        .main-container {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        .sidebar {
            width: 250px;
            background-color: #ffffff;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            overflow-y: auto;
            padding-top: 20px;
        }
        .content-area {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
            background-color: white;
        }
        .nav-pills .nav-link {
            color: #007aff;
        }
        .nav-pills .nav-link.active {
            background-color: #007aff;
            color: white;
        }
        .card-header {
            background-color: #007aff !important;
            color: white !important;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 15px 0;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: static;
            }
            .main-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Fixed Top Header -->
    <jsp:include page="header.jsp"></jsp:include>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar pt-4">
            <div class="nav flex-column nav-pills" role="tablist">
                <a class="nav-link" data-bs-toggle="pill" href="javascript:void(0)" onclick="loadPage('IndexMenu/browse.jsp')">Browse Students</a>
                <a class="nav-link" data-bs-toggle="pill" href="javascript:void(0)" onclick="loadPage('IndexMenu/input.jsp')">Input Student</a>
                <a class="nav-link" data-bs-toggle="pill" href="javascript:void(0)" onclick="loadPage('IndexMenu/query.jsp')">Query Student</a>
                <a class="nav-link" data-bs-toggle="pill" href="javascript:void(0)" onclick="loadPage('IndexMenu/modify.jsp')">Modify Student</a>
                <a class="nav-link" data-bs-toggle="pill" href="javascript:void(0)" onclick="loadPage('IndexMenu/delete.jsp')">Delete Student</a>
            </div>
        </div>

        <!-- Content Area: Will be dynamically updated -->
        <div id="content-area" class="content-area">
            <!-- Dynamically included content will appear here -->
            <div class="container mt-4">
         		<%
                    // Check for update message from various operations
                    String updateStatus = (String) session.getAttribute("updateStatus");
                    String updateMessage = (String) session.getAttribute("updateMessage");
                    String currentPage = (String) session.getAttribute("currentPage");
                    
                    if (updateMessage != null) {
                %>
                    <div class="alert <%= "error".equals(updateStatus) ? "alert-danger" : "alert-success" %> alert-dismissible fade show" role="alert">
                        <%= updateMessage %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <%
                    }
                %>

                <!-- Default content or last viewed page -->
                <% if (currentPage != null) { %>
                    <jsp:include page="<%= currentPage %>" />
                <% } else { %>
                    <jsp:include page="IndexMenu/browse.jsp" />
                <% } %>
        
    </div>
        </div>
    </div>

    <!-- Fixed Bottom Footer -->
    <jsp:include page="footer.jsp"></jsp:include>

    <!-- Bootstrap JS and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        // Function to load pages dynamically via AJAX
        function loadPage(url) {
            $.ajax({
                url: url,          // URL to load the content
                type: 'GET',       // HTTP method
                success: function(response) {
                    $('#content-area').html(response);
                },
                error: function() {
                    $('#content-area').html('An error occurred while loading the content.');
                }
            });
        }
    </script>
</body>
</html>
