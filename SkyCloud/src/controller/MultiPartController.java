package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controller.service.Action;
import controller.service.ActionFactory;
import controller.service.MultipartAction;
import model.BoardFile;
import model.Homework;
import model.Notice;
import persistance.ApplyDao;
import persistance.BoardDao;

/**
 * Servlet implementation class MultiPartController
 */
@WebServlet("/MultiPartController")
public class MultiPartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String path = getServletContext().getRealPath("upload");
		//System.out.println(path);
		int maxSize = 50 * 1024 * 1024;
		MultipartRequest multi = null;
		String command = null;
		
		// 파일업로드시 multipart타입으로 파라미터를 받아줘야함으로 command가 null일시 파일업로드를 하는
		// 멀티파트리퀘스트로 판단, multi를 이용해서 다시 받아준다.
		if (command == null) {
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
				multi = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			}
			command = multi.getParameter("command");
		}
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		if(action instanceof MultipartAction) {
			MultipartAction multiAction = (MultipartAction)action;
			request.getRequestDispatcher(multiAction.execute(multi)).forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
