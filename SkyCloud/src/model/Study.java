package model;

import java.sql.Date;
import java.util.List;

public class Study {
	private int std_id;
	private String std_name;
	private int std_max;
	private Date std_start;
	private Date std_end;
	private String std_info;
	private String std_plan;
	private String std_etc;
	private String std_gender;
	private String std_category;
	private String email;
	private List<StudyTimePlace> timePlaceList;
	
	public void setStudy(int stdId, String stdName, int stdMax, Date stdStart, Date stdEnd, String stdInfo, String stdPlan, String stdEtc, String stdGender, String stdCate, String email){
		setStd_id(stdId);
		setStd_name(stdName);
		setStd_max(stdMax);
		setStd_start(stdStart);
		setStd_end(stdEnd);
		setStd_info(stdInfo);
		setStd_plan(stdPlan);
		setStd_etc(stdEtc);
		setStd_gender(stdGender);
		setStd_category(stdCate);
		setEmail(email);
	}
	
	public void setStudy(String stdName, int stdMax, Date stdStart, Date stdEnd, String stdInfo, String stdPlan, String stdEtc, String stdGender, String stdCate, String email){
		setStd_name(stdName);
		setStd_max(stdMax);
		setStd_start(stdStart);
		setStd_end(stdEnd);
		setStd_info(stdInfo);
		setStd_plan(stdPlan);
		setStd_etc(stdEtc);
		setStd_gender(stdGender);
		setStd_category(stdCate);
		setEmail(email);
	}
	
	public int getStd_id() {
		return std_id;
	}
	public void setStd_id(int std_id) {
		this.std_id = std_id;
	}
	public String getStd_name() {
		return std_name;
	}
	public void setStd_name(String std_name) {
		this.std_name = std_name;
	}
	public int getStd_max() {
		return std_max;
	}
	public void setStd_max(int std_max) {
		this.std_max = std_max;
	}
	public Date getStd_start() {
		return std_start;
	}
	public void setStd_start(Date std_start) {
		this.std_start = std_start;
	}
	public Date getStd_end() {
		return std_end;
	}
	public void setStd_end(Date std_end) {
		this.std_end = std_end;
	}
	public String getStd_info() {
		return std_info;
	}
	public void setStd_info(String std_info) {
		this.std_info = std_info;
	}
	public String getStd_plan() {
		return std_plan;
	}
	public void setStd_plan(String std_plan) {
		this.std_plan = std_plan;
	}
	public String getStd_etc() {
		return std_etc;
	}
	public void setStd_etc(String std_etc) {
		this.std_etc = std_etc;
	}
	public String getStd_gender() {
		return std_gender;
	}
	public void setStd_gender(String std_gender) {
		this.std_gender = std_gender;
	}
	public String getStd_category() {
		return std_category;
	}
	public void setStd_category(String std_category) {
		this.std_category = std_category;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public List<StudyTimePlace> getTimePlaceList() {
		return timePlaceList;
	}

	public void setTimePlaceList(List<StudyTimePlace> timePlaceList) {
		this.timePlaceList = timePlaceList;
	}
	
}
