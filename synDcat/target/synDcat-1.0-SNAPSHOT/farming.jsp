<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Add Farming - synDcat</title>

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/farmer.css" rel="stylesheet">
</head>
<body>

    <header id="header">
        <div class="container">
            <div id="logo" class="pull-left">
                <a href="index.html" class="scrollto">H.M.S</a>
            </div>
            <nav id="nav-menu-container">
                <ul class="nav-menu">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="changes.jsp">Changes</a></li>
                    <li><a href="farmer.jsp">Farmer Register</a></li>
                    <li class="menu-active"><a href="farming.jsp">Add Farming</a></li>
                    <li><a href="farmerdetails.jsp">Farmer Details</a></li>
                    <li><a href="agroproducts.jsp">Agro Products</a></li>
                    <li><a href="triggers.jsp">Records</a></li>
                    <li class="buy-tickets"><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <section id="intro">
        <div class="intro-container" data-aos="zoom-in" data-aos-delay="100">
            <h1 class="mb-4 pb-0" style="color: #1e7eff;">
                WELCOME TO 𝓼𝔂𝓷𝓭𝓬𝓪𝓽 🕸️
            </h1>
            <p class="mb-4 pb-0" style="color: #4CAF50;">
                প্রতিটি দানার মূল্য, প্রতিটি কৃষকের অধিকার!
                <span style="color: #888888; font-style: italic;">Scroll down to see more🌾</span>
            </p>
            <a href="agroproducts.jsp" class="about-btn scrollto">AGRO PRODUCTS</a>
        </div>
    </section>

    <main id="main">
        <section id="contact" class="section-with-bg" style="padding: 60px 0;">
            <div class="container" data-aos="fade-up">
                <div class="section-header">
                    <h2>Add Farming</h2>
                    <p>Add a new category of farming to the system.</p>
                </div>

                <!-- Display session messages -->
                <div class="container mt-3">
                    <%
                        String successMsg = (String) session.getAttribute("successMsg");
                        String errorMsg = (String) session.getAttribute("errorMsg");
                        if (successMsg != null) {
                    %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <%= successMsg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <%
                            session.removeAttribute("successMsg");
                        }
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
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="form">
                            <form action="AddFarmingServlet" method="POST">
                                <div class="mb-3">
                                    <label for="farmingType" class="form-label">Enter Farming Type</label>
                                    <input type="text" name="farmingType" class="form-control" id="farmingType" 
                                           placeholder="e.g., Poultry, Dairy, Fisheries" required>
                                </div>
                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary" 
                                            style="background: #1e7eff; border: 0; padding: 10px 24px; border-radius: 50px;">
                                        Add Farming
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

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
    <script src="js/farmer.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>