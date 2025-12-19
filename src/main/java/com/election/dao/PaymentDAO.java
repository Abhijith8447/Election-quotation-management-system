package com.election.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.PaymentBean;

public class PaymentDAO {

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


    // ----------- LIST ALL PAYMENTS --------------------
    public static List<PaymentBean> listPayments() throws SQLException {
        List<PaymentBean> list = new ArrayList<>();

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement("SELECT * FROM payment ORDER BY payment_id ASC");
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                PaymentBean bean = new PaymentBean();
                bean.setPaymentId(rs.getInt("payment_id"));
                bean.setPaymentRate(rs.getDouble("payment_rate"));
                bean.setPaymentYear(rs.getString("payment_year"));

                list.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    // ----------- FETCH PAYMENT BY ID --------------------
    public static PaymentBean fetchPaymentById(int paymentId) throws SQLException {
        PaymentBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement("SELECT * FROM payment WHERE payment_id=?")) {

            pst.setInt(1, paymentId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                bean = new PaymentBean();
                bean.setPaymentId(rs.getInt("payment_id"));
                bean.setPaymentRate(rs.getDouble("payment_rate"));
                bean.setPaymentYear(rs.getString("payment_year"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bean;
    }


    // ----------- UPDATE PAYMENT (EDIT ACTION) --------------------
    public static boolean updatePayment(PaymentBean bean) throws SQLException {
        boolean flag = false;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(
                "UPDATE payment SET payment_rate=?, payment_year=? WHERE payment_id=?"
             )) {

            pst.setDouble(1, bean.getPaymentRate());
            pst.setString(2, bean.getPaymentYear());
            pst.setInt(3, bean.getPaymentId());

            pst.executeUpdate();
            flag = true;

        } catch (SQLException sql) {
            sql.printStackTrace();
        }
        return flag;
    }
}
