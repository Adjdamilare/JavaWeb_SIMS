<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Student</title>
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
        }
        .content-area {
            flex: 1;
            overflow-y: auto;
            padding: 20px;
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
    <!-- Delete Student Section -->
    <div id="delete" class="tab-pane fade show active">
        <div class="card">
            <div class="card-header bg-primary text-white">
                Delete Student Information
            </div>
            <div class="card-body">
                <!-- Delete student form -->
                <form id="deleteStudentForm">
                    <div class="mb-3">
                        <label for="deleteStudentNumber" class="form-label">Student Number</label>
                        <input type="text" class="form-control" id="deleteStudentNumber" placeholder="Enter student number">
                    </div>
                    <button type="button" class="btn btn-danger" onclick="deleteStudent()">Delete Student</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        // Function to delete a student using AJAX
        function deleteStudent() {
            var studentNumber = $("#deleteStudentNumber").val().trim();

            if (studentNumber === "") {
                alert("Please enter a student number.");
                return;
            }

            // AJAX request to delete the student
            $.ajax({
                url: 'deleteStudentHandler.jsp',  // URL of the JSP that handles the deletion
                type: 'POST',
                data: { studentNumber: studentNumber },
                success: function(response) {
                    // Handle the response from the server
                    if (response.success) {
                        alert("Student deleted successfully.");
                        $("#deleteStudentNumber").val(""); // Clear the input field
                    } else {
                        alert("Student deletion failed. Please try again.");
                    }
                },
                error: function() {
                    alert("An error occurred while deleting the student.");
                }
            });
        }
    </script>
</body>
</html>
