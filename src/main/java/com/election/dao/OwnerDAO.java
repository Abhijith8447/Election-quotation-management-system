package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.OwnerBean;

public class OwnerDAO {

    static Connection con = null;
    static PreparedStatement pst = null;
    static ResultSet rs = null;

    // ---------start-------connection-----------
    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            DBDAO.connect();
            conn = DBDAO.getDbCon();
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return conn;
    }
    // --------------------END-------------------------

    // ----------- CHECK OWNER EXISTS ---------------
    public static boolean checkOwnerDetails(OwnerBean ownerBean) throws SQLException {
        boolean checkFlag = false;
        con = getConnection();
        try {
            pst = con.prepareStatement(
                "SELECT * FROM owners WHERE owner_name=? AND owner_address=? AND owner_contact=?"
            );
            pst.setString(1, ownerBean.getOwnerName());
            pst.setString(2, ownerBean.getOwnerAddress());
            pst.setString(3, ownerBean.getOwnerContact());

            rs = pst.executeQuery();
            checkFlag = rs.next();  // directly check
        } catch (SQLException sql) {
            sql.printStackTrace();
        } finally {
            con.close();
        }
        return checkFlag;
    }

    // ----------- INSERT OWNER --------------------
    public static boolean insertOwnerDetails(OwnerBean ownerBean) throws SQLException {
        boolean flagInsert = false;
        con = getConnection();
        try {
            pst = con.prepareStatement(
                "INSERT INTO owners(owner_name, owner_address, owner_contact) VALUES(?,?,?)"
            );
            pst.setString(1, ownerBean.getOwnerName());
            pst.setString(2, ownerBean.getOwnerAddress());
            pst.setString(3, ownerBean.getOwnerContact());

            pst.executeUpdate();
            flagInsert = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        } finally {
            con.close();
        }
        return flagInsert;
    }

    // ----------- LIST ALL OWNERS --------------------
    public static List<OwnerBean> listOwners() throws SQLException {
        List<OwnerBean> list = new ArrayList<>();
        con = getConnection();
        try {
            pst = con.prepareStatement("SELECT * FROM owners");
            rs = pst.executeQuery();

            while (rs.next()) {
                OwnerBean bean = new OwnerBean();
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setOwnerName(rs.getString("owner_name"));
                bean.setOwnerAddress(rs.getString("owner_address"));
                bean.setOwnerContact(rs.getString("owner_contact"));
                list.add(bean);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.close();
        }
        return list;
    }

    // ----------- FETCH OWNER BY ID --------------------
    public static OwnerBean fetchOwnerById(int ownerId) throws SQLException {
        OwnerBean bean = null;
        con = getConnection();
        try {
            pst = con.prepareStatement("SELECT * FROM owners WHERE owner_id=?");
            pst.setInt(1, ownerId);
            rs = pst.executeQuery();

            if (rs.next()) {
                bean = new OwnerBean();
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setOwnerName(rs.getString("owner_name"));
                bean.setOwnerAddress(rs.getString("owner_address"));
                bean.setOwnerContact(rs.getString("owner_contact"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            con.close();
        }
        return bean;
    }

    // ----------- UPDATE OWNER --------------------
    public static boolean updateOwner(OwnerBean ownerBean) throws SQLException {
        boolean flag = false;
        con = getConnection();
        try {
            pst = con.prepareStatement(
                "UPDATE owners SET owner_name=?, owner_address=?, owner_contact=? WHERE owner_id=?"
            );
            pst.setString(1, ownerBean.getOwnerName());
            pst.setString(2, ownerBean.getOwnerAddress());
            pst.setString(3, ownerBean.getOwnerContact());
            pst.setInt(4, ownerBean.getOwnerId());

            pst.executeUpdate();
            flag = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        } finally {
            con.close();
        }
        return flag;
    }

    // ----------- DELETE OWNER --------------------
    public static boolean deleteOwner(int ownerId) throws SQLException {
        boolean flag = false;
        con = getConnection();
        try {
            pst = con.prepareStatement("DELETE FROM owners WHERE owner_id=?");
            pst.setInt(1, ownerId);

            pst.executeUpdate();
            flag = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        } finally {
            con.close();
        }
        return flag;
    }
}
