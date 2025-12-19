package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.DriverBean;

public class DriverDAO {

    // --------- START: CONNECTION ---------
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
    // --------- END: CONNECTION ---------


    // ----------- CHECK DRIVER EXISTS ---------------
    public static boolean checkDriverDetails(DriverBean bean) throws SQLException {
        boolean checkFlag = false;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                "SELECT * FROM driver_details WHERE driver_name=? AND driver_contact=? AND aadhar_no=?"
             )) {

            pst.setString(1, bean.getDriverName());
            pst.setString(2, bean.getDriverContact());
            pst.setString(3, bean.getAadharNo());

            ResultSet rs = pst.executeQuery();
            checkFlag = rs.next();

        } catch (SQLException sql) {
            sql.printStackTrace();
        }
        return checkFlag;
    }


    // ----------- INSERT DRIVER --------------------
    public static boolean insertDriverDetails(DriverBean bean) throws SQLException {
        boolean flagInsert = false;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                "INSERT INTO driver_details(driver_name, driver_contact, aadhar_no, owner_id, status) "
              + "VALUES (?,?,?,?,?)"
             )) {

            pst.setString(1, bean.getDriverName());
            pst.setString(2, bean.getDriverContact());
            pst.setString(3, bean.getAadharNo());
            pst.setInt(4, bean.getOwnerId());
            pst.setString(5, bean.getStatus());

            pst.executeUpdate();
            flagInsert = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        }
        return flagInsert;
    }


    // ----------- LIST ALL DRIVERS --------------------
    public static List<DriverBean> listDrivers() throws SQLException {
        List<DriverBean> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement("SELECT * FROM driver_details ORDER BY driver_id DESC");
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                DriverBean bean = new DriverBean();
                bean.setDriverId(rs.getInt("driver_id"));
                bean.setDriverName(rs.getString("driver_name"));
                bean.setDriverContact(rs.getString("driver_contact"));
                bean.setAadharNo(rs.getString("aadhar_no"));
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setStatus(rs.getString("status"));

                list.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    // ----------- FETCH DRIVER BY ID --------------------
    public static DriverBean fetchDriverById(int driverId) throws SQLException {
        DriverBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement("SELECT * FROM driver_details WHERE driver_id=?")) {

            pst.setInt(1, driverId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                bean = new DriverBean();
                bean.setDriverId(rs.getInt("driver_id"));
                bean.setDriverName(rs.getString("driver_name"));
                bean.setDriverContact(rs.getString("driver_contact"));
                bean.setAadharNo(rs.getString("aadhar_no"));
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setStatus(rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }


    // ----------- UPDATE DRIVER --------------------
    public static boolean updateDriver(DriverBean bean) throws SQLException {
        boolean flag = false;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                "UPDATE driver_details SET driver_name=?, driver_contact=?, aadhar_no=?, owner_id=?, status=? "
              + "WHERE driver_id=?"
             )) {

            pst.setString(1, bean.getDriverName());
            pst.setString(2, bean.getDriverContact());
            pst.setString(3, bean.getAadharNo());
            pst.setInt(4, bean.getOwnerId());
            pst.setString(5, bean.getStatus());
            pst.setInt(6, bean.getDriverId());

            pst.executeUpdate();
            flag = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        }
        return flag;
    }


    // ----------- DELETE DRIVER --------------------
    public static boolean deleteDriver(int driverId) throws SQLException {
        boolean flag = false;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement("DELETE FROM driver_details WHERE driver_id=?")) {

            pst.setInt(1, driverId);
            pst.executeUpdate();
            flag = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        }
        return flag;
    }


    // ----------- NEW: LIST DRIVERS BY OWNER --------------------
    public static List<DriverBean> listDriversByOwner(int ownerId) throws SQLException {
        List<DriverBean> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                "SELECT * FROM driver_details WHERE owner_id=? ORDER BY driver_name ASC"
             )) {

            pst.setInt(1, ownerId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                DriverBean bean = new DriverBean();
                bean.setDriverId(rs.getInt("driver_id"));
                bean.setDriverName(rs.getString("driver_name"));
                bean.setDriverContact(rs.getString("driver_contact"));
                bean.setAadharNo(rs.getString("aadhar_no"));
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setStatus(rs.getString("status"));

                list.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public static List<DriverBean> listApprovedDrivers() throws SQLException {
        List<DriverBean> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                     "SELECT * FROM driver_details WHERE status='approved' ORDER BY driver_name ASC");
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                DriverBean bean = new DriverBean();
                bean.setDriverId(rs.getInt("driver_id"));
                bean.setDriverName(rs.getString("driver_name"));
                bean.setDriverContact(rs.getString("driver_contact"));
                bean.setAadharNo(rs.getString("aadhar_no"));
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setStatus(rs.getString("status"));
                list.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


}
