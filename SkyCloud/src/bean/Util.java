package bean;

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
		int tpCnt=0;
		for(int i=0; i<timePlaceList.size();i++) {
			StudyTimePlace tp = timePlaceList.get(i);
			if(i==0) {
				tpList.add(tp);
				order.put(tp.getStd_day(), true);
			} else {
				if(tp.getStd_addr().equals(timePlaceList.get(tpCnt).getStd_addr()) && 
				tp.getStd_time().equals(timePlaceList.get(tpCnt).getStd_time()) && 
				tp.getStd_hour() == timePlaceList.get(tpCnt).getStd_hour()) {
					order.put(tp.getStd_day(), true);
				} else {
					tpList.add(tp);
					tpCnt = i;
					dayOrderList.add(order);
					order = new HashMap<>();
					order.put(tp.getStd_day(), true);
				}
			}
		}
		if(dayOrderList.size()+1 == tpList.size()) {
			dayOrderList.add(order);
		}
		for(int i=0; i<dayOrderList.size();i++) {
			HashMap<String, Boolean> m = dayOrderList.get(i);
				if(m.containsKey("월")) {
					days = "월";
				}
				if(m.containsKey("화")) {
					days+="/화";
				}
				if(m.containsKey("수")) {
					days+="/수";
				}
				if(m.containsKey("목")) {
					days+="/목";
				}
				if(m.containsKey("금")) {
					days+="/금";
				}
				if(m.containsKey("토")) {
					days+="/토";
				}
				if(m.containsKey("일")) {
					days+="/일";
				}
				daysList.add(days);
		}
		for(int i=0;i<daysList.size();i++) {
			tpList.get(i).setStd_day(daysList.get(i));
		}
		return tpList;
	}
}
