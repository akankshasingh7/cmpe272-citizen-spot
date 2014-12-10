package com.citizen.spot;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.citizen.spot.dao.UserDAO;
import com.citizen.spot.model.User;
import com.citizen.spot.util.HashUtil;
import com.sun.jersey.api.view.Viewable;

@Path("/User")
public class UserController {

    private static Logger logger = Logger.getLogger(UserController.class);
    private ObjectMapper mapper = new ObjectMapper();
    
	@POST
	@Path("register/")
	public Viewable register(
			@FormParam("firstName") String firstName,
			@FormParam("lastName") String lastName,
			@FormParam("email") String email,
			@FormParam("password") String password,
			@FormParam("address1") String address1,
			@FormParam("street") String street,
			@FormParam("city") String city,
			@FormParam("state") String state,
			@FormParam("zip") String zip,
			@FormParam("country") String country,
			@Context HttpServletRequest request) {

		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();
		try {
			
			User user = new User(firstName, lastName, email, HashUtil.getSaltedHash(password), "user", address1, street, city, state, zip, country);
			
			int rowNum = userDAO.createUser(user);
			if(rowNum > 0) {
				user.setPassword("");
				session.setAttribute("USER", user);
				return new Viewable("/home.jsp", user);
			}
			else {
				return new Viewable("/index.jsp", null);
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", null);
		}
	}
	
	@POST
	@Path("login")
	public Viewable login(@FormParam("userName") String userName,
			@FormParam("password") String password,
			@Context HttpServletRequest request) {

		UserDAO userDAO = new UserDAO();
		HttpSession session = request.getSession();
		try {
			User user = userDAO.getUser(userName);
			if(HashUtil.check(password, user.getPassword())) {
				user.setPassword("");
				session.setAttribute("USER", user);
				return new Viewable("/home.jsp", user);
			}
			else {
				return new Viewable("/index.jsp", null);
			}
		} catch (SQLException e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", e.getMessage());
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", e.getMessage());
		} catch (JsonMappingException e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", e.getMessage());
		} catch (IOException e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", e.getMessage());
		} catch (Exception e) {
			logger.error(e.getMessage());
			return new Viewable("/index.jsp", e.getMessage());
		}
	}
	
	@POST
	@Path("logout")
	public Viewable logout(@Context HttpServletRequest request) {

		HttpSession session = request.getSession();
		session.removeAttribute("USER");
		session.invalidate();
		return new Viewable("/index.jsp", null);
	}
	
	@GET
	@Path("list")
	@Produces(MediaType.APPLICATION_JSON)
	public Response getUserList() {

		UserDAO userDAO = new UserDAO();
		try {
			ArrayList<User> users = userDAO.getUserList();
			return Response.status(200).entity(mapper.writeValueAsString(users)).build();
		} catch (SQLException e) {
			e.printStackTrace();
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