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

import org.apache.log4j.Logger;

import com.citizen.spot.IncidentController;
import com.citizen.spot.model.ChartCityList;
import com.citizen.spot.model.ChartList;
import com.citizen.spot.model.ChartZipList;
import com.citizen.spot.model.Problem;
import com.citizen.spot.model.ProblemType;

public class ProblemDAO {

	private static Logger logger = Logger.getLogger(IncidentController.class);
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
		logger.info("inside uploadProblem");
		Connection connection = dataSource.getConnection();
		
		logger.info("before insert");
		String sql = "INSERT INTO `problem`(`type_id`, `problem_name`, `description`, `image`, `date`, `side_of_road`, "
				+ "`severity`, `count`, `latitude`, `longitude`, `address_line`, `street`, `city`, `state`, `zipcode`, `uploaded_by`) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setInt(1, problem.getTypeId());
		preparedStatement.setString(2, problem.getProblemName());
		preparedStatement.setString(3, problem.getDescription());
		preparedStatement.setString(4, problem.getImage());
		preparedStatement.setTimestamp(5, problem.getDate());
		preparedStatement.setString(6, problem.getSideOfRoad());
		preparedStatement.setInt(7, problem.getSeverity());
		preparedStatement.setInt(8, problem.getCount());
		preparedStatement.setDouble(9, problem.getLatitude());
		preparedStatement.setDouble(10, problem.getLongitude());
		preparedStatement.setString(11, problem.getAddressLine());
		preparedStatement.setString(12, problem.getStreet());
		preparedStatement.setString(13, problem.getCity());
		preparedStatement.setString(14, problem.getState());
		preparedStatement.setString(15, problem.getZipcode());
		preparedStatement.setString(16, problem.getUploadedBy());
		
		int rowUpdated = preparedStatement.executeUpdate();
		logger.info("after update sql");
		preparedStatement.close();
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
		logger.info(" \n  ----- query is ---"+sql);
		ResultSet rs = statement.executeQuery(sql);
		
		ArrayList<Problem> problemsList = new ArrayList<Problem>();
	
		while(rs.next())
		{
			Problem problem = new Problem();
			logger.info("-------  id returned is ------"+rs.getInt("id"));
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
		logger.info(" \n  ----- query is ---"+sql);
		ResultSet rs = statement.executeQuery(sql);
		
		while(rs.next())
		{
			logger.info("-------  id returned is ------"+rs.getInt("id"));
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
			problem.setDate(rs.getTimestamp("date"));
		} 
		rs.close();
		statement.close();
		connection.close();
		return problem;
	}

	public ArrayList<ChartList> displayProblemZipBarChart() throws SQLException
	{
		ArrayList<ChartList> chartList =  new ArrayList<ChartList>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT city, count(*) as num from problem group by zipcode order by num desc;";
		ResultSet rs = statement.executeQuery(sql);
		ChartList cl = new ChartList();		
		while (rs.next()) {
			cl.setCity(rs.getString("city"));
			cl.setNumber(rs.getInt("num"));
			chartList.add(cl);
		}
		rs.close();
		statement.close();
		connection.close();
		return chartList;
	}

	public ArrayList<ChartZipList> getProblemByZip() throws SQLException {
		
		ArrayList<ChartZipList> chartList =  new ArrayList<ChartZipList>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT zipcode, count(*) as num from problem group by zipcode order by num desc";
		ResultSet rs = statement.executeQuery(sql);		
		while (rs.next()) {
			ChartZipList cl = new ChartZipList();
			cl.setZip(rs.getString("zipcode"));
			cl.setNumber(rs.getInt("num"));
			chartList.add(cl);
		}
		rs.close();
		statement.close();
		connection.close();
		return chartList;
	}

	public ArrayList<ChartCityList> getProblemByCity() throws SQLException {
		
		ArrayList<ChartCityList> chartList =  new ArrayList<ChartCityList>();
		Connection connection = dataSource.getConnection();
		Statement statement = connection.createStatement();
		String sql = "SELECT city, count(*) as num from problem group by city order by num desc";
		ResultSet rs = statement.executeQuery(sql);	
		while (rs.next()) {
			ChartCityList cl = new ChartCityList();	
			cl.setCity(rs.getString("city"));
			cl.setNumber(rs.getInt("num"));
			chartList.add(cl);
		}
		rs.close();
		statement.close();
		connection.close();
		return chartList;
	}

}
