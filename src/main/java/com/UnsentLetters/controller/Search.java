package com.UnsentLetters.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class Search extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String name = req.getParameter("name");

        if (name == null || name.trim().equals("")) {
            req.setAttribute("type", "default");
        } else {
            req.setAttribute("type", "searched");
            req.setAttribute("name", name.trim());
        }

        req.getRequestDispatcher("index.jsp").forward(req, resp);
    }
}
