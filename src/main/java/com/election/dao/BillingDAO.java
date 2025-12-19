package com.election.dao;

import com.luminar.model.BillingBean;
import java.sql.*;
import java.math.BigDecimal;

public class BillingDAO {

    // Fetch Total Km Run
    public BigDecimal getTotalKmRun(int ownerId) {
        BigDecimal totalKm = BigDecimal.ZERO;
        String query = "SELECT SUM(total_km) FROM vehicle WHERE owner_id = ?";

        try (Connection conn = DBDAO.getDbCon();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal km = rs.getBigDecimal(1);
                if (km != null) totalKm = km;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalKm;
    }

    // Fetch Payment Rate per owner per year
    public BigDecimal getPaymentRate(int ownerId) {
        BigDecimal rate = BigDecimal.ZERO;

        // FIXED: Added owner_id filtering
        String query = "SELECT payment_rate FROM payment " +
                       "WHERE owner_id = ? AND payment_year = YEAR(CURRENT_DATE())";

        try (Connection conn = DBDAO.getDbCon();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal r = rs.getBigDecimal(1);
                if (r != null) rate = r;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rate;
    }

    // Fetch Total Expenses
    public BigDecimal getTotalExpenses(int ownerId) {
        BigDecimal totalExpenses = BigDecimal.ZERO;

        String query = "SELECT SUM(total_cost) FROM expense " +
                       "WHERE vehicle_id IN (SELECT vehicle_id FROM vehicle WHERE owner_id = ?)";

        try (Connection conn = DBDAO.getDbCon();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal exp = rs.getBigDecimal(1);
                if (exp != null) totalExpenses = exp;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalExpenses;
    }

    // Calculate and return all billing details
    public BillingBean getBillingDetails(int ownerId) {
        BillingBean billing = new BillingBean();

        BigDecimal totalKm = getTotalKmRun(ownerId);
        BigDecimal paymentRate = getPaymentRate(ownerId);
        BigDecimal totalExpenses = getTotalExpenses(ownerId);

        // SAFE billing calculation
        BigDecimal totalBillingAmount =
            totalKm.multiply(paymentRate).add(totalExpenses);

        billing.setOwnerId(ownerId);
        billing.setTotalKmRun(totalKm);
        billing.setPaymentRate(paymentRate);
        billing.setTotalExpenses(totalExpenses);
        billing.setTotalBillingAmount(totalBillingAmount);

        return billing;
    }
}
