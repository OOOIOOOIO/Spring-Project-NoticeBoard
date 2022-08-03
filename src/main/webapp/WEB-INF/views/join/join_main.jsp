<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<link href="${pageContext.request.contextPath}/resources/assets/css/join.css" rel="stylesheet" type="text/css"></link>
</head>
<body>

	<form name="joinForm" >
		<table style="margin : 0 auto;">
			<tr>
				<td id="result" colspan="2">회 원 가 입 !</td>
				</tr>			
			<tr>
				<td id="checkId" colspan="2"></td>
			</tr>			
			<tr>
				<th><label for="user_id">아이디</label></th>
				<td><input type="text" name="user_id" id="user_id"><input type="button" value="중복검사" onclick="check_id()"></td>
			</tr>
			<tr>
				<th><label for="user_pw">비밀번호</label></th>
				<td><input type="password" name="user_pw" id="user_pw" placeholder="비밀번호는 8자 이상, 숫자, 대문자, 소문자, 특수문자를 모두 포함해야 합니다!"><input type="button" value="확인" onclick="check_pw()"></td>
			</tr>

			<tr>
				<th><label for="user_name">이름</label></th>
				<td><input type="text" name="user_name" id="user_name"></td>
			</tr>
<!-- 			<tr class="gender_area">
				<th>성별</th>
				<td>
					<label>남자 <input checked type="radio" name="usergender" value="M"></label>
					<label>여자 <input type="radio" name="usergender" value="W"></label>
				</td>
			</tr> -->
			<tr>
				<th><label for="user_phone">핸드폰 번호</label></th>
				<td><input type="text" name="user_phone" id="user_phone" placeholder="010xxxxxxx"><input type="button" onclick="check_phone()" value="인증하기"></td>
			</tr>
			<tr>
				<th><label for="user_email">이메일</label></th>
				<td><input type="text" name="user_email" id="user_email" placeholder="sample@sample.com"><input type="button" onclick="check_email()" value="인증하기"></td>
			</tr>						
			<tr class="zipcode_area">
				<th>우편번호</th>
				<td>
					<input readonly name="zipcode" type="text" id="sample6_postcode" placeholder="우편번호"><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
				</td>
			</tr>
			<tr class="addr_area">
				<th>주소</th>
				<td><input readonly name="addr" type="text" id="sample6_address" placeholder="주소"></td>
			</tr>
			<tr>
				<th>상세주소</th>
				<td><input name="addr_detail" type="text" id="sample6_detailAddress" placeholder="상세주소"></td>
			</tr>
			<tr>
				<th>참고항목</th>
				<td><input name="addr_ete" type="text" id="sample6_extraAddress" placeholder="참고항목"></td>
			</tr>
<!-- 			<tr class="hobby_area">
				<th>취미</th>
				<td>
					<div>
						<div>
							<label><input type="checkbox" name="userhobby" value="게임"> 게임하기</label>
						</div>
						<div>
							<label><input type="checkbox" name="userhobby" value="그림"> 그림그리기</label>
						</div>
						<div>
							<label><input type="checkbox" name="userhobby" value="영화"> 영화보기</label><br>
						</div>
						<div>
							<label><input type="checkbox" name="userhobby" value="운동"> 운동하기</label>
						</div>
						<div>
							<label><input type="checkbox" name="userhobby" value="노래"> 노래부르기</label>
						</div>
						<div>
							<label><input type="checkbox" name="userhobby" value="코딩"> 코딩하기</label>
						</div>
					</div>
				</td>
			</tr> -->
			<tr>
				<th colspan="2">
					<input id="joinBtn" type="button" value="가입 완료" onclick="sendit();">
				</th>
			</tr>
		</table>
	</form>
</body>

<!-- 서블렛에서는 해줘야됨. 왜? 새로 보여주는 거니까. 루트경로 설정해주기 -->
<script>const cp = "${pageContext.request.contextPath}"</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/user_join.js"></script>
</html>

