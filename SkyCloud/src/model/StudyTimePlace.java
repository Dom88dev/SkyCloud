package model;

public class StudyTimePlace {
	private String std_time; //HHmm형태로 저장
	private int std_hour;	 //스터디를 하는 시간 ex) 스터디 끝나는 시간 = (Integer.parseInt(std_time.subString(0,2)) + std_hour)+std_time.subString(2); 
	private String std_addr; //스터디 장소 주소
	private String std_day;	 //스터디 요일(월/화/수/목/금/토/일)
	private int std_id;	 //스터디 아이디
	
	public void setStudyTimePlace(int std_id, String std_time, int std_hour, String std_addr, String std_day) {
		setStd_id(std_id);
		setStd_time(std_time);
		setStd_hour(std_hour);
		setStd_addr(std_addr);
		setStd_day(std_day);
	}
	
	public String getStd_time() {
		return std_time;
	}
	public void setStd_time(String std_time) {
		this.std_time = std_time;
	}
	public int getStd_hour() {
		return std_hour;
	}
	public void setStd_hour(int std_hour) {
		this.std_hour = std_hour;
	}
	public String getStd_addr() {
		return std_addr;
	}
	public void setStd_addr(String std_addr) {
		this.std_addr = std_addr;
	}
	public String getStd_day() {
		return std_day;
	}
	public void setStd_day(String std_day) {
		this.std_day = std_day;
	}
	public int getStd_id() {
		return std_id;
	}
	public void setStd_id(int std_id) {
		this.std_id = std_id;
	}
}
