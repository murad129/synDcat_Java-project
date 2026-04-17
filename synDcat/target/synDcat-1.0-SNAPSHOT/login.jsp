<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Login - Farm Management</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

<header id="header">
    <div class="container">
        <div id="logo" class="pull-left">
            <a href="index.html" class="scrollto">Farm Management</a>
        </div>
    </div>
</header>

<section id="intro" style="height: 100vh; display: flex; align-items: center; justify-content: center;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg" style="background: rgba(255, 255, 255, 0.95); border-radius: 15px; border: none;">
                    <div class="card-body p-5">

                        <h2 class="text-center mb-4" style="color: #1e7eff; font-family: 'Baloo 2', cursive; font-weight: bold;">
                            𝓛𝓸𝓰𝓲𝓷✨
                        </h2>

                        <!-- Error Message -->
                        <%
                            String errorMsg = (String) session.getAttribute("errorMsg");
                            if (errorMsg != null) {
                        %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <%= errorMsg %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <%
                                session.removeAttribute("errorMsg");
                            }
                        %>

                        <!-- Success Message (from signup) -->
                        <%
                            String successMsg = (String) session.getAttribute("successMsg");
                            if (successMsg != null) {
                        %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <%= successMsg %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <%
                                session.removeAttribute("successMsg");
                            }
                        %>

                        <form action="LoginServlet" method="POST">
                            <div class="mb-3">
                                <label for="email" class="form-label" style="color: #333; font-weight: 600;">Email address</label>
                                <input type="email" class="form-control" name="email" id="email" placeholder="Enter your email" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label" style="color: #333; font-weight: 600;">Password</label>
                                <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password" required>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 mt-3"
                                    style="background: #1e7eff; border: none; border-radius: 50px; padding: 10px; font-size: 18px;">
                                Login
                            </button>
                        </form>

                        <div class="text-center mt-4">
                            <p style="color: #555;">New User?
                                <a href="signup.jsp" style="color: #1e7eff; font-weight: bold; text-decoration: none;">Signup</a>
                            </p>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer id="footer">
    <div class="container">
        <div class="credits text-center py-3">
            Developed by TEAM SYNDCAT
        </div>
    </div>
</footer>

<a href="#" class="back-to-top"><i class="fa fa-angle-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="js/main.js"></script>
<script>
    AOS.init();
</script>
</body>
</html>