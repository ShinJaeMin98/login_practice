<%@page import="com.book.lib.dto.PageDto"%>
<%@page import="com.book.lib.dto.Criteria"%>
<%@page import="com.book.lib.dto.PageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
/**
 * 입력받은 페이지 번호로 이동 합니다.
 */
function goPage(pageNo){
	// 파라메터로 넘어온 페이지 번호를 searchForm에 pageNo에 입력
	searchForm.pageNo.value = pageNo;
	searchForm.submit();
}



</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 CSS -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

</head>
<body>
<br>
<!-- 
페이지 블럭을 출력하는 방법
	1. 요청 컨트롤러에서 pageDto를 request영역에 저장해주기
	2. pageNavi.jsp를 include해주기
		- 리스트 페이지의 페이지 블럭을 출력하고 싶은 위치에!!
	3. searchForm을 생성
		- pageNo요소가 있어야 함
 -->


<!-- 페이지 네이션 -->
<nav aria-label="...">
  <ul class="pagination justify-content-center">
  
  <!-- 앞으로 가기 버튼 disabled : 비활성화 -->
    <li class='page-item  ${pageDto.prev ? "" : "disabled"}'>
    	<a class="page-link" onclick="goPage(${pageDto.startNo - 1})">Previous</a>
    </li>

	<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
	<li class="page-item">
    <!-- href="..." 링크로 이동할 경우, 검색어가 유지되지 않는다 -->
    <!-- 검색어를 유지하기 위해 searchForm을 전송하는 goPage함수를 생성
    	- 링크를 함수호출로 변경 onClick이벤트가 발생하면 goPage()함수를 호출한다.
    	- 함수의 파라미터로 페이지 번호를 넣어줘야 한다.
     -->
    	<a class="page-link  ${pageDto.cri.pageNo eq i ? 'active' : ''}"
    								 onclick="goPage(${i})">${i}</a>
    </li>
	</c:forEach>

    
    <!-- 뒤로 가기 버튼 시작 -->
    <li class='page-item ${pageDto.next ? "" : "disabled"}'>
    	<a class="page-link" onclick="goPage(${pageDto.endNo + 1})">Next</a>
    </li>
    <!-- 뒤로 가기 버튼 끝 -->
  </ul>
</nav>

<!-- 부트스트랩 JS -->
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>