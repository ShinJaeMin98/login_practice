<%@page import="com.login.dto.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/boardList" name="searchForm">
num : <input type="text" name="num" value="${param.num}">
pageNo : <input type="text" name="pageNo" value="${param.pageNo}">
searchWord : <input type="text" name="searchWord" value="${param.searchWord }">
searchField : <input type="text" name="searchField" value="${param.searchField }">
</form>

<script type="text/javascript">

// 문서가 모두 불러들져오면 실행해 달라는 의미로 window.onload 실행
window.onload = function(){
	
	// 버튼을 클릭 하면 리스트 페이지로 이동
	// 화면에 있는 요소를 선택해서 변수에 저장
	let listBtn = document.querySelector("#listBtn");
	// 리스트 버튼이 화면에 존재하면, 이벤트 추가
	if(listBtn != null){
		listBtn.onclick = function(){
			searchForm.submit();
			// 보드로 바로가지 않고 리스트 페이지를 따로 만드는 이유
			// - 리스트를 조회해서 리퀘스트 영역에 저장 후 페이지를 전환해야하기 때문	
		}
	}
	
	// 버튼을 클릭하면 수정
	let editBtn = document.querySelector("#editBtn");
	
	// 버튼을 클릭하면 삭제
	let deleteBtn = document.querySelector("#deleteBtn");
	if(deleteBtn != null) {
		// 삭제 버튼에 이벤트를 추가
		// deleteBtn.addEventListener('click', function(){
		deleteBtn.addEventListener('click', ()=>{
			deleteFnc();
		});			
	}
	
}

	// 게시글을 삭제하는 기능
	function deleteFnc() {
		// 컨펌창 : 확인, 취소 버튼 출력
		// 확인 = true를 반환 / 취소 = false를 반환 - 따라서 if 문장으로 사용할 수 있음
		if(confirm('❗경고❗진심이야? 삭제할거야 진짜?')) {
			alert('확인을 클릭하셨습니다 🙁');
			// 버튼을 클릭하면 삭제 컨트롤러 요청
			// readForm.action='/delete';
			// readForm.submit();		
			location.href= '/deleteProcess.jsp?num=<%=request.getParameter("num")%>';
			/**
			jsp를 단독으로 실행할 경우, 경로문제가 발생하지 않는다 (같은 경로에 들어있기 때문)
			하지만 서블릿을 통해 들어오는 경우, 경로 문제가 발생할 수 았다
			-> 그래서 루트경로부터 풀 경로를 적어주는 것이 오류가 발생하지 않도록 하는 방법이다.
			*/
		} else {
			alert('취소를 클릭하셨습니다 😉')
		}
	}

</script>

<fieldset>
<legend><h2>게시글 상세보기</h2></legend>

<!-- 글의 작성자만 수정, 삭제가 가능하도록
게시글의 id가 로그인한 id와 동일하다면 수정, 삭제 버튼 보여주기
 -->
 <!-- 
 아래 삭제 사용할 때 사용			
 // readForm.action='/delete';			
 // readForm.submit();
 <form method="post" name="readForm">
 	<input type="hidden" name="num" value="<%=request.getParameter("num")%>">
 </form>
  -->
 
<button id="listBtn">리스트로 이동</button>
 
 
<%
if(request.getAttribute("dto") != null){
	BoardDto dto = (BoardDto)request.getAttribute("dto");
	String userId =  "";
	if(session.getAttribute("userId") != null){
		userId = session.getAttribute("userId").toString();
		if(userId.equals(dto.getId())) {
			out.print("<button id='editBtn'>수정</button> &nbsp");
			out.print("<button id='deleteBtn'>삭제</button>");
		}	
	}
%>
	<br>제목 : <%=dto.getTitle() %>
	<br>내용 : <%=dto.getContent() %>
	<br>작성자 : <%=dto.getId() %>
	<br>작성일 : <%=dto.getPostdate() %>
	<br>조회수 : <%=dto.getVisitcount() %><br>
<%} %>


</fieldset>
</body>
</html>