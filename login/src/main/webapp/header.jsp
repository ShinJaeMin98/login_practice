<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#logo>nav>ul>li {
		float : left; /* 가로로 출력하기 위해 float 속성을 사용 */
		width : 20%;
		height : 30px;
		list-style : none;
	}
	
	.floatClear{
		clear : both;
	}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header id="logo">
<nav>
	<ul>
		<li>Home</li>
		<li>Board</li>
		<li>Contact</li>
		<li>Map</li>
		<li>
			<!-- 로그인 / 로그아웃 링크 보여주기
			- 세션에 userId가 null이 아니라면 로그아웃 링크, 아니면 로그인 링크를 보여주자! -->
			
			<form method="get" name="loginForm">
			<c:if test="${empty userId}">
				<button id="loginBtn">로그인</button>
			</c:if>
			
			<c:if test="${not empty userId}">
				${userName}님 방문을 환영합니다😁
				<button id="logoutBtn">로그아웃</button>
			</c:if>
			</form>
		</li>
	</ul>
</nav>
</header>
<hr>


</body>
</html>