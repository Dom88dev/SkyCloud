package util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

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
		ArrayList<String> daysList = new ArrayList<>();
		ArrayList<StudyTimePlace> timePlaceList = (ArrayList<StudyTimePlace>) s.getTimePlaceList();
		ArrayList<StudyTimePlace> tpList = new ArrayList<>();
		ArrayList<HashMap<String, Boolean>> dayOrderList = new ArrayList<>();
		HashMap<String, Boolean> order = new HashMap<>();
		
		for(int i=0; i<timePlaceList.size();i++) {
			StudyTimePlace tp = timePlaceList.get(i);
			String stdDays = tp.getStd_day();
			
			dayOrderList = new ArrayList<>();
			for(int j=0;j<7;j++) {
				order = new HashMap<>();
				order.put(String.valueOf(i), false);
				dayOrderList.add(order);
			}
			
			for(int j=0; j<stdDays.length();j++) {
				switch(stdDays.charAt(j)) {
				case '월':
					dayOrderList.get(0).replace("0", true);
					break;
				case '화':
					dayOrderList.get(1).replace("1", true);
					break;
				case '수':
					dayOrderList.get(2).replace("2", true);
					break;
				case '목':
					dayOrderList.get(3).replace("3", true);
					break;
				case '금':
					dayOrderList.get(4).replace("4", true);
					break;
				case '토':
					dayOrderList.get(5).replace("5", true);
					break;
				case '일':
					dayOrderList.get(6).replace("6", true);
					break;
				}
			}
			
			days = "";
			for(int j=0; j<dayOrderList.size();j++) {
				HashMap<String, Boolean> m = dayOrderList.get(j);
				if(m.get(String.valueOf(j))) {
					if(m.containsKey("0")) {
						days = "월";
					}
					if(m.containsKey("1")) {
						if(days.isEmpty()) days = "화";
						else days+=" / 화";
					}
					if(m.containsKey("2")) {
						if(days.isEmpty()) days = "수";
						else days+=" / 수";
					}
					if(m.containsKey("3")) {
						if(days.isEmpty()) days = "목";
						else days+=" / 목";
					}
					if(m.containsKey("4")) {
						if(days.isEmpty()) days = "금";
						else days+=" / 금";
					}
					if(m.containsKey("5")) {
						if(days.isEmpty()) days = "토";
						else days+=" / 토";
					}
					if(m.containsKey("6")) {
						if(days.isEmpty()) days = "일";
						else days+=" / 일";
					}
				}
			}
			daysList.add(days);
		}
		
		for(int i=0;i<daysList.size();i++) {
			timePlaceList.get(i).setStd_day(daysList.get(i));
		}
		return timePlaceList;
	}
}
