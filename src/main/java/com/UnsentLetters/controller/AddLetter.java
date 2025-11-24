package com.UnsentLetters.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.UnsentLetters.dao.LetterDAO;
import com.UnsentLetters.model.Letter;

@WebServlet("/writeLetter")
public class AddLetter extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		String name = req.getParameter("name");
		String body = req.getParameter("body");
		
		Letter letter = new Letter(name, body);
		try {
			if(LetterDAO.addLetter(letter))
			{
				session.setAttribute("msg", "Thanks for Writing a letter");
				resp.sendRedirect("index.jsp");
				return;
			}
		}
		catch(Exception ex)
		{
			session.setAttribute("msg", ex.getMessage()); 
			resp.sendRedirect("index.jsp");
			return;
		}
	}
	
}
