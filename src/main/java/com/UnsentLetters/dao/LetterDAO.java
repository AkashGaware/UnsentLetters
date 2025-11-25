package com.UnsentLetters.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.UnsentLetters.Utility.HibernateUtil;
import com.UnsentLetters.model.Letter;

public class LetterDAO {

    // Add new letter
    public static boolean addLetter(Letter letter) {
        Transaction tx = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            session.persist(letter);

            tx.commit();
            return true;

        } catch (Exception ex) {
            ex.printStackTrace(); // IMPORTANT: do not swallow errors silently
            if (tx != null) tx.rollback();
            return false;
        }
    }

    // Get letters by name
    public List<Letter> getLettersByName(String name) {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery(
                    "FROM Letter WHERE lower(name) = :name ORDER BY createdAt DESC",
                    Letter.class)
                    .setParameter("name", name.toLowerCase())
                    .list();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Recent letters for homepage (limit 20)
    public List<Letter> getRecentLetters() {

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            return session.createQuery(
                    "FROM Letter ORDER BY createdAt DESC",
                    Letter.class)
                    .setMaxResults(20)
                    .list();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
