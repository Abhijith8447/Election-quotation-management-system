package com.election.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.election.beans.ExpenseBean;

public class ExpenseDAO {

    // -------------------- DB CONNECTION --------------------
    public static Connection getConnection() throws SQLException {
        try {
            DBDAO.connect();
            return DBDAO.getDbCon();
        } catch (Exception e) {
            e.printStackTrace();
            throw new SQLException("Database connection failed");
        }
    }

    // -------------------- INSERT EXPENSE --------------------
    public static boolean insertExpense(ExpenseBean bean) {
        String sql = "INSERT INTO expense (owner_name, vehicle_id, date, category, total_cost, status) "
                   + "VALUES (?, ?, ?, ?, ?, 'pending')";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, bean.getOwnerName());
            pst.setInt(2, bean.getVehicleId());
            pst.setString(3, bean.getDate());
            pst.setString(4, bean.getCategory());
            pst.setDouble(5, bean.getTotalCost());

            pst.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------------------- GET EXPENSE BY OWNER --------------------
    public static List<ExpenseBean> getExpensesByOwner(int ownerId) {

        List<ExpenseBean> list = new ArrayList<>();

        // owner_name is string, but you store actual OWNER NAME manually
        String sql = "SELECT e.* FROM expense e "
                   + "JOIN vehicle v ON e.vehicle_id = v.vehicle_id "
                   + "WHERE v.owner_id = ? "
                   + "ORDER BY e.expense_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, ownerId);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    ExpenseBean bean = new ExpenseBean();

                    bean.setExpenseId(rs.getInt("expense_id"));
                    bean.setOwnerName(rs.getString("owner_name"));
                    bean.setVehicleId(rs.getInt("vehicle_id"));
                    bean.setDate(rs.getString("date"));
                    bean.setCategory(rs.getString("category"));
                    bean.setTotalCost(rs.getDouble("total_cost"));
                    bean.setStatus(rs.getString("status"));

                    list.add(bean);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // -------------------- FETCH EXPENSE BY ID --------------------
    public static ExpenseBean getExpenseById(int expenseId) {
        String sql = "SELECT * FROM expense WHERE expense_id=?";

        ExpenseBean bean = null;

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, expenseId);

            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    bean = new ExpenseBean();

                    bean.setExpenseId(rs.getInt("expense_id"));
                    bean.setOwnerName(rs.getString("owner_name"));
                    bean.setVehicleId(rs.getInt("vehicle_id"));
                    bean.setDate(rs.getString("date"));
                    bean.setCategory(rs.getString("category"));
                    bean.setTotalCost(rs.getDouble("total_cost"));
                    bean.setStatus(rs.getString("status"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bean;
    }
 // -------------------- GET ALL EXPENSES --------------------
    public static List<ExpenseBean> getAllExpenses() {
        List<ExpenseBean> list = new ArrayList<>();
        String sql = "SELECT * FROM expense ORDER BY expense_id DESC";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                ExpenseBean bean = new ExpenseBean();
                bean.setExpenseId(rs.getInt("expense_id"));
                bean.setOwnerName(rs.getString("owner_name"));
                bean.setVehicleId(rs.getInt("vehicle_id"));
                bean.setDate(rs.getString("date"));
                bean.setCategory(rs.getString("category"));
                bean.setTotalCost(rs.getDouble("total_cost"));
                bean.setStatus(rs.getString("status"));

                list.add(bean);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // -------------------- UPDATE EXPENSE (OWNER CANNOT CHANGE STATUS) --------------------
    public static boolean updateExpense(ExpenseBean bean) {
        String sql = "UPDATE expense SET owner_name=?, vehicle_id=?, date=?, category=?, total_cost=? "
                   + "WHERE expense_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, bean.getOwnerName());
            pst.setInt(2, bean.getVehicleId());
            pst.setString(3, bean.getDate());
            pst.setString(4, bean.getCategory());
            pst.setDouble(5, bean.getTotalCost());
            pst.setInt(6, bean.getExpenseId());

            pst.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // -------------------- DELETE EXPENSE --------------------
    public static boolean deleteExpense(int expenseId) {

        String sql = "DELETE FROM expense WHERE expense_id=?";

        try (Connection con = getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, expenseId);
            pst.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
