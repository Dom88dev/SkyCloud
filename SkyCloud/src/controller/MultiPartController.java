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

import bean.ApplyDao;
import bean.BoardDao;
import model.BoardFile;
import model.Homework;
import model.Notice;

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
		int maxSize = 50 * 1024 * 1024;
		MultipartRequest multi = null;
		Enumeration<?> fileNames;
		String command = null;
		BoardDao boardDao;
		Notice notice;
		Homework homework;
		BoardFile bf;
		
		// 파일업로드시 multipart타입으로 파라미터를 받아줘야함으로 command가 null일시 파일업로드를 하는
		// 멀티파트리퀘스트로 판단, multi를 이용해서 다시 받아준다.
		if (command == null) {
			if (-1 < request.getContentType().indexOf("multipart/form-data")) {
				multi = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			}
			command = multi.getParameter("command");
		}
		
		switch (command) {
		case "POSTNOTICE":// 공지사항 등록
			notice = new Notice();
			bf = new BoardFile();
			notice.setB_datetime(System.currentTimeMillis());
			notice.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
			notice.setTitle(multi.getParameter("title"));
			notice.setContent(multi.getParameter("content"));
			fileNames = multi.getFileNames();
			int fileNum = 0;
			while (fileNames.hasMoreElements()) {
				String fName = (String) fileNames.nextElement();
				fileNum++;
				if (fName == null || fName.equals(""))
					continue;
				if (fileNum == 1) {
					bf.setB_file1_name(multi.getOriginalFileName(fName));
					bf.setB_file1("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 2) {
					bf.setB_file2_name(multi.getOriginalFileName(fName));
					bf.setB_file2("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 3) {
					bf.setB_file3_name(multi.getOriginalFileName(fName));
					bf.setB_file3("/upload" + multi.getFilesystemName(fName));
				}
			}
			boardDao = new BoardDao();
			int postResult = boardDao.insertNotice(notice);
			if(postResult>0) {
				postResult = boardDao.getB_IdFromNotice(notice);
			}
			postResult = boardDao.insertBoardFile(postResult, bf);
			request.getRequestDispatcher("/main?command=GOMNGSTUDY&postResult="+postResult).forward(request, response);
			break;
		case "POSTHOMEWORK":// 과제 등록
			homework = new Homework();
			bf = new BoardFile();
			homework.setB_datetime(System.currentTimeMillis());
			long addingTimeForDue = Long.parseLong(multi.getParameter("daysToduedate"))
					* (1000l * 60l * 60l * 60l * 24l);
			homework.setDuedate(homework.getB_datetime() + addingTimeForDue);
			homework.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
			homework.setTitle(multi.getParameter("title"));
			homework.setContent(multi.getParameter("content"));
			fileNames = multi.getFileNames();
			fileNum = 0;
			while (fileNames.hasMoreElements()) {
				String fName = (String) fileNames.nextElement();
				fileNum++;
				if (fName == null || fName.equals(""))
					continue;
				if (fileNum == 1) {
					bf.setB_file1_name(multi.getOriginalFileName(fName));
					bf.setB_file1("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 2) {
					bf.setB_file2_name(multi.getOriginalFileName(fName));
					bf.setB_file2("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 3) {
					bf.setB_file3_name(multi.getOriginalFileName(fName));
					bf.setB_file3("/upload" + multi.getFilesystemName(fName));
				}
			}
			boardDao = new BoardDao();
			postResult = boardDao.insertHomework(homework);
			if(postResult>0) {
				postResult = boardDao.getB_IdFromHomework(homework);
			}
			
			postResult = boardDao.insertBoardFile(postResult, bf);
			request.getRequestDispatcher("/main?command=GOMNGSTUDY&postResult="+postResult).forward(request, response);
			break;
		case "UPDATENOTICE":
			notice = new Notice();
			notice.setB_id(Integer.parseInt(multi.getParameter("bId")));
			notice.setContent(multi.getParameter("content"));
			notice.setTitle(multi.getParameter("title"));
			bf = new BoardFile();
			boolean b1 = multi.getParameter("isChangedFile1").equals("true");
			boolean b2 = multi.getParameter("isChangedFile2").equals("true");
			boolean b3 = multi.getParameter("isChangedFile3").equals("true");
			fileNames = multi.getFileNames();
			fileNum = 4;
			while(fileNames.hasMoreElements()) {
				String fName = (String)fileNames.nextElement();
				fileNum--;
				if(fName == null || fName.equals("")) continue;
				if(fileNum==1) {
					if(b1) {
						bf.setB_file1_name(multi.getOriginalFileName(fName));
						bf.setB_file1(multi.getFilesystemName(fName));
					}						
				} else if (fileNum==2) {
					if(b2) {
						bf.setB_file2_name(multi.getOriginalFileName(fName));
						bf.setB_file2(multi.getFilesystemName(fName));
					}
				} else if(fileNum==3) {
					if(b3) {
						bf.setB_file3_name(multi.getOriginalFileName(fName));
						bf.setB_file3(multi.getFilesystemName(fName));
					}
				}
			}
			bf.setB_id(notice.getB_id());
			boardDao = new BoardDao();
			int updateResult = boardDao.updateNotice(notice);
			if(updateResult>0) updateResult = boardDao.updateBoardFile(bf, b1, b2, b3);
			System.out.println("보드파일 수정 결과 : "+updateResult);
			request.getRequestDispatcher("/main?command=GOMNGSTUDY&updateResult="+updateResult).forward(request, response);
			break;
		case "UPDATEHOMEWORK":
			homework = new Homework();
			homework.setB_id(Integer.parseInt(multi.getParameter("bId")));
			homework.setContent(multi.getParameter("content"));
			homework.setTitle(multi.getParameter("title"));
			addingTimeForDue = Long.parseLong(multi.getParameter("daysToduedate")) * (1000l*60l*60l*24l);
			homework.setDuedate(Long.parseLong(multi.getParameter("datetime"))+addingTimeForDue);
			bf = new BoardFile();
			b1 = multi.getParameter("isChangedFile1").equals("true");
			b2 = multi.getParameter("isChangedFile2").equals("true");
			b3 = multi.getParameter("isChangedFile3").equals("true");
			fileNames = multi.getFileNames();
			fileNum = 4;
			while(fileNames.hasMoreElements()) {
				String fName = (String)fileNames.nextElement();
				fileNum--;
				if(fName == null || fName.equals("")) continue;
				if(fileNum==1) {
					if(b1) {
						bf.setB_file1_name(multi.getOriginalFileName(fName));
						bf.setB_file1(multi.getFilesystemName(fName));
					}						
				} else if (fileNum==2) {
					if(b2) {
						bf.setB_file2_name(multi.getOriginalFileName(fName));
						bf.setB_file2(multi.getFilesystemName(fName));
					}
				} else if(fileNum==3) {
					if(b3) {
						bf.setB_file3_name(multi.getOriginalFileName(fName));
						bf.setB_file3(multi.getFilesystemName(fName));
					}
				}
			}
			bf.setB_id(homework.getB_id());
			boardDao = new BoardDao();
			updateResult = boardDao.updateHomework(homework);
			if(updateResult>0) updateResult = boardDao.updateBoardFile(bf, b1, b2, b3);
			request.getRequestDispatcher("/main?command=GOMNGSTUDY&updateResult="+updateResult).forward(request, response);
			break;
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
