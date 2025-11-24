package com.UnsentLetters.Utility;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.UnsentLetters.model.Letter;




public class HibernateUtil {
	 private static SessionFactory sessionFactory;

	    static {
	        try {
	            // Build the SessionFactory from hibernate.cfg.xml
	            sessionFactory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(Letter.class).buildSessionFactory();
	        } catch (HibernateException ex) {
	            // Log the exception to trace issues in configuration
	            System.err.println("Initial SessionFactory creation failed." + ex);
	            throw new ExceptionInInitializerError(ex);
	        }
	    }

	    // Retrieve the SessionFactory
	    public static SessionFactory getSessionFactory() {
	        return sessionFactory;
	    }

	    // Open a new Session
	    public static Session openSession() {
	        return sessionFactory.openSession();
	    }

	    // Close the SessionFactory
	    public static void shutdown() {
	        if (sessionFactory != null) {
	            sessionFactory.close();
	        }
	    }
}
