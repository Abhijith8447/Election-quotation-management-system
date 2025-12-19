package com.luminar.model;

import java.math.BigDecimal;

public class BillingBean {
    private int billId;
    private int ownerId;
    private String billDate;
    private BigDecimal amount;
    private BigDecimal totalKmRun;
    private BigDecimal paymentRate;
    private BigDecimal totalExpenses;
    private BigDecimal totalBillingAmount;

    // Getters and setters for all fields

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getBillDate() {
        return billDate;
    }

    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getTotalKmRun() {
        return totalKmRun;
    }

    public void setTotalKmRun(BigDecimal totalKmRun) {
        this.totalKmRun = totalKmRun;
    }

    public BigDecimal getPaymentRate() {
        return paymentRate;
    }

    public void setPaymentRate(BigDecimal paymentRate) {
        this.paymentRate = paymentRate;
    }

    public BigDecimal getTotalExpenses() {
        return totalExpenses;
    }

    public void setTotalExpenses(BigDecimal totalExpenses) {
        this.totalExpenses = totalExpenses;
    }

    public BigDecimal getTotalBillingAmount() {
        return totalBillingAmount;
    }

    public void setTotalBillingAmount(BigDecimal totalBillingAmount) {
        this.totalBillingAmount = totalBillingAmount;
    }
}
