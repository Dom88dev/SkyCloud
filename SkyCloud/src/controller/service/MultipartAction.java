package controller.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public interface MultipartAction extends Action {

	public String execute(MultipartRequest multi) throws ServletException, IOException;
	
}
