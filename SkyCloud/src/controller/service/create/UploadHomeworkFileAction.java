package controller.service.create;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import controller.service.MultipartAction;
import model.HomeworkFile;
import persistance.HomeworkFileDao;

public class UploadHomeworkFileAction implements MultipartAction {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute(MultipartRequest multi) throws ServletException, IOException {
		HomeworkFile hwf = new HomeworkFile();
		Enumeration<?> fileNames = multi.getFileNames();
		String fName = (String) fileNames.nextElement();
		hwf.setHw_file_name(multi.getOriginalFileName(fName));
		hwf.setHw_file("/upload/" + multi.getFilesystemName(fName));
		hwf.setB_id(Integer.parseInt(multi.getParameter("b_id")));
		hwf.setEmail(multi.getParameter("email"));
		
		HomeworkFileDao hDao = new HomeworkFileDao();
		int result = hDao.uploadHomework(hwf);
		
		
		return "/fwd?command=MOVETOUPLOADHWF&uploadHfileResult="+result+"&b_id="+hwf.getB_id();
	}

}
