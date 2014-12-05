package com.citizen.spot.model;

import java.io.Serializable;

public class ProblemType implements Serializable{

 private static final long serialVersionUID = -221849245616101006L;
 private String name;
 private String description;
public String getName() {
	return name;
}
public void setName(String problemType) {
	this.name = problemType;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
}
