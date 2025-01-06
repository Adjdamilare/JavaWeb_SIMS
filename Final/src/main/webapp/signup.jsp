<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Student Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .signup-container {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
            padding: 20px 0;
        }
        .signup-card {
            width: 100%;
            max-width: 500px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-color: white;
            border-radius: 10px;
        }
        /* Alert Animations */
        @keyframes slideIn {
            from { transform: translateX(-100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 90% { transform: translateX(-5px); }
            20%, 80% { transform: translateX(5px); }
            30%, 50%, 70% { transform: translateX(-5px); }
            40%, 60% { transform: translateX(5px); }
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        .alert-custom {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            animation: slideIn 0.5s ease-out, pulse 1s infinite;
        }
        .input-error {
            animation: shake 0.5s;
            border-color: #dc3545;
        }
        .form-control:focus {
            border-color: #007aff;
            box-shadow: 0 0 0 0.2rem rgba(0, 122, 255, 0.25);
        }
        .btn-primary {
            background-color: #007aff;
            border-color: #007aff;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <!-- Alert Container -->
    <div id="alertContainer" class="container position-fixed"></div>

    <div class="signup-container">
        <div class="signup-card">
            <h2 class="text-center mb-4 text-primary">Create Your Account</h2>
            <form id="signupForm" action="SignUp" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName" class="form-label">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" placeholder="Enter your first name" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName" class="form-label">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter your last name" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="mb-3">
                    <label for="age" class="form-label">Birthday</label>
                    <input type="date" class="form-control" id="age" name="birthday" placeholder="Enter your Birthday" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Create a strong password" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Repeat your password" required>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary">Sign Up</button>
                </div>
                <div class="text-center mt-3">
                    <p class="small text-muted">
                        Already have an account? <a href="login.jsp" class="text-primary text-decoration-none">Log In</a>
                    </p>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const firstName = document.getElementById('firstName');
            const lastName = document.getElementById('lastName');
            const email = document.getElementById('email');
            const age = document.getElementById('age');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            let isValid = true;

            // Clear previous errors
            [firstName, lastName, email, age, password, confirmPassword].forEach(input => {
                input.classList.remove('input-error');
            });
            
            // Remove existing alerts
            const existingAlert = document.getElementById('customAlert');
            if (existingAlert) existingAlert.remove();

            // First Name validation
            if (firstName.value.trim().length < 2) {
                firstName.classList.add('input-error');
                createAlert('First name must be at least 2 characters long.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            // Last Name validation
            if (lastName.value.trim().length < 2) {
                lastName.classList.add('input-error');
                createAlert('Last name must be at least 2 characters long.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value)) {
                email.classList.add('input-error');
                createAlert('Please enter a valid email address.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            // Age validation
            if (age.value < 1 || age.value > 120) {
                age.classList.add('input-error');
                createAlert('Please enter a valid age between 1 and 120.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            // Password validation
            if (password.value.length < 8) {
                password.classList.add('input-error');
                createAlert('Password must be at least 8 characters long.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            // Password match validation
            if (password.value !== confirmPassword.value) {
                password.classList.add('input-error');
                confirmPassword.classList.add('input-error');
                createAlert('Passwords do not match.', 'danger');
                e.preventDefault();
                isValid = false;
                return false;
            }

            return isValid;
        });

        function createAlert(message, type) {
            const alertContainer = document.getElementById('alertContainer');
            const alertDiv = document.createElement('div');
            alertDiv.id = 'customAlert';
            alertDiv.className = `alert alert-${type} alert-custom`;
            alertDiv.textContent = message;
            alertContainer.appendChild(alertDiv);

            // Remove alert after 5 seconds
            setTimeout(() => {
                if (alertDiv) alertDiv.remove();
            }, 5000);
        }
    </script>
</body>
</html>