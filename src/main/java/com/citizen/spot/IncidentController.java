package com.citizen.spot;

import java.io.File;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.citizen.spot.dao.ProblemDAO;
import com.citizen.spot.model.Problem;
import com.citizen.spot.model.User;
import com.citizen.spot.util.CitizenSpotUtil;
import com.citizen.spot.util.ImageUtil;
import com.sun.jersey.multipart.FormDataParam;

@Path("/Incident")
public class IncidentController {

	private static Logger logger = Logger.getLogger(IncidentController.class);

	@POST
	@Path("upload/")
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadProblem(
			@FormDataParam("picture") InputStream uploadedInputStream,
			@FormDataParam("problemName") String problemName,
			@FormDataParam("problemSeverity") int severity,
			@FormDataParam("problemType") int problemType,
			@FormDataParam("problem-date") Timestamp date,
			@FormDataParam("side-of-road") String sideOfRoad,
			@FormDataParam("street") String street,
			@FormDataParam("city") String city,
			@FormDataParam("state") String state,
			@FormDataParam("country") String country,
			@FormDataParam("zip") String zipcode,
			@FormDataParam("description") String description,
			@Context HttpServletRequest request) {
		
		logger.info("u r in uploadProblem");

		HttpSession session = request.getSession();
		String uuid = CitizenSpotUtil.getUUID();
		User user = (User) session.getAttribute("USER");
		try {
			Problem problem = new Problem();
			problem.setTypeId(problemType);
			problem.setProblemName(problemName);
			problem.setDescription(description);
			problem.setDate(date);
			problem.setSideOfRoad(sideOfRoad);
			
			problem.setSeverity(severity);
			problem.setLatitude(0.0);
			problem.setLongitude(0.0);
			problem.setStreet(street);
			problem.setCity(city);
			problem.setState(state);
			problem.setZipcode(zipcode);
			problem.setUploadedBy(user.getEmail());

			String imagePath = writeToFile(uploadedInputStream, uuid);
			problem.setImage(imagePath);
			logger.info(problem);
			ProblemDAO problemDAO = new ProblemDAO();
			problemDAO.uploadProblem(problem);
			logger.info(problem.getCity());

		} catch (Exception e) {
			logger.error(e.getMessage());
			return Response.status(500).entity(e.getMessage()).build();
		}
		return Response.status(200).entity("success").build();
	}

	private String writeToFile(InputStream uploadedInputStream, String uuid)
			throws Exception {
		File image = CitizenSpotUtil.stream2file(uploadedInputStream);
		Map uploadResult = ImageUtil.uploadImage(image, uuid);
		String fileName = uploadResult.get("url").toString();
		return fileName;
	}

}