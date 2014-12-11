package com.citizen.spot;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.JsonNodeFactory;
//import org.codehaus.jackson.node.JsonNodeFactory;
import org.codehaus.jackson.node.ObjectNode;

import com.citizen.spot.dao.ProblemDAO;
import com.citizen.spot.model.ChartList;
import com.citizen.spot.model.KeyValue;
import com.citizen.spot.model.Problem;
import com.citizen.spot.model.ProblemType;

/**
 * @author akanksha, Manami
 *
 */
@Path("/Problems")
public class DisplayProblemsController {
	
	private static Logger logger = Logger.getLogger(DisplayProblemsController.class);
	
	public DisplayProblemsController() {

	}

	private ObjectMapper mapper = new ObjectMapper();

	/*
	 * 
	 * The method below is used to search the problems by zipcode
	 */

	@GET
	@Path("SearchByZipcode/{zipcode}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response displayTenProblemByZipcode(
			@PathParam("zipcode") String zipcode) {
		
		logger.info(" \n--- zip code is ---- " + zipcode);
		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<Problem> problemsListByZipcode = problemDAO
					.displayTenProblemByZipcode(zipcode);
			
			logger.info(" --- size of list--- " + problemsListByZipcode.size());
			return Response.status(200)
					.entity(mapper.writeValueAsString(problemsListByZipcode))
					.build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();

	}

	/*
	 * The method below is to display the problem based on the id selected
	 */

	@GET
	@Path("listById/{id}")
	@Produces(MediaType.APPLICATION_JSON)
	public Response displayProblemById(@PathParam("id") String id) {
		logger.info(" \n--- id is ---- " + id);
		ProblemDAO problemDAO = new ProblemDAO();
		try {
			Problem problemById = problemDAO.displayProblemById(id);
			logger.info(" --- image of problem --- " + problemById.getImage());
			logger.info(" --- name of problem --- "
					+ problemById.getProblemName());
			return Response.status(200)
					.entity(mapper.writeValueAsString(problemById)).build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();

	}

	@GET
	@Path("list")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getProblemTypeList() {

		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<ProblemType> problemTypes = problemDAO
					.getProblemTypeList();
			return Response.status(200)
					.entity(mapper.writeValueAsString(problemTypes)).build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();
	}

	@GET
	@Path("listProblems")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getListofProblems() {

		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<Problem> problem = problemDAO.listProblems();
			logger.info("--- size of array listProblems ----" + problem.size());
			return Response.status(200)
					.entity(mapper.writeValueAsString(problem)).build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();
	}

	@GET
	@Path("chartList")
	@Produces(MediaType.APPLICATION_JSON)
	public Response displayProblemZipBarChart() {

		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<ChartList> chartValues = problemDAO
					.displayProblemZipBarChart();
			logger.info("--- size of array displayProblemZipBarChart ----"
					+ chartValues.size());
			return Response.status(200)
					.entity(mapper.writeValueAsString(chartValues)).build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();
	}

	@GET
	@Path("chartByZip")
	@Produces(MediaType.APPLICATION_JSON)
	public Response displayChartByZipCity() {

		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<KeyValue> chartZipValues = problemDAO.getProblemByZip();
			ArrayList<KeyValue> chartCityValues = problemDAO.getProblemByCity();
			JsonNodeFactory nodeFactory = mapper.getNodeFactory();
			ObjectNode node = nodeFactory.objectNode();
			node.put("zip", mapper.writeValueAsString(chartZipValues));
			node.put("city", mapper.writeValueAsString(chartCityValues));

			return Response.status(200).entity(node.toString()).build();
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return Response.status(500).entity("failed").build();
	}
}
