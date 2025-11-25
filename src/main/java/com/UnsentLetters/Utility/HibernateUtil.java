package com.UnsentLetters.Utility;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.Session;

import com.UnsentLetters.model.Letter;

public class HibernateUtil {

    private static final SessionFactory sessionFactory;

    static {
        try {
            Configuration cfg = new Configuration();
            cfg.configure("hibernate.cfg.xml");

            // Add ALL your annotated entity classes here
            cfg.addAnnotatedClass(Letter.class);

            sessionFactory = cfg.buildSessionFactory();

        } catch (Throwable ex) {
            System.err.println("SessionFactory creation error: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static Session openSession() {
        return sessionFactory.openSession();
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}
