package com.citizen.spot.util;

import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import org.apache.log4j.Logger;

public class CitizenSpotUtil {
	
	private static Logger logger = Logger.getLogger(CitizenSpotUtil.class);
    private static final DecimalFormat timeFormat4 = new DecimalFormat("0000;0000");

    public static final String PREFIX = "tempImage";
    public static final String SUFFIX = ".jpg";
    
    public static String getUUID() {
        Calendar cal = Calendar.getInstance();
        String val = String.valueOf(cal.get(Calendar.YEAR));
        val += timeFormat4.format(cal.get(Calendar.DAY_OF_YEAR));
        val += UUID.randomUUID().toString().replaceAll("-", "");
        return val;
    }

    public static File stream2file (InputStream in) throws IOException {
        final File tempFile = File.createTempFile(PREFIX, SUFFIX);
        tempFile.deleteOnExit();
        try (FileOutputStream out = new FileOutputStream(tempFile)) {
            IOUtils.copy(in, out);
        }
        return tempFile;
    }
    
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(getUUID());
	}
}
