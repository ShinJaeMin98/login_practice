<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
get방식 : queryString을 이용해 데이터를 전달 (주소 이용)
post방식 : body영역을 통해 데이터를 전달
 -->

<!-- 기본틀 입력 (예시) -->
<form action="loginProcess" method="post" name="loginFrm" onsubmit="return validateForm(this);">       	
	<fieldset>
        <legend><h2>로그인 정보</h2></legend>
       		아이디 : <input type="text" name="user_id" required="required" value="test"/>
        	패스워드 : <input type="password" name="user_pw" required="required" value="1234"/>
        	<input type="submit" value="로그인하기" />
	</fieldset>
</form>
</body>
</html>