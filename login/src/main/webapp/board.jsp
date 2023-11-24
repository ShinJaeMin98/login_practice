<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@page import="com.login.dto.Criteria"%>
<%@page import="com.login.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#pageNav {
	text-align : center;
}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>

<script type="text/javascript">
// 화면에서 동적인 처리
window.onload = function() {
	
	let loginBtn = document.querySelector("#loginBtn");
	let logoutBtn = document.querySelector("#logoutBtn");
	
	// 방법 1 적용
	if(logoutBtn != null) {
		// 로그아웃 → 로그인 페이지로 이동 
		logoutBtn.onclick = function() {
			loginForm.action = "/logout";
			loginForm.submit();
		}
	}
	
	// 방법 2 적용
	if(loginBtn != null) {
		loginBtn.addEventListener('click', function(){
			// 로그인 페이지 이동
			loginForm.action = "/loginForm.jsp";
			loginForm.submit();
		});
	}
	
	// select 요소의 옵션을 선택하는 방법
	var searchField = '${pageDto.cri.searchField }';
	console.log("searchField : ", searchField);
	
	var options = searchForm.searchField.options;
	
	// select 요소의 옵션의 selected 속성을 제거
	for(let i = 0; i < options.length; i++) {
		options[i].removeAttribute("selected");
	}
	
	// select 요소의 옵션의 selected 속성을 부여
	for(var i = 0; i< options.length; i++) {
		console.log(options[i].value);
		if(options[i].value == searchField) {
			options[i].setAttribute("selected", "selected");
		}
	}
}
/** submit : form의 요소들을 파라미터로 가지고 서버에 요청
  	action : 서버에 요청할 url 주소
 	method : 요청 방식
 		get : 조회용 파라미터
 		
 */
 
 // 함수는 onload 함수 외부에 작성합니다.
 /**
 * 입력받은 페이지 번호로 이동합니다.
 */
 function goPage(pageNo) {
 			// 파라미터로 넘어온 페이지 번호를 searchForm에 pageNo 입력
 			searchForm.action = '/boardList'
 			searchForm.pageNo.value = pageNo;
 			searchForm.submit();	
 		}
 		
 /**
 상세 페이지로 이동하기
 */ 
 function goDetail(num) {
	 /**
	 /boardRead?num=${dto.num }
		*/
	 searchForm.action = "/boardRead";
	 searchForm.num.value = num;
	 searchForm.submit();
 }
 
 /**
 폼을 전송(요청)합니다
 */
 function formSubmit() {
	 // 1. 폼을 선택 - 폼의 이름을 불러줍니다.
	 // 2. 폼의 요소를 선택 - 폼, 요소의 이름
	 searchForm.pageNo.value = '페이지 번호'
	 
	 // 3. 폼 전송하기 
	 // - form의 action속성에 정의된 url을 요청한다.
	 //	- 폼 안에 요소들을 파라미터로 전달 
	 searchForm.submit();
 }
 
</script>

<%@include file="header.jsp" %>
<h2>게시글 목록</h2>	
<table width="90%" align="center">
	<tr>
		<td>
	
<!-- 검색폼
pageDto : ${pageDto }
<br>cri : ${pageDto.cri }
<br>pageNo : ${pageDto.cri.pageNo }
<br>searchWord : ${pageDto.cri.searchWord }
<br>searchField : ${pageDto.cri.searchField }
 -->

<form name="searchForm">
pageNo : <input type="text" name="pageNo" value="${pageDto.cri.pageNo }">
num : <input type="text" name="num" value="">
<div class="input-group">
  <select class="form-select" name="searchField" id="inputGroupSelect04" aria-label="Example select with button addon">
	<!-- 선택된 요소의 value 값이 서버로 넘어간다. -->
			<option value="title"
				${pageDto.cri.searchField eq 'title' ? 'selected' : ''} 
			>제목</option>
			<option value="id"
				${pageDto.cri.searchField eq 'id' ? 'selected' : ''} 
			>작성자</option>
			<option value="content"
				${pageDto.cri.searchField eq 'content' ? 'selected' : ''} 
			>내용</option>
  </select>
  <input type="text" name="searchWord" value="${pageDto.cri.searchWord }" class="form-control" aria-label="Text input with segmented dropdown button">
  <button class="btn btn-outline-secondary" type="submit">검색</button>
</div>

</form>

<hr class="border border-danger border-2 opacity-50">
<table class="table table-hover table-sm , text-center">
<thead class="table-light">
	<tr>
		<th>일련번호</th>
		<th>제목</th>
		<th>내용</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
</thead>

<!-- 만약 리스트의 사이즈가 0이라면 조회된 데이터가 없습니다를 출력 -->
<!-- 만약 리스트의 사이즈가 0이 아니라면 목록을 출력 -->
	<c:if test="${empty list}" var="result">
		<tr><td colspan="6">조회된 데이터가 존재하지 않습니다.</td></tr>
	</c:if>
	
	<c:forEach items="${list }" var="dto">
		<tr>
			<td>${dto.num }</td>
			<td><a onclick="goDetail(${dto.num })">${dto.title }</a></td>
			<td>${dto.content }</td>
			<td>${dto.id }</td>
			<td>${dto.postdate }</td>
			<td>${dto.visitcount }</td>
		
		</tr>
	</c:forEach>

</table>
 <hr class="border border-danger border-2 opacity-50">
 
<!-- pageNavi indclude -->
<%@include file="pageNavi.jsp"%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
	
			</td>
	</tr>
</table>
</body>
</html>