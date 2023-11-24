package com.book.lib.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.lib.dao.BookDao;
import com.book.lib.dto.BookDto;

@WebServlet("/Book/View")
public class BookViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 도서 정보 조회 후 request영역에 저장
		BookDao dao = new BookDao();
		BookDto dto = dao.view(request.getParameter("no"));
		request.setAttribute("bookDto", dto);
		
		// 자원 반납
		dao.close();
		
		request.getRequestDispatcher("/lib/bookview.jsp").forward(request, response);
		
	}


}
