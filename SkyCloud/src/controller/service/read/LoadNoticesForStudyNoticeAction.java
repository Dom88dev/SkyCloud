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
import model.Notice;
import persistance.BoardDao;

//매니저 공지사항 화면 선택시
public class LoadNoticesForStudyNoticeAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		JsonObject jobj = new JsonObject();
		BoardDao boardDao = new BoardDao();
		int stdId = Integer.parseInt(req.getParameter("stdId"));
		ArrayList<Notice> nList = (ArrayList<Notice>) boardDao.getNoticeList(stdId);
		JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(nList, new TypeToken<List<Notice>>() {
		}.getType());
		jobj.add("noticeList", jarrayNList);
		jobj.addProperty("currentPage", 0);
		String jsonData = new Gson().toJson(jobj);
		return jsonData;
	}

}
