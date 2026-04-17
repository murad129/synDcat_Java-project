<%
    // Invalidate the current session
    session.invalidate();
    // Redirect to the home page
    response.sendRedirect("index.html");
%>