package com.citizen.spot.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.citizen.spot.model.User;

public class UserDAO {


	private DataSource dataSource;
	 
	public UserDAO(){
	  try {
		Context ctx = new InitialContext();
		dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/citizenspot");
	  } catch (NamingException e) {
		e.printStackTrace();
	  }
	}
	
	public User getUser(String email) throws SQLException {

		User user =  null;
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT * FROM user where email_id='"+email+"'";
		ResultSet rs = statement.executeQuery(sql);

		while (rs.next()) {

			user = new User();
			user.setFirstName(rs.getString("first_name"));
			user.setLastName(rs.getString("last_name"));
			user.setEmail(rs.getString("email_id"));
			user.setPassword(rs.getString("password"));
			user.setUserType(rs.getString("user_type"));
		}
		rs.close();
		statement.close();
		connection.close();
		return user;
	}
	
	public ArrayList<User> getUserList() throws SQLException {

		ArrayList<User> users =  new ArrayList<User>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT * FROM user";
		ResultSet rs = statement.executeQuery(sql);

		while (rs.next()) {

			User user = new User();
			user.setFirstName(rs.getString("first_name"));
			user.setLastName(rs.getString("last_name"));
			user.setEmail(rs.getString("email_id"));
			users.add(user);
		}
		rs.close();
		statement.close();
		connection.close();
		return users;
	}
	
	public int createUser(User user) throws SQLException {

		Connection connection = dataSource.getConnection();
		PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO `user`(`first_name`, `last_name`, `email_id`, `password`, "
				+ "`user_type`, `adressLine1`, `street`, `city`, `state`, `zipcode`, `country`) VALUES (?,?,?,?,?,?,?,?,?,?,?)");
		
		preparedStatement.setString(1, user.getFirstName());
		preparedStatement.setString(2, user.getLastName());
		preparedStatement.setString(3, user.getEmail());
		preparedStatement.setString(4, user.getPassword());
		preparedStatement.setString(5, user.getUserType());
		preparedStatement.setString(6, user.getAddress1());
		preparedStatement.setString(7, user.getStreet());
		preparedStatement.setString(8, user.getCity());
		preparedStatement.setString(9, user.getState());
		preparedStatement.setString(10, user.getZip());
		preparedStatement.setString(11, user.getCountry());
		
		int rowUpdated = preparedStatement.executeUpdate();
		preparedStatement.close();
		connection.close();
		return rowUpdated;
	}
}