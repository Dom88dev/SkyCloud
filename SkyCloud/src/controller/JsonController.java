package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controller.service.Action;
import controller.service.ActionFactory;
import model.Attendance;
import model.BoardFile;
import model.Homework;
import model.Member;
import model.Notice;
import model.Study;
import persistance.ApplyDao;
import persistance.AttendanceDao;
import persistance.BoardDao;
import persistance.MemberDao;
import persistance.StudyDao;

/**
 * Servlet implementation class JsonController
 */
@WebServlet("/JsonController")
public class JsonController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		String command = request.getParameter("command");
		
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>) stdDao.getStduyList();
		request.setAttribute("stdList", stdList);
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		out.print(action.execute(request, response));
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
