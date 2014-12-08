package com.citizen.spot.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.citizen.spot.model.Problem;
import com.citizen.spot.model.ProblemType;

public class ProblemDAO {

	private DataSource dataSource;
	 
	public ProblemDAO(){
		
	  try {
		Context ctx = new InitialContext();
		dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/citizenspot");
	  } catch (NamingException e) {
		e.printStackTrace();
	  }
	}
	
	public int uploadProblem(Problem problem) throws SQLException
	{
		System.out.println("inside uploadProblem");
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		//int zip=Integer.parseInt(problem.getZipcode());
		
	//	System.out.println("zipcode :"+zip);
		System.out.println("before insert");
		String sql = "INSERT INTO problem(problem_name,description,date,severity,street,city,state,zipcode,country,image,type_id) values('"+problem.getProblemName()+"','"+problem.getDescription()+"','"+problem.getDate()+"','"+problem.getSeverity()+"','"+problem.getStreet()+"','"+problem.getCity()+"','"+problem.getState()+"','"+problem.getZipcode()+"','"+problem.getCountry()+"','"+problem.getUploadedFileLocation()+"','"+problem.getTypeId()+"')";
		
		int rowUpdated = statement.executeUpdate(sql);
		System.out.println("after update sql");
		statement.close();
		connection.close();
		return rowUpdated;

	}
	
	public ArrayList<ProblemType> getProblemTypeList() throws SQLException {

		ArrayList<ProblemType> problems =  new ArrayList<ProblemType>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT * FROM problemtype";
		ResultSet rs = statement.executeQuery(sql);
		int i=0;

		while (rs.next()) {
			i++;
			ProblemType problemType = new ProblemType();
			problemType.setName(rs.getString("name"));
			problemType.setDescription(rs.getString("description"));
			problems.add(problemType);
			System.out.print(" problem type name "+i+" is "+problemType.getName()+" description is "+problemType.getDescription());
			
			
		}
		rs.close();
		statement.close();
		connection.close();
		return problems;
	}
	public ArrayList<Problem> listProblems() throws SQLException
	{
		ArrayList<Problem> problems =  new ArrayList<Problem>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "select a.*, d.name as problemtype_name from problem a inner join (select type_id , group_concat(id order by severity desc) grouped_id from problem group by  type_id  ) b on a.type_id = b.type_id and find_in_set(a.id, b.grouped_id) <= 3 inner join (select type_id, sum(count) rank from problem  group by type_id order by rank desc limit 3) c on a.type_id = c.type_id inner join problemtype d on a.type_id = d.id order by a.severity desc,c.rank desc, a.count desc;";
		ResultSet rs = statement.executeQuery(sql);
		int i=0; 
		
		while (rs.next()) {
			i++;
			Problem problem = new Problem();
			problem.setId(rs.getInt("id"));
			problem.setTypeId(rs.getInt("type_id"));
			problem.setProblemName(rs.getString("problem_name"));
			problem.setDescription(rs.getString("description"));
			problem.setSideOfRoad(rs.getString("side_of_road"));
			problem.setSeverity(rs.getInt("severity"));
			problem.setLatitude(rs.getFloat("latitude"));
			problem.setLongitude(rs.getFloat("longitude"));
			problem.setState(rs.getString("street"));
			problem.setState(rs.getString("state"));
			problem.setAddressLine(rs.getString("address_line"));
			problem.setCity(rs.getString("city"));
			problem.setImage(rs.getString("image"));
			System.out.print(" problem  name "+i+" is "+problem.getProblemName()+" description is "+problem.getDescription());
			
			problems.add(problem);
		}
		rs.close();
		statement.close();
		connection.close();
		return problems;
	}
	public ArrayList<Problem> displayTenProblemByZipcode(String zipcode) throws SQLException
	{
		ArrayList<Problem> pList = new ArrayList<Problem>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "select * from problem where zipcode="+zipcode+" order by count desc limit 10";
		System.out.println(" \n  ----- query is ---"+sql);
		ResultSet rs = statement.executeQuery(sql);
		
		ArrayList<Problem> problemsList = new ArrayList<Problem>();
	
		while(rs.next())
		{
			Problem problem = new Problem();
			System.out.println("-------  id returned is ------"+rs.getInt("id"));
			problem.setId(rs.getInt("id"));
			problem.setTypeId(rs.getInt("type_id"));
			problem.setProblemName(rs.getString("problem_name"));
			problem.setDescription(rs.getString("description"));
			problem.setSideOfRoad(rs.getString("side_of_road"));
			problem.setSeverity(rs.getInt("severity"));
			problem.setLatitude(rs.getFloat("latitude"));
			problem.setLongitude(rs.getFloat("longitude"));
			problem.setState(rs.getString("street"));
			problem.setState(rs.getString("state"));
			problem.setAddressLine(rs.getString("address_line"));
			problem.setCity(rs.getString("city"));
			problem.setImage(rs.getString("image"));
			problemsList.add(problem);
			
			
		} 
		rs.close();
		statement.close();
		connection.close();
		return problemsList;
	}
	public Problem displayProblemById(String id) throws SQLException
	{
		Problem problem = new Problem();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "select * from problem where id="+id+";";
		System.out.println(" \n  ----- query is ---"+sql);
		ResultSet rs = statement.executeQuery(sql);
		
		while(rs.next())
		{
			System.out.println("-------  id returned is ------"+rs.getInt("id"));
			problem.setId(rs.getInt("id"));
			problem.setTypeId(rs.getInt("type_id"));
			problem.setProblemName(rs.getString("problem_name"));
			problem.setDescription(rs.getString("description"));
			problem.setSideOfRoad(rs.getString("side_of_road"));
			problem.setSeverity(rs.getInt("severity"));
			problem.setLatitude(rs.getFloat("latitude"));
			problem.setLongitude(rs.getFloat("longitude"));
			problem.setState(rs.getString("street"));
			problem.setState(rs.getString("state"));
			problem.setAddressLine(rs.getString("address_line"));
			problem.setCity(rs.getString("city"));
			problem.setImage(rs.getString("image"));
			problem.setDate(rs.getDate("date"));
		} 
		rs.close();
		statement.close();
		connection.close();
		return problem;
	}
	
	
}
