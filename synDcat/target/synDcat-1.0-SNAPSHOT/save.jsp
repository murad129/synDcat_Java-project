<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve data from request (or session)
    String deletedText = request.getParameter("deleted_text");
    String newText = request.getParameter("new_text");

    // If not provided via request, try session (optional)
    if (deletedText == null) deletedText = (String) session.getAttribute("deleted_text");
    if (newText == null) newText = (String) session.getAttribute("new_text");

    // If still null, set defaults or redirect
    if (deletedText == null) deletedText = "No old text provided";
    if (newText == null) newText = "No new text provided";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Changes</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7f6;
            padding-top: 60px;
            font-family: 'Open Sans', sans-serif;
        }
        .changes-card {
            max-width: 550px;
            margin: 0 auto;
            padding: 40px 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .deleted {
            color: #dc3545;
            text-decoration: line-through;
            font-size: 16px;
        }
        .new {
            color: #28a745;
            font-weight: bold;
            font-size: 16px;
        }
        .text-box {
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="changes-card text-center">
            <h3 class="mb-4" style="color: #1e7eff; font-weight: bold;">Confirm Changes</h3>
            <p class="text-muted mb-4">Please review the changes before saving.</p>

            <form action="ConfirmChangesServlet" method="POST">
                <input type="hidden" name="deleted_text" value="<%= deletedText %>">
                <input type="hidden" name="new_text" value="<%= newText %>">

                <div class="text-box">
                    <p class="mb-3">
                        <strong style="color: #555;">Removed Text:</strong><br>
                        <span class="deleted"><%= deletedText %></span>
                    </p>
                    <hr>
                    <p class="mb-0">
                        <strong style="color: #555;">New Text:</strong><br>
                        <span class="new"><%= newText %></span>
                    </p>
                </div>

                <button type="submit" class="btn btn-success btn-lg px-4" style="border-radius: 50px;">Save Changes</button>
                <a href="changes.html" class="btn btn-secondary btn-lg px-4 ml-2" style="border-radius: 50px;">Cancel</a>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>