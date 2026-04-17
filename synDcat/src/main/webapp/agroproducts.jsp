<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.syndcat.DBConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Session Protection: use consistent attribute name "username"
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Agro Products - synDcat</title>

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <!-- Custom Styles -->
    <link href="css/agro.css" rel="stylesheet">
</head>
<body>

    <!-- Header (same as other pages) -->
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

    <main id="main">
        <section class="section-with-bg" style="padding: 60px 0;">
            <div class="container" data-aos="fade-up">
                <div class="section-header">
                    <h2>Agro Products List</h2>
                    <p>All added agricultural products</p>
                </div>

                <!-- Display success/error messages -->
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
                    <div class="col-lg-12">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead class="table-dark">
                                    <tr>
                                        <th>PID</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Product Name</th>
                                        <th>Description</th>
                                        <th>Price (৳)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    Connection conn = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnect.getConnection();
                                        String sql = "SELECT * FROM addagroproducts ORDER BY pid DESC";
                                        ps = conn.prepareStatement(sql);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                %>
                                    <tr>
                                        <td><%= rs.getInt("pid") %></td>
                                        <td><%= rs.getString("username") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><%= rs.getString("productname") %></td>
                                        <td><%= rs.getString("productdesc") %></td>
                                        <td>৳ <%= rs.getInt("price") %></td>
                                    </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                %>
                                    32#
                                        <td colspan="6" class="text-center text-danger">Database Error! Please try again later.</td>
                                    </tr>
                                <%
                                    } finally {
                                        try { if (rs != null) rs.close(); } catch(Exception e) {}
                                        try { if (ps != null) ps.close(); } catch(Exception e) {}
                                        try { if (conn != null) conn.close(); } catch(Exception e) {}
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <a href="addagroproducts.jsp" class="btn btn-success" style="border-radius: 50px;">+ Add New Product</a>
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