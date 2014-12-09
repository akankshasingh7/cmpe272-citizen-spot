package com.citizen.spot.util;

import com.cloudinary.*;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

import org.apache.log4j.Logger;

public class ImageUtil {

	private static Logger logger = Logger.getLogger(ImageUtil.class);
	private static final Cloudinary cloudinary = new Cloudinary(Cloudinary.asMap("cloud_name",
			"dtcvcuxvl", "api_key", "713636812854857", "api_secret",
			"0N1r_Er9N64FF1As8YQQyfTyjXg"));
	String CLOUDINARY_URL = "cloudinary://713636812854857:0N1r_Er9N64FF1As8YQQyfTyjXg@dtcvcuxvl";
	public static SingletonManager getManager() {
		SingletonManager manager = new SingletonManager();
		manager.setCloudinary(cloudinary);
		manager.init();
		return manager;
	}
	
	public static Map uploadImage(File file, String uuid) {
		
		Map result = null;
		try {
			System.out.println("--- in image util----");
			result = cloudinary.uploader().upload(file, Cloudinary.asMap(
					  "public_id", uuid,
					  "transformation", new Transformation().crop("limit").width(250).height(250),
					  "eager", Arrays.asList(
					    new Transformation().width(200).height(200)
					      .crop("thumb").gravity("face").radius(20)
					      .effect("sepia"),
					    new Transformation().width(100).height(150)
					      .crop("fit").fetchFormat("png")
					  ),
					  "tags", "special, for_homepage"));
		} catch (IOException e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public static void main(String[] a) {
		
		File file = new File("/Users/bonnie/Desktop/mach.jpg");
		Map uploadResult = uploadImage(file, CitizenSpotUtil.getUUID());
		System.out.println(uploadResult.get("url").toString());
	}
}
