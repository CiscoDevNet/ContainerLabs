package com.java.acme;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Random;
import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;

public class BaseController {

    protected String makeWebRequest(String hostName, String port, String callName, HttpServletRequest request) {

        String problemSegment = request.getHeader("problemSegment");
        String currentSegment = request.getHeader("currentSegment");

        if (problemSegment != null && problemSegment.equals("") == false) {

            int problemSegmentInt = Integer.parseInt(problemSegment);
            int currentSegmentInt = 1;

            if (currentSegment != null && currentSegment.equals("") == false) {
                currentSegmentInt = Integer.parseInt(currentSegment);
            }
            
            if (problemSegmentInt == currentSegmentInt && problemSegmentInt > 0) {

                int delayInt = 50;
                Random rand = new Random();
                delayInt += rand.nextInt(6000);
                BackgroundWorker worker = new BackgroundWorker();
                worker.doBackgroundWork(delayInt);
            }

            return makeWebRequest(hostName, port, callName, problemSegmentInt, currentSegmentInt+1);
        }
        else {
            return makeWebRequest(hostName, port, callName, 0, 0);
        }

    }

    protected String makeWebRequest(String hostName, String port, String callName) {
        return makeWebRequest(hostName, port, callName, 0, 0); 
    }

    protected String makeWebRequest(String hostName, String port, String callName, int problemSegment, int currentSegment) {

        try {
            String url = "http://"+hostName+":"+port+"/"+callName;
            System.out.println("\nSending 'GET' request to URL : " + url);
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            if (problemSegment > 0) {
                con.setRequestProperty("problemSegment", problemSegment+"");
                con.setRequestProperty("currentSegment", currentSegment+"");
            }

            con.setRequestMethod("GET");
            String responseCode = con.getResponseCode()+"";
            
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer responseBuffer = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                responseBuffer.append(inputLine);
            }
            in.close();
            return responseBuffer.toString();
        }
        catch (Exception e) {
            System.out.println("Error from makeWebRequest: " + e.getMessage());
            return "Error from makeWebRequest: " + e.getMessage();
        }
    }

    protected String callMongoDB(String dbName) {

        try {
            
            return "dbName: " + dbName;
        }
        catch (Exception e) {
            System.out.println("Error from makeWebRequest: " + e.getMessage());
            return e.getMessage();
        }
    }

    protected String postWebRequest(String hostName, String port, String callName, String postData) {

        try {
            String url = "http://"+hostName+":"+port+"/"+callName;
            byte[] postDataBytes = postData.getBytes( StandardCharsets.UTF_8 );
            int postDataLength = postDataBytes.length;

            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setDoOutput( true );
            con.setInstanceFollowRedirects( false );
            con.setRequestMethod( "POST" );
            con.setRequestProperty( "Content-Type", "application/json"); 
            con.setRequestProperty( "charset", "utf-8");
            con.setRequestProperty( "Content-Length", Integer.toString( postDataLength ));
            con.setUseCaches( false );
            con.getOutputStream().write(postDataBytes);

            String responseCode = con.getResponseCode()+"";
            System.out.println("Response Code : " + responseCode);
            return con.getResponseMessage();
        }
        catch (Exception e) {
            System.out.println("Error from postWebRequest: " + e.getMessage());
            return "Error from postWebRequest: " + e.getMessage();
        }
    }
}
