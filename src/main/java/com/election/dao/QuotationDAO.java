package com.election.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.QuotationBean;

public class QuotationDAO {

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

    // ---------- CHECK DUPLICATE QUOTATION ----------
    public static boolean checkQuotationExists(QuotationBean bean) throws SQLException {
        String sql = "SELECT * FROM quotations WHERE vehicle_id=? AND start_date=? AND end_date=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getStartDate());
            pst.setString(3, bean.getEndDate());

            try (ResultSet rs = pst.executeQuery()) {
                return rs.next(); // duplicate found
            }
        }
    }

    // ---------- INSERT QUOTATION ----------
    public static boolean insertQuotation(QuotationBean bean) throws SQLException {
        String sql = "INSERT INTO quotations (vehicle_id, start_date, end_date, contract_status) VALUES (?,?,?,?)";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getStartDate());
            pst.setString(3, bean.getEndDate());
            pst.setString(4, bean.getContractStatus());

            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- LIST ALL QUOTATIONS ----------
    public static List<QuotationBean> listQuotations() throws SQLException {
        List<QuotationBean> list = new ArrayList<>();
        String sql = "SELECT * FROM quotations ORDER BY quotation_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                QuotationBean bean = new QuotationBean();

                bean.setQuotationId(rs.getInt("quotation_id"));
                bean.setVehicleId(rs.getInt("vehicle_id"));
                bean.setStartDate(rs.getString("start_date"));
                bean.setEndDate(rs.getString("end_date"));
                bean.setContractStatus(rs.getString("contract_status"));

                list.add(bean);
            }
        }

        return list;
    }

    // ---------- FETCH QUOTATION BY ID ----------
    public static QuotationBean fetchQuotationById(int quotationId) throws SQLException {
        String sql = "SELECT * FROM quotations WHERE quotation_id=?";
        QuotationBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, quotationId);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    bean = new QuotationBean();

                    bean.setQuotationId(rs.getInt("quotation_id"));
                    bean.setVehicleId(rs.getInt("vehicle_id"));
                    bean.setStartDate(rs.getString("start_date"));
                    bean.setEndDate(rs.getString("end_date"));
                    bean.setContractStatus(rs.getString("contract_status"));
                }
            }
        }

        return bean;
    }

    // ---------- UPDATE QUOTATION ----------
    public static boolean updateQuotation(QuotationBean bean) throws SQLException {
        String sql = "UPDATE quotations SET vehicle_id=?, start_date=?, end_date=?, contract_status=? "
                   + "WHERE quotation_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, bean.getVehicleId());
            pst.setString(2, bean.getStartDate());
            pst.setString(3, bean.getEndDate());
            pst.setString(4, bean.getContractStatus());
            pst.setInt(5, bean.getQuotationId());

            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- DELETE QUOTATION ----------
    public static boolean deleteQuotation(int quotationId) throws SQLException {
        String sql = "DELETE FROM quotations WHERE quotation_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, quotationId);
            pst.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
