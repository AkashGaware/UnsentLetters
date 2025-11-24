package com.UnsentLetters.dao;

import java.util.List;

import org.hibernate.Session;

import com.UnsentLetters.Utility.HibernateUtil;
import com.UnsentLetters.model.Letter;

public class LetterDAO {
	
	//Adding a new letter
	public static boolean addLetter(Letter letter) {
		boolean status = false;
		try {
			Session session = HibernateUtil.openSession();
			session.beginTransaction();
			session.persist(letter);
			session.getTransaction().commit();
			session.close();
			status = true;
		}
		catch(Exception ex) {
			
		}
		
		return status;
	}
	
	//Getting letters based on name
	public List<Letter> getLettersByName(String name){
		List<Letter> letters = null;
		Session session =null;
		try {
	        session = HibernateUtil.getSessionFactory().openSession();

	        letters = session.createQuery(
	                "FROM Letter WHERE lower(name) = :name ORDER BY createdAt DESC",
	                Letter.class)
	                .setParameter("name", name.toLowerCase())
	                .list();

	    } catch (Exception e) {
	        e.printStackTrace();

	    } finally {
	        if (session != null) session.close();
	    }
		
		return letters;
	}
	
	//Shows recent 20 letters for homepage
	public List<Letter> getRecentLetters() {
	    Session session = HibernateUtil.getSessionFactory().openSession();
	    List<Letter> list = session.createQuery(
	        "FROM Letter ORDER BY createdAt DESC", Letter.class
	    )
	    .setMaxResults(20)
	    .list();
	    session.close();
	    return list;
	}
}
