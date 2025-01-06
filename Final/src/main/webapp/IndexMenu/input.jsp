<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    <div id="input" class="tab-pane fade show active">
        <div class="card shadow-sm">
            <div class="card-header">
                Input Student Information
            </div>
            <div class="card-body">
                <form id="inputStudentForm" action="InputStudents" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Student Number</label>
                            <input type="text" class="form-control" name="studentNumber" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Birth Year</label>
                            <input type="date" class="form-control" name="birthYear" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Sex</label>
                            <select class="form-select" name="sex" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" class="form-control" name="address" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phone" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Student</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<%
    String value = "Some value to store";
    session.setAttribute("input", value);
%>
