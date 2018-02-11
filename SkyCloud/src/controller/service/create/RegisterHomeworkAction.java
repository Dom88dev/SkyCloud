package controller.service.create;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import controller.service.MultipartAction;
import model.BoardFile;
import model.Homework;
import persistance.BoardDao;

//과제 등록
public class RegisterHomeworkAction implements MultipartAction {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute(MultipartRequest multi) throws ServletException, IOException {
		Homework homework = new Homework();
		BoardFile bf = new BoardFile();
		homework.setB_datetime(System.currentTimeMillis());
		long addingTimeForDue = Long.parseLong(multi.getParameter("daysToduedate"))
				* (1000l * 60l * 60l * 60l * 24l);
		homework.setDuedate(homework.getB_datetime() + addingTimeForDue);
		homework.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
		homework.setTitle(multi.getParameter("title"));
		homework.setContent(multi.getParameter("content"));
		Enumeration<?> fileNames = multi.getFileNames();
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
		BoardDao boardDao = new BoardDao();
		int postResult = boardDao.insertHomework(homework);
		if(postResult>0) {
			postResult = boardDao.getB_IdFromHomework(homework);
		}
		
		postResult = boardDao.insertBoardFile(postResult, bf);
		return "/main?command=GOMNGSTUDY&postResult="+postResult;
	}

}
