<%@page import="com.UnsentLetters.dao.LetterDAO"%>
<%@page import="com.UnsentLetters.model.Letter"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, com.UnsentLetters.model.Letter" %>



<!DOCTYPE html>
<html>
<head>
    <title>Unsent Letters</title>

    <style>
        body {
            background: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
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
        }

        .search-box {
            text-align: center;
            margin-bottom: 25px;
        }

        .search-box input {
            padding: 10px 15px;
            width: 60%;
            border-radius: 5px;
            border: none;
            outline: none;
            font-size: 16px;
        }

        .search-box button {
            padding: 10px 16px;
            border: none;
            margin-left: 8px;
            cursor: pointer;
            background: white;
            color: black;
            border-radius: 5px;
            font-size: 15px;
            transition: 0.3s;
        }

        .search-box button:hover {
            background: #ddd;
        }

        .write-btn {
            display: inline-block;
            margin-bottom: 20px;
            background: white;
            color: black;
            padding: 12px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 16px;
        }

        .letter {
            background: #111;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 6px;
            border-left: 4px solid white;
        }

        .letter h3 {
            margin: 0 0 10px 0;
            color: #f0f0f0;
        }

        .letter p {
            color: #ccc;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        .no-results {
            text-align: center;
            margin-top: 20px;
            color: #bbb;
            font-size: 18px;
        }
    </style>

</head>
<body>

<div class="container">

    <h1>Unsent Letters</h1>

    <!-- Write Letter Button -->
    <a href="WriteLetter.jsp" class="write-btn">Write a Letter</a>

    <!-- Search Bar -->
    <div class="search-box">
        <form action="search" method="get">
            <input type="text" name="name" placeholder="Search letters by name..." required>
            <button type="submit">Search</button>
        </form>
    </div>
	<%if(request.getAttribute("type") != null){ %>
	<%String type = (String)request.getAttribute("listType"); %>
    <!-- Label -->
    <%
        if (type != null || type.equals("searched"))
        {
        	String name = (String)request.getAttribute("name");
        	LetterDAO dao = new LetterDAO();
        	 List<Letter> letters = dao.getLettersByName(name);
    %>
        <h2 style="font-weight:300; margin-bottom:20px;">Letters written for: <%= name %></h2>
   <%      if (letters != null && !letters.isEmpty()) {
            for (Letter l : letters) {
            
             %>
             <div class="letter">
            <h3>To: <%= l.getName() %></h3>
            <p><%= l.getBody() %></p>
        </div>
        <%} %>
    <%
    
        } else {
        	
    %>
    <div class="no-results">No letters found.</div>
    <%}  
    


        }  
    
	else if(type == null || type.equals("default")) {
		LetterDAO dao = new LetterDAO();
   	 List<Letter> letters = dao.getRecentLetters();%>
        <h2 style="font-weight:300; margin-bottom:20px;">Latest Letters</h2>
    <%
    if (letters != null && !letters.isEmpty()) {
        for (Letter l : letters) {
        
         %>
         <div class="letter">
        <h3>To: <%= l.getName() %></h3>
        <p><%= l.getBody() %></p>
    </div>
    <%} %>
<%

    } else {
    	
%>
<div class="no-results">No letters found.</div>
<%}  
        }
	else{
		%>
		<div class="no-results">No letters found.</div>
		<%
	}
	}
    
else{%>
	<div class="no-results">No letters found.</div>
<%} %>
</div>
<%request.removeAttribute("type"); %>
<%request.removeAttribute("msg"); %>
</body>
</html>
