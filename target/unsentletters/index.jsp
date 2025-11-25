<%@page import="com.UnsentLetters.dao.LetterDAO"%>
<%@page import="com.UnsentLetters.model.Letter"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Unsent Letters</title>

    <style>
        body {
            background: #e8dcff;
            font-family: Arial, sans-serif;
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

        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 300;
            color: #b57bff;
            font-size: 40px;
        }

        .search-box {
            text-align: center;
            margin-bottom: 25px;
        }

        .search-box input {
            padding: 10px 15px;
            width: 55%;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 16px;
            background: #e8dcff;
            color: black;
        }

        .search-box button {
            padding: 10px 16px;
            border: none;
            margin-left: 8px;
            cursor: pointer;
            background: #e8dcff;
            color: black;
            border-radius: 5px;
            font-size: 15px;
            transition: 0.3s;
            font-weight: bold;
        }

        .search-box button:hover {
            background: #d3c6ff;
        }

        .write-btn {
            display: inline-block;
            background: #e8dcff;
            color: black;
            padding: 12px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .write-btn:hover {
            background: #d3c6ff;
        }

        /* grid */
        .letters-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            max-height: 700px;
            overflow-y: auto;
            padding-right: 10px;
        }

        .letter {
            background: #e8dcff;
            color: black;
            padding: 25px;
            border-radius: 12px;
            border: 2px solid #000;
            height: 280px;
            animation: fadeIn 0.6s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            cursor: pointer;
        }

        .letter:hover {
            background: #d3c6ff;
        }

        .to-header {
            font-size: 20px;
            font-weight: bold;
        }

        .body-text {
            font-size: 17px;
            white-space: pre-wrap;
            overflow-y: auto;
        }

        .letter-footer {
            padding-top: 10px;
            font-size: 14px;
            display: flex;
            justify-content: space-between;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .container { width: 90%; padding: 20px; }
            .letters-grid { grid-template-columns: 1fr; }
            .letter { height: auto; }
        }
    </style>

</head>
<body>

<div class="container">

    <h1>Unsent Letters</h1>

    <!-- Write + Back -->
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">

        <a href="WriteLetter.jsp" class="write-btn">Write a Letter</a>

        <form action="search" method="get">
            <input type="hidden" name="name" value="">
            <button type="submit" class="write-btn">Back</button>
        </form>
    </div>

    <!-- Search Box -->
    <div class="search-box">
        <form action="search" method="get">
            <input type="text" name="name" placeholder="Search letters by name..." required>
            <button type="submit">Search</button>
        </form>
    </div>

    <%
        LetterDAO dao = new LetterDAO();
        List<Letter> letters = null;

        String type = (String) request.getAttribute("type");

        if (type == null || type.equals("default")) {
            letters = dao.getRecentLetters();
    %>

        <h2 style="font-weight:300; margin-bottom:20px;">Latest Letters</h2>

    <%
        } else if (type.equals("searched")) {
            String name = (String) request.getAttribute("name");
            letters = dao.getLettersByName(name);
    %>

        <h2 style="font-weight:300; margin-bottom:20px;">Letters written for: <%= name %></h2>

    <% } %>

    <div class="letters-grid">
    <%
        if (letters != null && !letters.isEmpty()) {
            for (Letter l : letters) {
    %>

        <!-- CLICKABLE LETTER CARD -->
        <a href="ViewLetter.jsp?id=<%= l.getId()%>" style="text-decoration:none; color:black;">
            <div class="letter">
                <div class="to-header">To: <%= l.getName() %></div>
                <div class="body-text"><%= l.getBody() %></div>

                <div class="letter-footer">
                    <span>Send</span>
                    <span>#unsentletters</span>
                    <span>Open</span>
                </div>
            </div>
        </a>

    <%
            }
        } else {
    %>
        <div style="color:#bbb; text-align:center; margin-top:20px;">
            No letters found.
        </div>
    <% } %>
    </div>

</div>

</body>
</html>
