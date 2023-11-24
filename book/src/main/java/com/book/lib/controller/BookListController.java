package com.book.lib.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.lib.dao.BookDao;
import com.book.lib.dto.BookDto;
import com.book.lib.dto.Criteria;
import com.book.lib.dto.PageDto;

@WebServlet("/Book/List")
public class BookListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 도서 목록을 조회 후 request 영역에 저장한다.
	 * booklist.jsp로 forward 합니다.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Criteria cri = new Criteria(request.getParameter("pageNo")
									,request.getParameter("amount")
									,request.getParameter("searchField")
									,request.getParameter("searchWord"));
		
		// 도서목록 조회 후 request 영역에 담아준다 -> 화면에 출력하기 위해
		BookDao dao = new BookDao();
		List<BookDto> list = dao.getList(cri);
		request.setAttribute("list", list);
		
		// 페이지 블럭 출력을 위한 pageDto의 request 영역 저장
		PageDto pageDto = new PageDto(dao.getTotalCnt(cri), cri);
		request.setAttribute("pageDto", pageDto);
		
		dao.close();
		
		// JSP화면으로 전환
		request.getRequestDispatcher("/lib/bookList.jsp").forward(request, response);
		
	}


}
