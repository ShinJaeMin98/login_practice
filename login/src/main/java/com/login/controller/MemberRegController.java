package com.login.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.connector.Response;

import com.login.dao.MemberDao;
import com.login.dto.MemberDto;

@WebServlet("/RegProcess")
public class MemberRegController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * 주소표시줄에서 바로 호출 하는경우, 기본방식으로 요청이 되어지므로
	 * 405 오류가 발생 할 수 있어요
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet() 요청!!!");
		
		// 한글깨짐 처리
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		out.append("post방식으로 요청 해주세요!!!!");
	}
	
	/**
	 * 회원 가입을 진행합니다
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/RegProcess 요청!!!" );
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		// dto 생성
		MemberDto dto = new MemberDto(id, pw, name, "", email);
		System.out.println(dto);
		MemberDao dao = new MemberDao();
		
		// 회원가입
		int res = dao.regMember(dto);
		// 자원반납
		dao.close();
		
		// 메세지 출력 후 페이지 전환 (성공 : 로그인 페이지로 이동, 실패 : 뒤로가기)
		if(res > 0) {
			// 회원가입 성공
			request.setAttribute("msg", "회원가입 성공 😉");
			request.setAttribute("url", "/loginForm.jsp");
		} else {
			// 회원가입 실패 - 컬럼의 사이즈보다 입력값이 큰 경우, 타입이 맞지 않는 경우
			// -> 입력화면에 유효성검증을 추가하여 해결
			request.setAttribute("msg", "회원가입 실패 😢 - 관리자에게 문의해주세요!");
		}
		// forward 방식으로 페이지 전환 - request 영역 공유
		request.getRequestDispatcher("/msgbox.jsp").forward(request, response);
	}

}
