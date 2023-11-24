<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RegisterPage</title>

    <!-- Custom fonts for this template-->
    <link href="../vendor/fontawesome-free/../css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../css/sb-admin-2.min.css" rel="stylesheet">
    
    <script>
    window.onload = function() {
    	console.log('onload event 발생');
    	
    	// 변수 선언
    	// var - 변수의 중복선언 가능
    	// let - 지역변수, 중복선언 불가능
    	// const - 지역상수, 중복선언 불가능
    	let regBtn = document.querySelector("#regBtn");
    	
    	// 익명의 함수를 작성 할 수도 있고, 이미 작성된 함수의 이름을 넘겨줄 수도 있다.
    	// 함수의 이름을 넣어줄때는 함수이름 뒤에 ()를 붙이면 안된다.
    	// 함수이름() : 함수를 실행하라는 의미	
    	regBtn.addEventListener('click', validationCheck);
    	
    	/* regBtn.addEventListener('click', function(){
    		console.log('회원가입 버튼이 클릭되었습니다.')
    		// 회원가입 유효성 검사
    		
    		// 등록 요청
    		regForm.action = "/RegProcess"; // 요청 url을 설정
    		regForm.method = "post";
    		// - 폼을 전송 -> 새로운 페이지를 요청
    		regForm.submit(); 	
    	}); */
    }
    
    function validationCheck() {
    	if(id.value == "") {
    		alert("❗아이디를 입력해주세요❗");
    		id.focus();
    		return false;
    	}
    	if(id.value.length > 10) {
    		alert('아이디는 10자 이내로 입력해주세요 👻');
    		id.focus();
    		return false;
    	}
    	
    	let name = document.querySelector("#name");
    	if(name.value == "") {
    		alert("❗이름을 입력해주세요❗");
    		name.focus();
    		return false;
    	}
    	if(name.value.length > 15) {
    		alert("이름은 15자 이내로 입력해주세요 👻");
    		name.focus();
    	}
    	
    	
    	if(email.value == "") {
    		alert("❗이메일을 입력해주세요❗");
    		email.focus();
    		return false;
    	}
    	if(email.value.length > 100) {
    		alert("이메일은 100자 이내로 입력해주세요 👻");
    		email.focus();
    	}  	
    	// 정규식 패턴 문자열을 생성
    	let email_reg = /^[\w\.-]+@[a-zA-Z\d\.-]+\.[a-zA-Z]{2,}$/;
    	// 패턴형식과 일치하는지 확인
    	if(!email_reg.test(email.value)) {
    		alert("이메일 형식이 일치하지 않습니다 👻");
    		email.focus();
    		return false;
    	}
    	
    	if(pw.value == "") {
    		alert("❗비밀번호를 입력해주세요❗");
    		pw.focus();
    		return false;
    	}
    	if(pw.value.length > 10) {
    		alert("비밀번호는 10자 이내로 입력해주세요 👻");
    		pw.focus();
    		return false;
    	}
    	
    	
    	if(pwCheck.value == "") {
    		alert("❗비밀번호를 확인해주세요❗");
    		pwCheck.focus();
    		return false;
    	}
    	
    	if(pw.value != pwCheck.value) {
    		alert("❗비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요❗");
    		pwCheck.focus();
    		return false;
    	}
    	
    	// 등록 요청
		regForm.action = "/RegProcess"; // 요청 url을 설정
		regForm.method = "post";
		// - 폼을 전송 -> 새로운 페이지를 요청
		regForm.submit();
    }
    
    // 바이트 수 구하는 식
    function getByteLength(str) {
  	  // TextEncoder 객체 생성 (UTF-8 사용) : 한글 3byte로 계산됨
  	  var encoder = new TextEncoder('utf-8');
  	  // 문자열을 바이트 배열로 인코딩
  	  var encoded = encoder.encode(str);
  	  // 바이트 배열의 길이 반환
  	  return encoded.length;
  	} 
    
    </script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
                            </div>
                            <form name="regForm" class="user">
                                <div class="form-group">
                                        <input type="text" class="form-control form-control-user"
                                        	id="id" name="id" placeholder="ID">
                                </div>
                                <div class="form-group">
                                        <input type="text" class="form-control form-control-user"
                                        	id="name" name="name" placeholder="NAME">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="email"
                                        name="email" placeholder="EMAIL">
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pw" name="pw" placeholder="PASSWORD">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="pwCheck" placeholder="REPEAT PASSWORD">
                                    </div>
                                </div>
                                <a id="regBtn" class="btn btn-primary btn-user btn-block">
                                	회원가입
                                </a>
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="/loginForm.jsp">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/bootstrap/../js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="../vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="../js/sb-admin-2.min.js"></script>

</body>

</html>