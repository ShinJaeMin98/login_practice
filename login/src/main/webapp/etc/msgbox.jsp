<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 메세지 출력 후 다른 페이지를 요청 하거나 뒤로가기 한다. -->
<script type="text/javascript">
	alert('<%=request.getAttribute("msg")%>');
	// 만약 url에 값이 있다면 url요청
	let url = <%=request.getAttribute("url")%>
	if(url != '') {
		// url 이동
		location.href = url;
	} else {
		//뒤로 가기	
		history.back();
	}
</script>
</body>
</html>