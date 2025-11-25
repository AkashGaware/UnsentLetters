<%@page import="com.UnsentLetters.dao.LetterDAO"%>
<%@page import="com.UnsentLetters.model.Letter"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String idStr = request.getParameter("id");
    Letter letter = null;

    if (idStr != null) {
        try {
            int id = Integer.parseInt(idStr);
            LetterDAO dao = new LetterDAO();
            letter = dao.getLetterById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Letter</title>

    <style>
        body {
            background: #e8dcff;
            font-family: Arial;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: 40px auto;
            background: #000;
            padding: 40px;
            border-radius: 10px;
            color: white;
        }

        .back-btn {
            background: #e8dcff;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            color: black;
        }

        .letter-box {
            background: #e8dcff;
            color: black;
            padding: 25px;
            border-radius: 12px;
            border: 2px solid #000;
            white-space: pre-wrap;
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>

<div class="container">

    <a href="index.jsp" class="back-btn">← Back to Home</a>

    <% if (letter != null) { %>

        <h1>Letter to <%= letter.getName() %></h1>

        <div class="letter-box">
            <%= letter.getBody() %>
        </div>

    <% } else { %>

        <h2 style="color:#bbb;">Letter not found.</h2>

    <% } %>

</div>

</body>
</html>
