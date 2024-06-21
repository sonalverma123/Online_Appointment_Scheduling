package com.bean.appointment;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String role;
    private String createdAt;
    
    public User() {
        // Default constructor
    }


    public void setId(int id) {
		this.id = id;
	}


	public void setName(String name) {
		this.name = name;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}


	public User(int id, String name, String email, String password, String role, String createdAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
    }

    public User(int userId, String username, String userRole) {
		// TODO Auto-generated constructor stub
	}

	public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    public String getCreatedAt() {
        return createdAt;
    }
}