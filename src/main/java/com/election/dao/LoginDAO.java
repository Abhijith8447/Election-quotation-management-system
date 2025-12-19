package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.LoginBean;

public class LoginDAO {

    // Database objects
    static Connection con = null;
    static PreparedStatement pst = null;
    static ResultSet rs = null;

    // -------- GET CONNECTION ----------
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            DBDAO.connect();
            conn = DBDAO.getDbCon();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // -------- CHECK LOGIN ----------
    public static LoginBean checkLogin(LoginBean loginBean) throws SQLException {
        con = getConnection();
        LoginBean loginResult = new LoginBean();

        try {
            pst = con.prepareStatement(
                "SELECT login_username, login_role FROM login WHERE login_username=? AND login_password=?"
            );
            pst.setString(1, loginBean.getLoginUserName());
            pst.setString(2, loginBean.getLoginPassword());

            rs = pst.executeQuery();

            if (rs.next()) {
                loginResult.setLoginUserName(rs.getString("login_username"));
                loginResult.setLoginRole(rs.getString("login_role"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return loginResult;
    }

    // -------- VIEW ALL OWNERS ----------
    public static List<LoginBean> viewOwners() throws SQLException {
        con = getConnection();
        List<LoginBean> owners = new ArrayList<>();

        try {
            pst = con.prepareStatement(
                "SELECT login_username, login_password FROM login WHERE login_role='owner'"
            );

            rs = pst.executeQuery();

            while (rs.next()) {
                LoginBean bean = new LoginBean();
                bean.setLoginUserName(rs.getString("login_username"));
                bean.setLoginPassword(rs.getString("login_password"));
                owners.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return owners;
    }

    // -------- ADD OWNER ----------
    public static boolean addOwner(String username, String password) throws SQLException {
        con = getConnection();

        try {
            pst = con.prepareStatement(
                "INSERT INTO login (login_username, login_password, login_role) VALUES (?, ?, 'owner')"
            );
            pst.setString(1, username);
            pst.setString(2, password);

            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------- UPDATE OWNER ----------
    public static boolean updateOwner(String oldUsername, String newUsername, String newPassword)
            throws SQLException {

        con = getConnection();

        try {
            pst = con.prepareStatement(
                "UPDATE login SET login_username=?, login_password=? WHERE login_username=? AND login_role='owner'"
            );

            pst.setString(1, newUsername);
            pst.setString(2, newPassword);
            pst.setString(3, oldUsername);

            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------- DELETE OWNER ----------
    public static boolean deleteOwner(String username) throws SQLException {
        con = getConnection();

        try {
            pst = con.prepareStatement(
                "DELETE FROM login WHERE login_username=? AND login_role='owner'"
            );
            pst.setString(1, username);

            return pst.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 // -------- CHECK OLD PASSWORD ----------
    public static boolean checkOldPassword(String username, String oldPassword) throws SQLException {
        con = getConnection();
        try {
            pst = con.prepareStatement(
                "SELECT * FROM login WHERE login_username=? AND login_password=?"
            );
            pst.setString(1, username);
            pst.setString(2, oldPassword);

            rs = pst.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------- UPDATE PASSWORD ----------
    public static boolean updatePassword(String username, String newPassword) throws SQLException {
        con = getConnection();
        try {
            pst = con.prepareStatement(
                "UPDATE login SET login_password=? WHERE login_username=?"
            );
            pst.setString(1, newPassword);
            pst.setString(2, username);

            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
