package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.election.beans.VehicleBean;

public class VehicleDAO {

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

	public static boolean checkVehicleDetails(VehicleBean bean) throws SQLException {
		boolean checkFlag = false;

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE vehicle_no=?")) {

			pst.setString(1, bean.getVehicleNo());
			ResultSet rs = pst.executeQuery();
			checkFlag = rs.next();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return checkFlag;
	}

	public static boolean insertVehicle(VehicleBean bean) throws SQLException {
		boolean flagInsert = false;

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO vehicle(owner_id, driver_id, vehicle_no, vehicle_type, model, status) "
								+ "VALUES(?,?,?,?,?,?)")) {

			pst.setInt(1, bean.getOwnerId());
			pst.setInt(2, bean.getDriverId());
			pst.setString(3, bean.getVehicleNo());
			pst.setString(4, bean.getVehicleType());
			pst.setString(5, bean.getModel());
			pst.setString(6, bean.getStatus());

			pst.executeUpdate();
			flagInsert = true;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flagInsert;
	}

	public static List<VehicleBean> listVehicles() throws SQLException {
		List<VehicleBean> list = new ArrayList<>();

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle ORDER BY vehicle_id DESC");
				ResultSet rs = pst.executeQuery()) {

			while (rs.next()) {
				VehicleBean bean = new VehicleBean();
				bean.setVehicleId(rs.getInt("vehicle_id"));
				bean.setOwnerId(rs.getInt("owner_id"));
				bean.setDriverId(rs.getInt("driver_id"));
				bean.setVehicleNo(rs.getString("vehicle_no"));
				bean.setVehicleType(rs.getString("vehicle_type"));
				bean.setModel(rs.getString("model"));
				bean.setStatus(rs.getString("status"));

				list.add(bean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public static VehicleBean fetchVehicleById(int vehicleId) throws SQLException {
		VehicleBean bean = null;

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement("SELECT * FROM vehicle WHERE vehicle_id=?")) {

			pst.setInt(1, vehicleId);
			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				bean = new VehicleBean();
				bean.setVehicleId(rs.getInt("vehicle_id"));
				bean.setOwnerId(rs.getInt("owner_id"));
				bean.setDriverId(rs.getInt("driver_id"));
				bean.setVehicleNo(rs.getString("vehicle_no"));
				bean.setVehicleType(rs.getString("vehicle_type"));
				bean.setModel(rs.getString("model"));
				bean.setStatus(rs.getString("status"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bean;
	}

	public static List<VehicleBean> fetchVehiclesByOwner(int ownerId) throws SQLException {
		List<VehicleBean> list = new ArrayList<>();

		try (Connection con = getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT * FROM vehicle WHERE owner_id=? ORDER BY vehicle_no ASC")) {

			pst.setInt(1, ownerId);
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				VehicleBean bean = new VehicleBean();
				bean.setVehicleId(rs.getInt("vehicle_id"));
				bean.setOwnerId(rs.getInt("owner_id"));
				bean.setDriverId(rs.getInt("driver_id"));
				bean.setVehicleNo(rs.getString("vehicle_no"));
				bean.setVehicleType(rs.getString("vehicle_type"));
				bean.setModel(rs.getString("model"));
				bean.setStatus(rs.getString("status"));

				list.add(bean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public static boolean updateVehicle(VehicleBean bean) throws SQLException {
		boolean flag = false;

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement(
						"UPDATE vehicle SET owner_id=?, driver_id=?, vehicle_no=?, vehicle_type=?, model=?, status=? "
								+ "WHERE vehicle_id=?")) {

			pst.setInt(1, bean.getOwnerId());
			pst.setInt(2, bean.getDriverId());
			pst.setString(3, bean.getVehicleNo());
			pst.setString(4, bean.getVehicleType());
			pst.setString(5, bean.getModel());
			pst.setString(6, bean.getStatus());
			pst.setInt(7, bean.getVehicleId());

			pst.executeUpdate();
			flag = true;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static boolean deleteVehicle(int vehicleId) throws SQLException {
		boolean flag = false;

		try (Connection con = getConnection();
				PreparedStatement pst = con.prepareStatement("DELETE FROM vehicle WHERE vehicle_id=?")) {

			pst.setInt(1, vehicleId);
			pst.executeUpdate();
			flag = true;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}

	public static List<VehicleBean> listVehiclesByDriver(int driverId) throws SQLException {
		List<VehicleBean> list = new ArrayList<>();

		try (Connection con = getConnection();
				PreparedStatement pst = con
						.prepareStatement("SELECT * FROM vehicle WHERE driver_id=? ORDER BY vehicle_no ASC")) {

			pst.setInt(1, driverId);
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				VehicleBean bean = new VehicleBean();
				bean.setVehicleId(rs.getInt("vehicle_id"));
				bean.setOwnerId(rs.getInt("owner_id"));
				bean.setDriverId(rs.getInt("driver_id"));
				bean.setVehicleNo(rs.getString("vehicle_no"));
				bean.setVehicleType(rs.getString("vehicle_type"));
				bean.setModel(rs.getString("model"));
				bean.setStatus(rs.getString("status"));

				list.add(bean);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public static List<VehicleBean> getAllVehicles() {
        List<VehicleBean> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicle ORDER BY vehicle_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                VehicleBean v = new VehicleBean();
                v.setVehicleId(rs.getInt("vehicle_id"));
                v.setVehicleNo(rs.getString("vehicle_no"));
                v.setOwnerId(rs.getInt("owner_id"));
                list.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
