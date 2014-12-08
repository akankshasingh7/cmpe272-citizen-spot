package com.citizen.spot.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class Problem implements Serializable {
	
	private static final long serialVersionUID = -221849245616101006L;
	
	private int Id;
	private int typeId;
	private String problemName;
	private String description;
	private Timestamp date;
	private String sideOfRoad;
	private int severity;
	private int count;
	private float latitude;
	private float longitude;
	private String addressLine;
	private String street;
	private String city;
	private String state;
	private String country; 
	
	private String zipcode;
	private String image;
	private String fileName;
	private String uploadedBy;
	
	public String getUploadedBy() {
		return uploadedBy;
	}

	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}

	public String toString() { 
	    return "problem Type: '" + this.problemName + 
	    		"', description: '" + this.description +
	    		
	    		"', severity: '" + this.severity + 
	    		"', date: '" + this.date + "'" + 
	    	    "', street: '" + this.street + "'" + 
	    	    "', city: '" + this.city + "'" + 
	    	    "', state: '" + this.state + "'" + 
	    	    "', country: '" + this.country + "'" + 
	    	    "', zipcode: '" + this.zipcode + "'" + 
	    	    "', image: '" + this.image + "'" + 
	    	    "', uploaded By: '" + this.uploadedBy + "'";
	}
	
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	public String getUploadedFileLocation() {
		return fileName;
	}
	public void setUploadedFileLocation(String uploadedFileLocation) {
		this.fileName = uploadedFileLocation;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public String getAddressLine() {
		return addressLine;
	}
	public void setAddressLine(String addressLine) {
		this.addressLine = addressLine;
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
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getProblemName() {
		return problemName;
	}
	public void setProblemName(String problemName) {
		this.problemName = problemName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSideOfRoad() {
		return sideOfRoad;
	}
	public void setSideOfRoad(String sideOfRoad) {
		this.sideOfRoad = sideOfRoad;
	}
	public int getSeverity() {
		return severity;
	}
	public void setSeverity(int severity) {
		this.severity = severity;
	}
	
	 

}
