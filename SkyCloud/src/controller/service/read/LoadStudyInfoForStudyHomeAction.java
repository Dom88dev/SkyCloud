package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import controller.service.Action;
import model.Homework;
import model.Member;
import model.Notice;
import persistance.ApplyDao;
import persistance.BoardDao;
import persistance.MemberDao;

//매니저 스터디홈 화면 선택시
public class LoadStudyInfoForStudyHomeAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		MemberDao memDao = new MemberDao();
		Member mem = memDao.getMemberByEmail(req.getParameter("leaderEmail"));
		JsonObject jobj = new JsonObject();
		jobj.add("leader", new Gson().toJsonTree(mem));
		BoardDao boardDao = new BoardDao();
		int stdId = Integer.parseInt(req.getParameter("stdId"));
		ArrayList<Notice> nList = (ArrayList<Notice>) boardDao.getNoticeList(stdId);
		ArrayList<Homework> hList = (ArrayList<Homework>) boardDao.getHomeworkList(stdId);
		JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(nList, new TypeToken<List<Notice>>() {
		}.getType());
		JsonArray jarrayHList = (JsonArray) new Gson().toJsonTree(hList, new TypeToken<List<Homework>>() {
		}.getType());
		jobj.add("noticeList", jarrayNList);
		jobj.add("homeworkList", jarrayHList);
		ApplyDao apDao = new ApplyDao();
		jobj.addProperty("currentMemNum", apDao.getCurrentMembersNum(stdId));
		String jsonData = new Gson().toJson(jobj);
		return jsonData;
	}

}
