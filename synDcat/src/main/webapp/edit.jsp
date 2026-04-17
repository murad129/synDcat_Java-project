<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.syndcat.DBConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Session Protection
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get farmer ID from request parameter
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.trim().isEmpty()) {
        response.sendRedirect("farmerdetails.jsp");
        return;
    }

    int farmerId;
    try {
        farmerId = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("farmerdetails.jsp");
        return;
    }

    // Fetch farmer data
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String farmerName = "", nidNumber = "", gender = "", phoneNumber = "", address = "", farmingType = "";
    int age = 0;

    try {
        conn = DBConnect.getConnection();
        String sql = "SELECT * FROM register WHERE rid=?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, farmerId);
        rs = ps.executeQuery();
        if (rs.next()) {
            farmerName = rs.getString("farmername");
            nidNumber = rs.getString("nidnumber");
            age = rs.getInt("age");
            gender = rs.getString("gender");
            phoneNumber = rs.getString("phonenumber");
            address = rs.getString("address");
            farmingType = rs.getString("farming");
        } else {
            // Farmer not found
            response.sendRedirect("farmerdetails.jsp");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("errorMsg", "Database Error!");
        response.sendRedirect("farmerdetails.jsp");
        return;
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Edit Farmer - synDcat</title>

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

    <!-- Header -->
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
                    <li><a href="agroproducts.jsp">Agro Products</a></li>
                    <li><a href="triggers.jsp">Records</a></li>
                    <li class="buy-tickets"><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main id="main">
        <section class="section-with-bg" style="padding: 60px 0;">
            <div class="container" data-aos="fade-up">
                <div class="section-header">
                    <h2>Edit Farmer Details</h2>
                    <p>Update the information below</p>
                </div>

                <!-- Display error/success messages from session (if any) -->
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
                            <form action="UpdateFarmerServlet" method="POST">
                                <!-- Hidden field for farmer ID -->
                                <input type="hidden" name="id" value="<%= farmerId %>">

                                <div class="mb-3">
                                    <label for="farmerName" class="form-label">Farmer Name</label>
                                    <input type="text" class="form-control" name="farmername" id="farmerName" 
                                           value="<%= farmerName %>" required>
                                </div>

                                <div class="mb-3">
                                    <label for="nidNumber" class="form-label">NID Number</label>
                                    <input type="text" class="form-control" name="nidnumber" id="nidNumber" 
                                           value="<%= nidNumber %>" pattern="\d{10}|\d{17}" 
                                           title="NID must be 10 or 17 digits" required>
                                </div>

                                <div class="mb-3">
                                    <label for="age" class="form-label">Age</label>
                                    <input type="number" class="form-control" name="age" id="age" 
                                           value="<%= age %>" min="18" max="120" required>
                                </div>

                                <div class="mb-3">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" name="gender" id="gender" required>
                                        <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
                                        <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="phoneNumber" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" name="phonenumber" id="phoneNumber" 
                                           value="<%= phoneNumber %>" pattern="01[3-9]\d{8}" 
                                           title="Enter a valid Bangladeshi mobile number (11 digits starting with 01)" required>
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea class="form-control" name="address" id="address" rows="3" required><%= address %></textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="farmingType" class="form-label">Farming Type</label>
                                    <select class="form-select" name="farmingtype" id="farmingType" required>
                                        <option value="Agriculture" <%= farmingType.equals("Agriculture") ? "selected" : "" %>>Agriculture</option>
                                        <option value="Poultry" <%= farmingType.equals("Poultry") ? "selected" : "" %>>Poultry</option>
                                        <option value="Dairy" <%= farmingType.equals("Dairy") ? "selected" : "" %>>Dairy</option>
                                        <option value="Fisheries" <%= farmingType.equals("Fisheries") ? "selected" : "" %>>Fisheries</option>
                                    </select>
                                </div>

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-primary" 
                                            style="background: #1e7eff; border: 0; padding: 10px 24px; border-radius: 50px;">
                                        Update Farmer
                                    </button>
                                    <a href="farmerdetails.jsp" class="btn btn-secondary" 
                                       style="border-radius: 50px;">Cancel</a>
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
    <script src="js/main.js"></script>
     <script>
        // Initialize AOS
        if (typeof AOS !== 'undefined') {
            AOS.init();
        }
    </script>
</body>
</html>