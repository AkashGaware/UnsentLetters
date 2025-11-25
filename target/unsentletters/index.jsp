<%@page import="com.UnsentLetters.dao.LetterDAO"%>
<%@page import="com.UnsentLetters.model.Letter"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <title>Unsent Letters</title>

    <style>
        body {
            background: #e8dcff; /* Lavender background */
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
            color: #b57bff; /* Lavender heading */
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
            background: #e8dcff; /* Lavender */
            color: black;
        }

        .search-box button {
            padding: 10px 16px;
            border: none;
            margin-left: 8px;
            cursor: pointer;
            background: #e8dcff; /* Lavender */
            color: black;
            border-radius: 5px;
            font-size: 15px;
            transition: 0.3s;
            font-weight: bold;
        }

        .search-box button:hover {
            background: #d3c6ff; /* darker lavender */
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

        /* Grid for 2 letters per row */
        .letters-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            max-height: 700px;
            overflow-y: auto;
            padding-right: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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

        /* Scrollbars */
        .body-text::-webkit-scrollbar { width: 6px; }
        .body-text::-webkit-scrollbar-thumb { background: #999; border-radius: 10px; }

        .letters-grid::-webkit-scrollbar { width: 10px; }
        .letters-grid::-webkit-scrollbar-thumb { background: #666; border-radius: 8px; }

        @media (max-width: 768px) {
            .container { width: 90%; padding: 20px; }
            .letters-grid { grid-template-columns: 1fr; max-height: none; }
            .letter { height: auto; }
        }

        /* ---------------- POPUP MODAL -------------------- */

        #popupOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.65);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        #popupBox {
            background: #e8dcff;
            padding: 25px;
            width: 90%;
            max-width: 350px;
            border-radius: 10px;
            text-align: center;
            border: 2px solid black;
        }

        #popupBox h3 {
            margin-bottom: 20px;
            color: black;
            font-weight: bold;
        }

        #closeBtn {
            padding: 10px 20px;
            font-size: 16px;
            background: black;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        #closeBtn:hover {
            background: #333;
        }
    </style>

    <script>
        function closePopup() {
            document.getElementById("popupOverlay").style.display = "none";
        }
    </script>

</head>
<body>

<div class="container">

    <h1>Unsent Letters</h1>

    <!-- ROW: Write + Back -->
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

    <%  }  %>

    <div class="letters-grid">
    <%  
        if (letters != null && !letters.isEmpty()) {
            for (Letter l : letters) {
    %>

        <div class="letter">
            <div class="to-header">To: <%= l.getName() %></div>

            <div class="body-text"><%= l.getBody() %></div>

            <div class="letter-footer">
                <span>Send</span>
                <span>#unsentproject</span>
                <span>Back</span>
            </div>
        </div>

    <%
            }
        } else {
    %>

        <div class="no-results" style="color:#bbb; text-align:center; margin-top:20px;">
            No letters found.
        </div>

    <%  } %>
    </div>

</div>

<!-- POPUP MODAL HTML -->
<div id="popupOverlay">
    <div id="popupBox">
        <h3><%= session.getAttribute("msg") %></h3>
        <button id="closeBtn" onclick="closePopup()">OK</button>
    </div>
</div>

<!-- TRIGGER POPUP IF SESSION MSG EXISTS -->
<%
    String popupMsg = (String) session.getAttribute("msg");
    if (popupMsg != null) {
%>
<script>
    document.getElementById("popupOverlay").style.display = "flex";
</script>
<%
        session.removeAttribute("msg"); // remove from session after showing
    }
%>

</body>
</html>
