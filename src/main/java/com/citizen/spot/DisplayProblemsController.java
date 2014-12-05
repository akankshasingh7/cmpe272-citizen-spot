package com.citizen.spot;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.citizen.spot.dao.ProblemDAO;
import com.citizen.spot.model.Problem;
import com.citizen.spot.model.ProblemType;

/**
 * @author akanksha
 *
 */
@Path("/Problems")
public class DisplayProblemsController {
	public DisplayProblemsController()
	{
		
	}
	
	private static Logger logger = Logger.getLogger(DisplayProblemsController.class);
    private ObjectMapper mapper = new ObjectMapper();
    
    /*
     * 
     * The method below is used to search the problems by zipcode
     * 
     */
    
    @GET @Path("SearchByZipcode/{zipcode}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response displayTenProblemByZipcode(@PathParam("zipcode") String zipcode)
    {	System.out.println(" \n--- zip code is ---- "+zipcode);
    	ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<Problem> problemsListByZipcode = problemDAO.displayTenProblemByZipcode(zipcode);
			System.out.println(" --- size of list--- "+problemsListByZipcode.size());
			return Response.status(200).entity(mapper.writeValueAsString(problemsListByZipcode)).build();
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Response.status(500).entity("failed").build();
	
    }
   /* 
    * 	The method below is to display the problem based on the id selected
    * 
    * 
    */
    
    @GET @Path("listById/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response displayProblemById(@PathParam("id") String id)
    {	System.out.println(" \n--- id is ---- "+id);
    	ProblemDAO problemDAO = new ProblemDAO();
		try {
			Problem problemById = problemDAO.displayProblemById(id);
			System.out.println(" --- image of problem --- "+problemById.getImage());
			System.out.println(" --- name of problem --- "+problemById.getProblemName());
			return Response.status(200).entity(mapper.writeValueAsString(problemById)).build();
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Response.status(500).entity("failed").build();
	
    }
    
    
    
    @GET
	@Path("list")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getProblemTypeList() {

		ProblemDAO problemDAO = new ProblemDAO();
		try {
			ArrayList<ProblemType> problemTypes = problemDAO.getProblemTypeList();
			return Response.status(200).entity(mapper.writeValueAsString(problemTypes)).build();
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
			System.out.println("--- size of array listProblems ----"+problem.size());
			return Response.status(200).entity(mapper.writeValueAsString(problem)).build();
		} catch (SQLException e) {
			e.printStackTrace();
			return Response.status(500).entity(e.getMessage()).build();
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Response.status(500).entity("failed").build();
	}
}
