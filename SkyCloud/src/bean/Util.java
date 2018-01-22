package bean;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
}
