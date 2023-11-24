package com.login.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.login.dao.BoardDao;

/**
 * 1건의 게시글을 삭제합니다. 
 * 
 * 			아래와 같이 썼을 때 사용
 * 			readForm.action='/delete';
			readForm.submit();
 */
@WebServlet("/delete")
public class BoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//파라미터 수집
		// 1건의 게시글을 삭제하기 위해 num을 수집\
		String num = request.getParameter("num");
		
		// DB로부터 게시글 삭제
		BoardDao dao = new BoardDao();
		int res = dao.deleteBoard(num);
		
		if(res == 1) {
			//삭제 성공
			request.setAttribute("msg", "삭제 완료 😉");
			request.setAttribute("url", "/boardList");
		} else {
			//삭제 실패
			request.setAttribute("msg", "삭제 처리 중 예외 발생 \n관리자에게 문의해주세요!");
		}
		
		// 메세지 출력 화면으로 이동
		request.getRequestDispatcher("msgbox.jsp").forward(request, response);
	}

}
