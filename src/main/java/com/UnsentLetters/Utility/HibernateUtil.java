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

            Configuration cfg = new Configuration();
            cfg.configure("hibernate.cfg.xml");  // load XML first
            cfg.addProperties(props);            // override with env properties

            cfg.addAnnotatedClass(Letter.class);
          //  cfg.addAnnotatedClass(User.class);

            sessionFactory = cfg.buildSessionFactory();

        } catch (Exception e) {
            System.err.println("Hibernate initialization error: " + e);
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
