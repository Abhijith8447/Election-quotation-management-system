package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.DailyRouteBean;

public class DailyRouteDAO {

    // ---------- GET DB CONNECTION ----------
    public static Connection getConnection() throws SQLException {
        try {
            DBDAO.connect();
            return DBDAO.getDbCon();
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Database connection failed");
        }
    }

    // ---------- CHECK DUPLICATE DAILY ROUTE ----------
    public static boolean checkDailyRouteExists(DailyRouteBean bean) throws SQLException {
        String sql = "SELECT * FROM daily_allocation WHERE vehicle_id=? AND date=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getDate());

            try (ResultSet rs = pst.executeQuery()) {
                return rs.next(); // Duplicate found
            }
        }
    }

    // ---------- INSERT DAILY ROUTE ----------
    public static boolean insertDailyRoute(DailyRouteBean bean) throws SQLException {
        String sql = "INSERT INTO daily_allocation (vehicle_id, route, start_kilometer, end_kilometer, date) "
                   + "VALUES (?,?,?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getRoute());
            pst.setDouble(3, bean.getStartKilometer());
            pst.setDouble(4, bean.getEndKilometer());
            pst.setString(5, bean.getDate());

            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- LIST ALL DAILY ROUTES ----------
    public static List<DailyRouteBean> listDailyRoutes() throws SQLException {
        List<DailyRouteBean> list = new ArrayList<>();
        String sql = "SELECT * FROM daily_allocation ORDER BY daily_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                DailyRouteBean bean = new DailyRouteBean();

                bean.setDailyId(rs.getInt("daily_id"));
                bean.setVehicleId(rs.getInt("vehicle_id"));
                bean.setRoute(rs.getString("route"));
                bean.setStartKilometer(rs.getDouble("start_kilometer"));
                bean.setEndKilometer(rs.getDouble("end_kilometer"));
                bean.setActualKilometer(rs.getDouble("actual_kilometer")); // auto-calculated
                bean.setDate(rs.getString("date"));

                list.add(bean);
            }
        }

        return list;
    }

    // ---------- FETCH DAILY ROUTE BY ID ----------
    public static DailyRouteBean fetchDailyRouteById(int dailyId) throws SQLException {
        String sql = "SELECT * FROM daily_allocation WHERE daily_id=?";
        DailyRouteBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, dailyId);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    bean = new DailyRouteBean();

                    bean.setDailyId(rs.getInt("daily_id"));
                    bean.setVehicleId(rs.getInt("vehicle_id"));
                    bean.setRoute(rs.getString("route"));
                    bean.setStartKilometer(rs.getDouble("start_kilometer"));
                    bean.setEndKilometer(rs.getDouble("end_kilometer"));
                    bean.setActualKilometer(rs.getDouble("actual_kilometer"));
                    bean.setDate(rs.getString("date"));
                }
            }
        }

        return bean;
    }

    // ---------- UPDATE DAILY ROUTE ----------
    public static boolean updateDailyRoute(DailyRouteBean bean) throws SQLException {
        String sql = "UPDATE daily_allocation SET vehicle_id=?, route=?, start_kilometer=?, "
                   + "end_kilometer=?, date=? WHERE daily_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getRoute());
            pst.setDouble(3, bean.getStartKilometer());
            pst.setDouble(4, bean.getEndKilometer());
            pst.setString(5, bean.getDate());
            pst.setInt(6, bean.getDailyId());

            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- DELETE DAILY ROUTE ----------
    public static boolean deleteDailyRoute(int dailyId) throws SQLException {
        String sql = "DELETE FROM daily_allocation WHERE daily_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, dailyId);
            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
