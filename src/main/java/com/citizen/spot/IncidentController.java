package com.citizen.spot;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.UUID;

import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;

import java.util.Map;

import com.sun.jersey.multipart.FormDataParam;
import com.citizen.spot.dao.ProblemDAO;
import com.citizen.spot.model.Problem;
import com.citizen.spot.util.CitizenSpotUtil;
import com.citizen.spot.util.ImageUtil;

@Path("/Incident")
public class IncidentController {

    private static Logger logger = Logger.getLogger(IncidentController.class);
    
	@POST
	@Path("upload/")
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadProblem(
			@FormDataParam("picture") InputStream uploadedInputStream,
			@FormDataParam("problemName") String problemName,
			@FormDataParam("severity") int severity,
			@FormDataParam("problemType") int problemType,
			@FormDataParam("date") Timestamp date,
			@FormDataParam("street") String street,
			@FormDataParam("city") String city,
			@FormDataParam("state") String state,
			@FormDataParam("country") String country,
			@FormDataParam("zipcode") String zipcode,
			@FormDataParam("description") String description)
	{
System.out.println("u r in upload Problem");
/*** test***/

		String uuid = CitizenSpotUtil.getUUID();
		
        try {
        	Problem problem = new Problem();
            problem.setTypeId(problemType);
            problem.setSeverity(severity);
            problem.setDate(date);
            problem.setStreet(street);
            problem.setCity(city);
            problem.setState(state);
            problem.setCountry(country);
            problem.setZipcode(zipcode);
            problem.setTypeId(problemType);
            problem.setDescription(description);
            problem.setUploadedBy("username from session");

            problem.setUploadedFileLocation(writeToFile(uploadedInputStream, uuid));
            System.out.println(problem);
            // database call to save the problem object
            ProblemDAO problemDAO = new ProblemDAO();
            problemDAO.uploadProblem(problem);
            System.out.println(problem.getCity());
            
        } catch(Exception e) {
        	logger.error(e.getMessage());
            return Response.status(500).entity(e.getMessage()).build();
        }
		return Response.status(200).entity("success").build();
	}
	
    private String writeToFile(InputStream uploadedInputStream, String uuid) throws Exception {
    	File image = CitizenSpotUtil.stream2file(uploadedInputStream);
    	Map uploadResult = ImageUtil.uploadImage(image, uuid);
    	return uploadResult.get("url").toString();
    }
    
}