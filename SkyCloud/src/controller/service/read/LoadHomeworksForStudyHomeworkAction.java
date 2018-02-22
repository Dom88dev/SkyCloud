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
import model.HomeworkFile;
import persistance.BoardDao;
import persistance.HomeworkFileDao;
import persistance.MemberDao;

//매니저 과제화면 선택시
public class LoadHomeworksForStudyHomeworkAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		JsonObject jobj = new JsonObject();
		BoardDao boardDao = new BoardDao();
		int stdId = Integer.parseInt(req.getParameter("stdId"));
		ArrayList<Homework> hList = (ArrayList<Homework>) boardDao.getHomeworkList(stdId);
		JsonArray jarrayHList = (JsonArray) new Gson().toJsonTree(hList, new TypeToken<List<Homework>>() {
		}.getType());
		
		ArrayList<ArrayList<HomeworkFile>> hfList = new ArrayList<>();
		for(int i=0;i<hList.size();i++) {
			Homework h = hList.get(i);
			HomeworkFileDao hfDao = new HomeworkFileDao();
			ArrayList<HomeworkFile> hfiles = (ArrayList<HomeworkFile>) hfDao.getHFiles(h.getB_id());
			for(HomeworkFile hf : hfiles) {
				MemberDao mDao = new MemberDao();
				hf.setName(mDao.getMemberByEmail(hf.getEmail()).getName());
			}
			hfList.add(hfiles);
		}
		JsonArray jarrayHFList = (JsonArray) new Gson().toJsonTree(hfList, new TypeToken<List<List<HomeworkFile>>>() {
		}.getType());
		
		
		jobj.add("homeworkList", jarrayHList);
		jobj.add("homeworkFilesList", jarrayHFList);
		jobj.addProperty("currentPage", 0);
		String jsonData = new Gson().toJson(jobj);
		return jsonData;
	}

}
