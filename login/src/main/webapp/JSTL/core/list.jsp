<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>리스트를 출력 해봅시당</h2>
<table border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	
	<!-- 데이터가 없는 경우 -->
	<c:if test="${empty list} }" var="res">
		<tr>
			<td colspan="5">게시글이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
<c:if test="${not empty list}">
	<c:forEach items="${list}" var="dto">
	<tr>
		<th>${dto.num}</th>
		<th>${dto.title}</th>
		<th>${dto.id}</th>
		<th>${dto.postdate}</th>
		<th>${dto.visitcount}</th>
	</tr>	
	</c:forEach>
</c:if>
	
</table>

${list} 
</body>
</html>