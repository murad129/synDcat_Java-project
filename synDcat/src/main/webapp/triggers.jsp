<%@page import="java.sql.*, com.mycompany.syndcat.DBConnect" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Session protection
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
    <title>Trigger Records - synDcat</title>

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
                    <li class="menu-active"><a href="triggers.jsp">Records</a></li>
                    <li class="buy-tickets"><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main id="main">
        <section class="section-with-bg" style="padding: 60px 0;">
            <div class="container" data-aos="fade-up">
                <div class="section-header">
                    <h2>Farmers Trigger Records</h2>
                    <p>Audit trail of actions performed on farmer records</p>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-10">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped table-hover bg-white shadow-sm text-center">
                                <thead style="background-color: #343a40; color: white;">
                                    <tr>
                                        <th>Farmer ID</th>
                                        <th>Action</th>
                                        <th>Timestamp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    Connection conn = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnect.getConnection();
                                        String sql = "SELECT fid, action, timestamp FROM trig ORDER BY timestamp DESC";
                                        ps = conn.prepareStatement(sql);
                                        rs = ps.executeQuery();
                                        boolean hasData = false;
                                        while (rs.next()) {
                                            hasData = true;
                                            String action = rs.getString("action");
                                            String badgeClass = "";
                                            if ("FARMER INSERTED".equalsIgnoreCase(action)) badgeClass = "success";
                                            else if ("FARMER UPDATED".equalsIgnoreCase(action)) badgeClass = "warning";
                                            else if ("FARMER DELETED".equalsIgnoreCase(action)) badgeClass = "danger";
                                            else badgeClass = "secondary";
                                %>
                                    <tr>
                                        <td><%= rs.getInt("fid") %></td>
                                        <td><span class="badge bg-<%= badgeClass %>"><%= action %></span></td>
                                        <td><%= rs.getTimestamp("timestamp") %></td>
                                    </tr>
                                <%
                                        }
                                        if (!hasData) {
                                %>
                                    <tr>
                                        <td colspan="3" class="text-center text-muted">No trigger records found.</td>
                                    </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                %>
                                    <tr>
                                        <td colspan="3" class="text-center text-danger">Database error. Please try again later.</td>
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