package com.login.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.dao.BoardDao;
import com.login.dto.BoardDto;
import com.login.dto.Criteria;
import com.login.dto.PageDto;

@WebServlet("/boardList")
public class BoardListController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		// 리스트를 조회하기 위한 파라미터 수집
		// 페이지 번호와 페이지당 게시물수를 설정후 
		// 조회할 게시물의 시작번호와 끝번호를 알아냅니다.

		Criteria cri = new Criteria(request.getParameter("pageNo")
									, request.getParameter("amount")
									, request.getParameter("searchWord")
									, request.getParameter("searchField"));

		System.out.println(cri);
		// 리스트 조회후 리퀘스트 영역에 저장
				BoardDao dao = new BoardDao();
				List<BoardDto> list = dao.getList(cri);
				request.setAttribute("list", list);
				
				// 페이지 블럭을 생성하기 위해 필요한 정보 저장
				// cri : 요청 페이지 번호, 페이지 당 게시물의 수
				// totalCnt : 총 게시물의 수
				
				// 조회조건을 세팅하지 않으면 조회되는 게시글의 건수와 페이지 블럭이 다르게 표시 될 수 있다.
				int totalCnt = dao.getTotalCnt(cri);
				
				// 페이지블럭을 생성하기위해 PageDto를 생성 합니다.
				PageDto pageDto =new PageDto(totalCnt, cri);
				request.setAttribute("pageDto", pageDto);
				
				dao.close();
				
		
		// 페이지 전환 
		// forward방식으로 전환 하므로 request영역이 공유됨
		request.getRequestDispatcher("/board.jsp").forward(request, response);
		
	}
}
