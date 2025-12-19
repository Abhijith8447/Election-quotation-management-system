package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.VehicleAllocationBean;

public class VehicleAllocationDAO {

    // ---------- DB CONNECTION ----------
    public static Connection getConnection() throws SQLException {
        try {
            DBDAO.connect();
            return DBDAO.getDbCon();
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Database connection failed");
        }
    }

    // ---------- CHECK DUPLICATE ----------
    // duplicate = same owner + driver + vehicle for same location
    public static boolean checkAllocationExists(VehicleAllocationBean bean) throws SQLException {
        String sql = "SELECT * FROM vehicle_allocation WHERE owner_id=? AND driver_id=? AND vehicle_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getOwnerId());
            pst.setInt(2, bean.getDriverId());
            pst.setInt(3, bean.getVehicleId());

            try (ResultSet rs = pst.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ---------- INSERT ----------
    public static boolean insertAllocation(VehicleAllocationBean bean) throws SQLException {
        String sql = "INSERT INTO vehicle_allocation (owner_id, driver_id, vehicle_id, location_name, assigned_officer) "
                   + "VALUES (?,?,?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getOwnerId());
            pst.setInt(2, bean.getDriverId());
            pst.setInt(3, bean.getVehicleId());
            pst.setString(4, bean.getLocationName());
            pst.setString(5, bean.getAssignedOfficer());

            pst.executeUpdate();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // ---------- LIST ALL ----------
    public static List<VehicleAllocationBean> listAllocations() throws SQLException {
        List<VehicleAllocationBean> list = new ArrayList<>();

        String sql = "SELECT * FROM vehicle_allocation ORDER BY location_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                VehicleAllocationBean bean = new VehicleAllocationBean();

                bean.setLocationId(rs.getInt("location_id"));
                bean.setOwnerId(rs.getInt("owner_id"));
                bean.setDriverId(rs.getInt("driver_id"));
                bean.setVehicleId(rs.getInt("vehicle_id"));
                bean.setLocationName(rs.getString("location_name"));
                bean.setAssignedOfficer(rs.getString("assigned_officer"));

                list.add(bean);
            }
        }
        return list;
    }

    // ---------- FETCH BY ID ----------
    public static VehicleAllocationBean fetchAllocationById(int locationId) throws SQLException {
        String sql = "SELECT * FROM vehicle_allocation WHERE location_id=?";
        VehicleAllocationBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, locationId);

            try (ResultSet rs = pst.executeQuery()) {

                if (rs.next()) {
                    bean = new VehicleAllocationBean();

                    bean.setLocationId(rs.getInt("location_id"));
                    bean.setOwnerId(rs.getInt("owner_id"));
                    bean.setDriverId(rs.getInt("driver_id"));
                    bean.setVehicleId(rs.getInt("vehicle_id"));
                    bean.setLocationName(rs.getString("location_name"));
                    bean.setAssignedOfficer(rs.getString("assigned_officer"));
                }
            }
        }
        return bean;
    }

    // ---------- UPDATE ----------
    public static boolean updateAllocation(VehicleAllocationBean bean) throws SQLException {
        String sql = "UPDATE vehicle_allocation SET owner_id=?, driver_id=?, vehicle_id=?, "
                   + "location_name=?, assigned_officer=? WHERE location_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getOwnerId());
            pst.setInt(2, bean.getDriverId());
            pst.setInt(3, bean.getVehicleId());
            pst.setString(4, bean.getLocationName());
            pst.setString(5, bean.getAssignedOfficer());
            pst.setInt(6, bean.getLocationId());

            pst.executeUpdate();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // ---------- DELETE ----------
    public static boolean deleteAllocation(int locationId) throws SQLException {
        String sql = "DELETE FROM vehicle_allocation WHERE location_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, locationId);
            pst.executeUpdate();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
