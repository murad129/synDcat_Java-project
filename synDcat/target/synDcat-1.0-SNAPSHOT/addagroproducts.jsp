<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Add Agro Products - synDcat</title>

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@400;700&display=swap" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/agro.css" rel="stylesheet">
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
                    <li><a href="farming.jsp">Add Farming</a></li>
                    <li><a href="farmerdetails.jsp">Farmer Details</a></li>
                    <li class="menu-active"><a href="agroproducts.jsp">Agro Products</a></li>
                    <li><a href="triggers.jsp">Records</a></li>
                    <li class="buy-tickets"><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main id="main" style="margin-top: 80px;">
        <section id="contact" class="section-with-bg" style="padding: 60px 0;">
            <div class="container" data-aos="fade-up">

                <div class="section-header">
                    <h2>Add Agro Product</h2>
                    <p>Fill out the form below to add a new agricultural product to the system.</p>
                </div>

                <!-- Display session messages -->
                <div class="container mt-3">
                    <%
                        String errorMsg = (String) session.getAttribute("errorMsg");
                        String successMsg = (String) session.getAttribute("successMsg");
                        if (errorMsg != null) {
                    %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= errorMsg %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <%
                            session.removeAttribute("errorMsg");
                        }
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
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="form">
                            <form action="AddAgroProductServlet" method="POST">
                                <!-- If farmerId is passed from farmerdetails.jsp, include it as hidden field -->
                                <%
                                    String farmerId = request.getParameter("farmerId");
                                    if (farmerId != null && !farmerId.isEmpty()) {
                                %>
                                    <input type="hidden" name="farmerId" value="<%= farmerId %>">
                                <%
                                    }
                                %>

                                <div class="mb-3">
                                    <label for="productname" class="form-label">Product Name</label>
                                    <input type="text" name="productname" class="form-control" id="productname"
                                           placeholder="Enter Product Name (e.g., Rice, Wheat)" required>
                                </div>

                                <div class="mb-3">
                                    <label for="productdesc" class="form-label">Product Description</label>
                                    <textarea class="form-control" name="productdesc" rows="4" id="productdesc"
                                              placeholder="Write details about the product..." required></textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="price" class="form-label">Price (in Taka)</label>
                                    <input type="number" name="price" class="form-control" id="price"
                                           placeholder="Enter Price" required>
                                </div>

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary"
                                            style="background: #1e7eff; border: 0; padding: 10px 24px; border-radius: 50px;">
                                        Add Product
                                    </button>
                                    <a href="agroproducts.jsp" class="btn btn-secondary" style="border-radius: 50px;">Cancel</a>
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
    <script src="js/agro.js"></script>
     <script>
        AOS.init();
    </script>
</body>
</html>