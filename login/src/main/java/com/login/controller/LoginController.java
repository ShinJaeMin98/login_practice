 package com.login.controller;

import java.io.IOException;   
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.login.dao.BoardDao;
import com.login.dao.MemberDao;
import com.login.dto.MemberDto;

// @WebServlet 경로와 form의 action 경로와 일치시켜야 됨.
@WebServlet("/loginProcess")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
/**
* controller 역할
* 	- 파라미터 수집
* 	- 페이지 전환 (jsp로 요청을 위임)
* 
* 사용자의 로그인 요청을 처리
* 1. 파라미터 수집(id, pw)
* 2. DB로부터 해당 사용자가 있는지 확인
* 	2 - (1) 사용자가 존재하면 로그인 처리 (세션에 사용자 정보 저장을 의미)
* 	2 -	(2) 사용자가 존재하지 않으면 이전 페이지로 넘어가 오류메세지 출력
*/
	protected void doPost(HttpServletRequest request
							, HttpServletResponse response)
									throws ServletException, IOException {
		// 1. 파라미터 수집 (id, pw)
		String id = request.getParameter("user_id");
		String pw = request.getParameter("user_pw");
		
		// 2. DB로부터 해당 사용자가 있는지 확인 
		// - MemberDao를 이용한 사용자 인증
		MemberDao dao = new MemberDao();
		MemberDto dto = dao.login(id, pw);
		dao.close();
		
		// 페이지 전환
		// 2 - (1) 사용자가 존재하면 로그인 처리 (세션에 사용자 정보 저장을 의미)
		// 2 - (2) 사용자가 존재하지 않으면 이전 페이지로 넘어가 오류메세지 출력
		if(dto != null) {
			// 로그인 성공
			// 3. session 영역에  memberDto 저장
			// - servlet에서 세션을 사용하기 위해 request로부터 꺼내온다.
			HttpSession session = request.getSession();
			
			// 세션의 만료기간이 남아있고 웹브라우저를 닫을 때까지 세션 정보가 서버에 유지
			session.setAttribute("memberDto", dto);
			session.setAttribute("userId", dto.getId());
			session.setAttribute("userName", dto.getName());	
	
			// 성공 시 보드(메인) 페이지 전환
			//request.getRequestDispatcher("/boardList").forward(request, response);
			response.sendRedirect("/boardList");
		
		} else {
			// 로그인 실패
			// 실패 시 로그인 폼 페이지 전환 및 에러 발생
			request.getRequestDispatcher("loginForm.jsp?isError=1").forward(request, response);	
			// response.getWriter().append("<script>alert('아이디 / 비밀번호를 확인해주세요😅')</script>");
		}
	}
}
