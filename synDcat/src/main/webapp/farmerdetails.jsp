<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mycompany.syndcat.DBConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Session Protection: Check if user is logged in
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
    <title>My Details - synDcat</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

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
                    <li><a href="farming.jsp">Add Farming</a></li>
                    <li class="menu-active"><a href="farmerdetails.jsp">Farmer Details</a></li>
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
                    <h2>My Profile Details</h2>
                    <p>Welcome, <%= username %></p>
                </div>

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
                            <table class="table table-bordered table-striped text-center align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Farmer Name</th>
                                        <th>NID Number</th>
                                        <th>Age</th>
                                        <th>Gender</th>
                                        <th>Phone Number</th>
                                        <th>Address</th>
                                        <th>Farming Type</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                        <th>Add Product</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    Connection conn = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        conn = DBConnect.getConnection();
                                        
                                        // Update: farmername এর বদলে username দিয়ে ডাটা খোঁজা হচ্ছে
                                        String sql = "SELECT * FROM register WHERE username = ? ORDER BY rid DESC";
                                        ps = conn.prepareStatement(sql);
                                        ps.setString(1, username);
                                        
                                        rs = ps.executeQuery();
                                        
                                        boolean isDataFound = false;
                                        
                                        while (rs.next()) {
                                            isDataFound = true;
                                            int id = rs.getInt("rid");
                                %>
                                    <tr>
                                        <td><%= id %></td>
                                        <td><%= rs.getString("farmername") %></td>
                                        <td><%= rs.getString("nidnumber") %></td>
                                        <td><%= rs.getInt("age") %></td>
                                        <td><%= rs.getString("gender") %></td>
                                        <td><%= rs.getString("phonenumber") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("farming") %></td>
                                        <td>
                                            <a href="edit.jsp?id=<%= id %>" class="btn btn-sm btn-info">Edit</a>
                                        </td>
                                        <td>
                                            <form action="DeleteFarmerServlet" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="<%= id %>">
                                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete your record?');">Delete</button>
                                            </form>
                                        </td>
                                        <td>
                                            <a href="addagroproducts.jsp?farmerId=<%= id %>" class="btn btn-sm btn-success">Add Product</a>
                                        </td>
                                    </tr>
                                <%
                                        }
                                        
                                        // যদি ইউজারের কোনো ডাটা না থাকে
                                        if (!isDataFound) {
                                %>
                                    <tr>
                                        <td colspan="11" class="text-center text-muted">No registration details found for <%= username %>. Please register first.</td>
                                    </tr>
                                <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                %>
                                    <tr>
                                        <td colspan="11" class="text-center text-danger">Database Error: <%= e.getMessage() %></td>
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
    <script src="js/farmer.js"></script>
    <script>
        // Initialize AOS
        if (typeof AOS !== 'undefined') {
            AOS.init();
        }
    </script>
</body>
</html>