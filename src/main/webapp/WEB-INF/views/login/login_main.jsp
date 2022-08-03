<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<link href="${pageContext.request.contextPath}/resources/assets/css/login.css" rel="stylesheet" type="text/css"></link>
</head>
<body>

	<div id="wrap">
		<form name="loginForm">
			<table>
				<tr>
					<td id="result" colspan="2">로 그 인 !</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<!-- 로그인 시 누가 로그인 했는지 알려주기 위해(UserJoinOkAction), 삼항연산자 -->
						<input type="text" name="user_id" placeholder="아이디를 입력하세요"
						value="${param.user_id != null ? param.user_id : ''}">
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="user_pw" placeholder="비밀번호를 입력하세요">
					</td>
				</tr>
				<tr>
					<th colspan="3"><input type="button" name="find_pw" value="비밀번호 찾기" onclick="location.href='${cp}/user/findPw';")></th>
				</tr>
				<tr>
					<th colspan="3"><input type="button" value="로그인" onclick="sendit();"></th>
				</tr>
				<tr>
					<th colspan="3"><input name="joinPage" type="button" value="회원가입" onclick="location.href='${cp}/user/join';"></th>
				</tr>				
			</table>
		</form>
	</div>
</body>
<script>const cp = "${pageContext.request.contextPath}"</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/user_login.js"></script>
</html>







