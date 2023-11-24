<%@page import="com.book.lib.dto.BookDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl의 core태그를 사용하기 위해 태그라이브러리 지시자를 추가 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<style type="text/css">
	.pointer {
		cursor : pointer;
	}
	
</style>
<script type="text/javascript">
/*
 * 스크립트에서 함수를 정의하는 방법
	function 함수명(파람0, 파람1,,,) {
		
	}
	
	함수의 호출
	함수명(파람0, 파람1,,,);
 */

 function msg(str){
	 alert(str);
 }
 
 function view(no) {
	 location.href = "/Book/View?no=" + no;
 }

</script>
</head>
<body>
<!-- header 외부파일 인클루드 -->
<%@include file="common/header.jsp"%>

 <!-- Main Content -->
            <div id="content">


                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Position</th>
                                            <th>Office</th>
                                            <th>Age</th>
                                            <th>Start date</th>
                                            <th>Salary</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>Name</th>
                                            <th>Position</th>
                                            <th>Office</th>
                                            <th>Age</th>
                                            <th>Start date</th>
                                            <th>Salary</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <tr>
                                            <td>Tiger Nixon</td>
                                            <td>System Architect</td>
                                            <td>Edinburgh</td>
                                            <td>61</td>
                                            <td>2011/04/25</td>
                                            <td>$320,800</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->














<!-- 도서목록을 출력합니다. -->
<h3>도서 목록</h3>

<form name="searchForm" action="/Book/List">
pageNo : <input type="text" name="pageNo" value="${pageDto.cri.pageNo }">
num : <input type="text" name="num" value="">
amount : <input name="amount" value="">
<div class="input-group">
  <select class="form-select" name="searchField" id="inputGroupSelect04" aria-label="Example select with button addon">
	<!-- 선택된 요소의 value 값이 서버로 넘어간다. -->
			<option value="title"
				${pageDto.cri.searchField eq 'title' ? 'selected' : ''} 
			>도서명</option>
			<option value="author"
				${pageDto.cri.searchField eq 'author' ? 'selected' : ''} 
			>작가</option>
  </select>
  <input type="text" name="searchWord" value="${pageDto.cri.searchWord }" class="form-control" aria-label="Text input with segmented dropdown button">
  <button class="btn btn-outline-secondary" type="submit">검색</button>
</div>

</form>

<table class="table table-hover table-sm , text-center">
	<thead class="table-light">
	<tr>
		<th>도서 번호</th>
		<th>도서명</th>
		<th>작가</th>
		<th>대여 여부</th>
	</tr>
	</thead>
	
	<tbody>
<c:if test="${empty list }" var="res">
	<!-- 리스트가 비어있다면 메세지 출력 -->
	<tr>
		<td colspan="4">도서목록이 존재하지 않습니다.</td>
	</tr>
</c:if>

<!-- 리스트가 비어있지 않다면 도서목록 출력 -->
<c:if test="${not res }">
<c:forEach items="${list }" var="dto">
	<tr>
		<td>${dto.no }</td>
		<td class="pointer" onclick="view(${dto.no})">${dto.title }</td>
		<td>${dto.author }</td>
		<td>${dto.rentYnStr }</td>
	</tr>
</c:forEach>	
</c:if>

</table>

<!-- pageNavi -->
<!-- pageDto가 request 영역에 저장되어있으면 페이지 블럭을 출력하낟. -->
<%@include file="/lib/pageNavi.jsp" %>

<%@include file="common/footer.jsp"%>

<!-- 부트스트랩 js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>