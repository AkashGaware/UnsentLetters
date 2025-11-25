package com.UnsentLetters.Utility;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.UnsentLetters.model.Letter;

import java.util.Properties;

public class HibernateUtil {

    private static SessionFactory sessionFactory;

    static {
        try {
            // Load properties from db.properties
            Properties props = new Properties();
            props.load(Thread.currentThread()
                    .getContextClassLoader()
                    .getResourceAsStream("db.properties"));

            // Build the SessionFactory using cfg + properties
            Configuration cfg = new Configuration();
            cfg.addProperties(props);
            cfg.configure("hibernate.cfg.xml");

            // Add all your annotated classes
            cfg.addAnnotatedClass(Letter.class);

            sessionFactory = cfg.buildSessionFactory();

        } catch (HibernateException ex) {
            System.err.println("Initial SessionFactory creation failed. " + ex);
            throw new ExceptionInInitializerError(ex);
        } catch (Exception e) {
            System.err.println("Error loading db.properties: " + e);
            throw new ExceptionInInitializerError(e);
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
