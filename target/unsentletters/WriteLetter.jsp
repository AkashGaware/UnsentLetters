<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write an Unsent Letter</title>

<style>
    body {
        background: #ffffff;   /* OUTER WHITE */
        color: #000;
        font-family: 'Segoe UI', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }

    .container {
        width: 90%;
        max-width: 600px;
        background: #000;       /* INNER BLACK CARD */
        padding: 30px;
        border-radius: 14px;
        box-shadow: 0px 0px 25px rgba(0,0,0,0.2);
        animation: fadeIn 0.5s ease-out;
        color: #fff;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .title {
        text-align: center;
        font-size: 28px;
        margin-bottom: 25px;
        font-weight: 600;
        color: #fff;
        letter-spacing: 1px;
    }

    input, textarea {
        width: 100%;
        background: #111;
        border: 1px solid #444;
        padding: 12px;
        margin: 10px 0;
        border-radius: 8px;
        color: #fff;
        font-size: 15px;
    }

    input:focus, textarea:focus {
        outline: none;
        border-color: #fff;
        box-shadow: 0 0 5px rgba(255,255,255,0.4);
        transition: 0.2s;
    }

    textarea {
        height: 200px;
        resize: vertical;
    }

    button {
        width: 100%;
        padding: 12px;
        background: #ffffff;
        color: #000;
        border: none;
        margin-top: 10px;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: bold;
        transition: 0.3s ease;
    }

    button:hover {
        background: #ddd;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-top: 15px;
        color: #ccc;
        text-decoration: none;
        font-size: 14px;
        transition: 0.2s;
    }

    .back-link:hover {
        color: #fff;
        text-decoration: underline;
    }
</style>

</head>

<body>

<div class="container">
    <div class="title">Write an Anonymous Letter 💌</div>

    <form action="writeLetter" method="post">

        <input type="text" name="name" placeholder="Recipient's First Name" required>

     

        <textarea name="body" placeholder="Write your heart out..." required></textarea>

        <button type="submit">Submit Letter</button>
    </form>

    <a class="back-link" href="index.jsp">← Back to Home</a>
</div>

</body>
</html>
