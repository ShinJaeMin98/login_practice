 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	window.onload = function() {
		submitBtn.addEventListener('click', function () {
			event.preventDefault();
			console.log('기본 이벤트를 제거하였습니다.');
			
			// 유효성 검사
			res = validateForm(testForm);
			if(res) {
				// 폼 전송
				testForm.submit();
			}
		});
	}
	
	function validateForm(form) {
		// 유효성 검사 validation check
		// 유효성 검사 결과 testForm을 submit
		// 체크로직을 모두 통과했다면 서버에 요청, 체크로직을 통과하지 못했다면 메세지 처리
		if(testForm.kor.value == '') {
			alert('국어 점수를 입력해주세용');
			testForm.kor.focus();
			return false;
		}
		
		console.log(testForm.en.value);
		if(testForm.en.value == '') {
			alert('영어 점수를 입력해주세용');
			testForm.en.focus();
			return false;
		}
		
		if(testForm.math.value == '') {
			alert('수학 점수를 입력해주세용');
			testForm.math.focus();
			return false;
		}
		return true;
	}
</script>

</head>
<body>
<h2>다중 조건문</h2>
<p>홀짝 판별하기</p>
<!-- 변수 선언 -->
<c:set var="num" value="101"></c:set>


<!-- 다중 조건문 사용하기 -->
<c:choose>
	<c:when test="${num%2 eq 0}">
		${num} : 짝수!!
	</c:when>
	<c:otherwise>
		${num} : 홀수!!
	</c:otherwise>
</c:choose>

<h2>국, 영, 수 점수를 입력하면 평균을 내어 학점을 출력</h2>
<p> >= 90 : A학점, >= 80 : B학점, >= 70 : C학점, >= 60 : D학점</p>

<form name="testForm">
국 : <input type="text" name="kor" value="98">
영 : <input type="text" name="en" value="70">
수 : <input type="text" name="math" value="82">
<button id="submitBtn">입력</button>
</form>
<c:if test="${not empty param.kor and not empty param.en and not empty param.math}">
<c:set var="avg" value="${(param.kor + param.en + param.math)/3}" />
<br>${avg}
	<c:choose>
		<c:when test="${avg >= 90}">
			A학점
		</c:when>
		<c:when test="${avg >= 80}">
			B학점
		</c:when>
		<c:when test="${avg >= 70}">
			C학점
		</c:when>
		<c:when test="${avg >= 60}">
			D학점
		</c:when>
		<c:when test="${avg < 60}">
			F학점
		</c:when>
	</c:choose>
</c:if>

<form name="testForm1">
국 : <input type="text" name="kor" value=" ">
영 : <input type="text" name="en" value="70">
수 : <input type="text" name="math" value="82">
	<button onclick="return validateForm(testForm1);">전송</button>
</form>

<form name="testForm2" onsubmit="return validateForm(testForm2);">
국 : <input type="text" name="kor" value=" ">
영 : <input type="text" name="en" value="70">
수 : <input type="text" name="math" value="82">
<button>입려억</button>
</form>

</body>
</html>