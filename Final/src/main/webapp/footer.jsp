<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<footer class="bg-light text-dark shadow-sm mt-3">
    <div class="container py-3">
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-3">
                <h6 class="text-primary fw-bold mb-2">About SMS</h6>
                <p class="small mb-0">
                    Student Management System (SMS) helps institutions manage student data efficiently.
                </p>
            </div>

            <div class="col-lg-4 col-md-6 mb-3">
                <h6 class="text-primary fw-bold mb-2">Quick Links</h6>
                <ul class="list-unstyled small mb-0">
                	<% 
                    String user = (String) session.getAttribute("userEmail");
                    if (user == null) { // User not logged in
                    %>
                    <li><a href="login.jsp" class="text-dark text-decoration-none">Login</a></li>
                    <li><a href="signup.jsp" class="text-dark text-decoration-none">SignUp</a></li>
                    <% } else { // User logged in  %>
                    <li><a href="home.jsp" class="text-dark text-decoration-none">Home</a></li>
                    <li><a href="profile.jsp" class="text-dark text-decoration-none">Profile</a></li>
                    <li><a href="logout.jsp" class="text-dark text-decoration-none">LogOut</a></li>
                    <% } %>
                </ul>
            </div>

            <div class="col-lg-4 col-md-12 mb-3">
                <h6 class="text-primary fw-bold mb-2">Contact</h6>
                <ul class="list-unstyled small mb-0">
                    <li>Email: <a href="mailto:adeosundamilare03@gmail.com" class="text-dark text-decoration-none">adeosundamilare03@gmail.com</a></li>
                    <li>Phone: +86-16615166112</li>
                </ul>
            </div>
        </div>
    </div>

    <div class="bg-primary text-white text-center py-2">
        <p class="mb-0 small">&copy; 2024 Student Management System. All rights reserved.</p>
    </div>
</footer>