<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD</title>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${cp}/resources/assets/css/board_all.css">
</head>
<body> 
	<div id="main">
		<div class="wrapper">
			<div class="inner">
				<header class="major">
					<h1 class="home">Board</h1>
					<p>게시판 등록</p>
				</header>
				<a href="${cp}/board/board_list${cri.listLink}" class="button primary small">목록 보기</a>
				<br>
				<br>
				<div class="col-12">
					<form method="post" action="/board/board_regist" enctype="multipart/form-data">
						<div class="col-12">
							<h4>제목</h4>
							<input name="board_title" type="text" placeholder="Title">
						</div>
						<hr>
						<div class="col-12">
							<h4>내용</h4>
							<textarea name="board_contents" placeholder="Contents" rows="10" style="resize:none;"></textarea>
						</div>
						<hr>
						<!-- 여기에 첨부파일 만들기 -->
						<div class="col-12">
							<input type="file" name="uploadFile" multiple="multiple"> <!-- 파일 여러개 올릴 수 있음  -->
						</div>
						<hr>
						<div class="col-12">
							<h4>작성자</h4>
							<input name="board_writer" type="text" value="${sessionScope.user_id}" readonly>
							<input name="user_id" type="hidden" value="${sessionScope.user_id}">
						</div>
						<hr>
						<div class="col-12">
							<input type="submit" value="등록" class="primary">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>