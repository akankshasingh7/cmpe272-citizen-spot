package com.citizen.spot.model;

import java.io.Serializable;

public class User implements Serializable{
	
	private static final long serialVersionUID = -221849245616101006L;
	
//	`first_name`, `last_name`, `email_id`, `password`, `user_type`, `adressLine1`, `street`, `city`, `state`, `zipcode`, `country`
	
	private String firstName;
	private String lastName;
	private String email;
	private String password;
	private String userType;
	private String address1;
	private String street;
	private String city;
	private String state;
	private String zip;
	private String country;
	
	public User() {
	}
	public User(String firstName, String lastName, String email, String password, String userType, String address1, String street, String city, String state, String zip, String country) {

		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.password = password;
		this.userType = userType;
		this.address1 = address1;
		this.street = street;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.country = country;
	}

	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
}
