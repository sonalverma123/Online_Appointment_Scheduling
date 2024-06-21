package com.bean.appointment;

public class HealthcareProfessional {
    private String name;
    private String profession;
    private String location;
    private String availability;
    
    public HealthcareProfessional() {
    }


    public HealthcareProfessional(String name, String profession, String location, String availability) {
        this.name = name;
        this.profession = profession;
        this.location = location;
        this.availability = availability;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String specialty) {
        this.profession = specialty;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }
}
