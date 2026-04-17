<%@page import="java.sql.*, com.mycompany.syndcat.DBConnect" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Changes - synDcat</title>

    <!-- Bootstrap 5 + Icons + AOS (CDN) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <link href="css/style.css" rel="stylesheet">
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
                    <li class="menu-active"><a href="changes.jsp">Changes</a></li>
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
                    <h2>Enter Changes</h2>
                    <p>Track modifications to farmer records or system updates</p>
                </div>

                <%
                    String successMsg = (String) session.getAttribute("successMsg");
                    String errorMsg = (String) session.getAttribute("errorMsg");
                    if (successMsg != null) {
                %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= successMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <%
                        session.removeAttribute("successMsg");
                    }
                    if (errorMsg != null) {
                %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= errorMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <%
                        session.removeAttribute("errorMsg");
                    }
                %>

                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="form shadow p-4 bg-white rounded">
                            <form action="SaveChangesServlet" method="POST">
                                <div class="mb-3">
                                    <label for="deleted_text" class="form-label">Deleted Text</label>
                                    <input type="text" class="form-control" id="deleted_text" name="deleted_text"
                                           placeholder="Text you want to delete" required>
                                </div>
                                <div class="mb-3">
                                    <label for="new_text" class="form-label">New Text</label>
                                    <input type="text" class="form-control" id="new_text" name="new_text"
                                           placeholder="Newly entered text" required>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary" style="border-radius: 50px; padding: 8px 30px;">
                                        Save Change
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="row justify-content-center mt-5">
                    <div class="col-lg-8">
                        <div class="section-header">
                            <h3>Previously Saved Changes</h3>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Deleted Text</th>
                                        <th>New Text</th>
                                        <th>Date & Time</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    Connection conn = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnect.getConnection();
                                        String sql = "SELECT id, deleted_text, new_text, created_at FROM changes ORDER BY id DESC";
                                        ps = conn.prepareStatement(sql);
                                        rs = ps.executeQuery();
                                        boolean hasData = false;
                                        while (rs.next()) {
                                            hasData = true;
                                %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><span class="text-danger"><del><%= rs.getString("deleted_text") %></del></span></td>
                                        <td><span class="text-success"><strong><%= rs.getString("new_text") %></strong></span></td>
                                        <td><%= rs.getTimestamp("created_at") %></td>
                                    </tr>
                                <%
                                        }
                                        if (!hasData) {
                                %>
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">No changes recorded yet.</td>
                                    </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                %>
                                    <tr>
                                        <td colspan="4" class="text-center text-danger">Database error. Please try again later.</td>
                                    </tr>
                                <%
                                    } finally {
                                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                                        try { if (ps != null) ps.close(); } catch (Exception e) {}
                                        try { if (conn != null) conn.close(); } catch (Exception e) {}
                                    }
                                %>
                                </tbody>
                            </table>
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="js/main.js"></script>
    <script>
        AOS.init();
    </script>
</body>
</html>