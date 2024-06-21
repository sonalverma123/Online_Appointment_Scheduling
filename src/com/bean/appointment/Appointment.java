package com.bean.appointment;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public class Appointment {
    private int id;
    private String department;
    private String phoneNumber;
    private String fullName;
    private String email;
    private String healthProfessional; // added new field for health professional
    private LocalDate appointmentDate;
    private LocalTime appointmentTime;
    private LocalDateTime createdAt;

    public Appointment(int id, String department, String phoneNumber, String fullName, String email, String healthProfessional, LocalDate appointmentDate, LocalTime appointmentTime, LocalDateTime user) {
        this.id = id;
        this.department = department;
        this.phoneNumber = phoneNumber;
        this.fullName = fullName;
        this.email = email;
        this.healthProfessional = healthProfessional;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.createdAt = user;
    }

    public Appointment(int appointmentId, String department2, String phoneNumber2, String fullName2, String email2,
			String healthProfessional2, LocalDate appointmentDate2, LocalTime appointmentTime2, User user) {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
        return id;
    }

    public String getDepartment() {
        return department;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getHealthProfessional() {
        return healthProfessional;
    }

    public LocalDate getAppointmentDate() {
        return appointmentDate;
    }

    public LocalTime getAppointmentTime() {
        return appointmentTime;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
