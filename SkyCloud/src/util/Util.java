package util;

import java.io.File;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import model.Study;
import model.StudyTimePlace;

public class Util {
	public static Date transDate(String strDate){
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date parsed = format.parse(strDate);
			return new java.sql.Date(parsed.getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       return null;
	}
	
	public static ArrayList<StudyTimePlace> getOrderedDays(Study s) {
		String days = "";
		ArrayList<StudyTimePlace> timePlaceList = (ArrayList<StudyTimePlace>) s.getTimePlaceList();
		ArrayList<StudyTimePlace> tpList = new ArrayList<>();
		
		for(int i=0; i<timePlaceList.size();i++) {
			StudyTimePlace tp = timePlaceList.get(i);
			String stdDays = tp.getStd_day();
			
			days = "";
			for(int j=0; j<stdDays.length();j++) {
				if(j==0) {
					days = String.valueOf(stdDays.charAt(j));
				} else {
					days += " / " + String.valueOf(stdDays.charAt(j));
				}
			}
			tp.setStd_day(days);
			tpList.add(tp);
		}
		return tpList;
	}
	
	public static void removeFile(String realName) {
		String path = "C:/DEVELOPMENT/job_train/jsp/jspWorkspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp3/wtpwebapps/StudyCloud";
		File file = new File(path+realName);
		if(file.exists()) file.delete();
	}
}
