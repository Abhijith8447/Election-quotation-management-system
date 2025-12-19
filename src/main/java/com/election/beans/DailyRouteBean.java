package com.election.beans;

public class DailyRouteBean {

    private int dailyId;
    private int vehicleId;
    private String route;
    private double startKilometer;
    private double endKilometer;
    private double actualKilometer;   // generated column
    private String date;

    // ---------- Getters and Setters ----------

    public int getDailyId() {
        return dailyId;
    }

    public void setDailyId(int dailyId) {
        this.dailyId = dailyId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public double getStartKilometer() {
        return startKilometer;
    }

    public void setStartKilometer(double startKilometer) {
        this.startKilometer = startKilometer;
    }

    public double getEndKilometer() {
        return endKilometer;
    }

    public void setEndKilometer(double endKilometer) {
        this.endKilometer = endKilometer;
    }

    public double getActualKilometer() {
        return actualKilometer;
    }

    
    public void setActualKilometer(double actualKilometer) {
        this.actualKilometer = actualKilometer;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
