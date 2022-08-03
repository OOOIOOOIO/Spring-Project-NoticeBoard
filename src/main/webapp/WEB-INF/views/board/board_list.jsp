<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>프로젝트 공유 페이지</title>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${cp}/resources/assets/css/board_all.css">
<style>
	td, th{
		text-align: center !important;
		vertical-align: middle !important;
	}
	.small-width{
		display:none;
	}
	.big-width{
	
	}
	select{
		width:15%;
		display:inline;
	}
	#keyword{
		display:inline;
		width:55%;
	}
	@media(max-width : 918px){
		select[name='type']{
			width:80%;
		}
		#keyword{
			width:80%;
		}
		.fa-search{
			width:80%;		
		}
		.big-width{
			display:none;
		}
		.small-width{
			display:block;
		}
	}
</style>
</head>
<body>
 	<!-- 로그인 후 사용하게 하기 -->
 	<c:if test="${user_id == null}">
		<script>
			alert("로그인 후 이용하세요!");
			location.replace("${cp}/user/login");
		</script>
	</c:if> 
	<div id="main" class="main">
		<div class="wrapper">
<%-- 			<div style="text-align:right">
				<a href="${cp}/user/logout" style="color:white">로그아웃</a>
			</div> --%>
			
			<div class="inner">
				<header class="major">
					<h1 class="home">프로젝트 공유 보드</h1>
					<p>보드 목록</p>
				</header>
				<div style="text-align:right">
					<a href="${cp}/user/logout" class="button primary small" >로그아웃</a>
				</div>
					<!--  
						마찬가지로 getter를 찾기 때문에 이렇게 쓴다. el문{}, 마이바티스
					cri.getListLink() : ?pagenum=4&amount=10...  
						a 태그는 get 방식
					-->
				<a href="${cp}/board/board_regist${pageInfo.scri.listLink}" class="button primary small">등록하기</a>
				<div class="table_wrapper"> <!-- 목록 보여주는 곳 -->
					<table>
						<thead>
							<tr>
								<th style="width:8%">번호</th>
								<th style="width:40%">제목</th>
								<th style="width:16%">작성자</th>
								<th style="width:18%" class="big-width">작성일</th>
								<th style="width:18%" class="big-width">수정일</th>
							</tr>
						</thead>
						<tbody>
							<!-- 목록을 다 받아와야한다, if, for문을 통해 가져옴   -->
							<c:choose>
								<c:when test="${boardList != null and boardList.size() > 0}">
									<c:forEach var="boardList" items="${boardList}">
										<tr>
											<td>${boardList.board_num}</td>
											<td><a class="get" href="${boardList.board_num}">${boardList.board_title}</a></td>
											<td>${boardList.board_writer}</td>
											<td class="big-width">${boardList.regi_date}</td>
											<td   class="big-width">${boardList.update_date}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="big-width">작성된 게시글이 없습니다.</td>
										<td colspan="3" class="small-width">작성된 게시글이 없습니다. </td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
						
					</table>
				</div>
				<!-- 검색하기이이이ㅣ이 -->
				<form id="searchFrom" action="${cp}/board/board_list" method="get" > 
					<div class="col-12" style="text-align:center;">
						<select name ="type"> <!-- 검색 기준 선택, 페이지 이동하고 검색 기준 남겨주기  -->
							<option value="">검색</option>
							<option value="T" ${pageInfo.scri.type == "T" ? "selected" : ""}>제목</option>
							<option value="C" ${pageInfo.scri.type == "C" ? "selected" : ""}>내용</option>
							<option value="W" ${pageInfo.scri.type == "W" ? "selected" : ""}>작성자</option>
							<option value="TC" ${pageInfo.scri.type == "TC" ? "selected" : ""}>제목 또는 내용</option>
							<option value="TW" ${pageInfo.scri.type == "TW" ? "selected" : ""}>제목 또는 작성자</option>
							<option value="TCW" ${pageInfo.scri.type == "TCW" ? "selected" : ""}>제목 또는 내용 또는 작성자</option>
						</select>
						<input type="text" id="keyword" name="keyword" value="${pageInfo.scri.keyword}">
						<a href="여기 어디로 이동하지?" class="button primary icon solid fa-search">검색</a> <!-- keyword 입력 -->
					</div>
					<input type="hidden" name="pagenum" value="${pageInfo.scri.pagenum}">
					<input type="hidden" name="amount" value="${pageInfo.scri.amount}">
				</form>				
				 <!-- 몇 페이지인지 보여주기 -->
				 
				 <!-- 피씨 -->
				 <div style="text-align: center" class="big-width">
				 	<c:if test="${pageInfo.prevBtn}">
				 		<a class="changePage" href="${pageInfo.startPage-1}"><code>&lt;</code></a>
				 	</c:if>
				 	<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="i">
				 		<c:choose>
				 			<c:when test="${pageInfo.scri.pagenum == i}">
				 				<code>${i}</code>
				 			</c:when>
				 			<c:otherwise>
				 				<a class="changePage" href="${i}"><code>${i}</code></a>
				 			</c:otherwise>
				 		</c:choose>
				 	</c:forEach>
				 	<c:if test="${pageInfo.nextBtn}">
						<a class="changePage" href="${pageInfo.endPage+1}"><code>&gt;</code></a>
					</c:if>
				</div>
				
				<!-- 모바일 -->
				 <div style="text-align: center" class="small-width">
				 	<c:if test="${pageInfo.scri.pagenum > 1}">
				 		<a class="changePage" href="${pageInfo.scri.pagenum -1}"><code>&lt;</code></a>
				 	</c:if>
				 	<code>${pageInfo.scri.pagenum}</code>
				 	<c:if test="${pageInfo.scri.pagenum < pageInfo.realEndPage}">
						<a class="changePage" href="${pageInfo.scri.pagenum+1}"><code>&gt;</code></a>
					</c:if>
				</div>
				
				<!-- 페이지 번호 눌러서 이동할 때 페이지 정보를 같이 넘겨주기 위한 form -->
				<form id="pageForm" action="${cp}/board/board_list" method="get">
					<input type="hidden" name="pagenum" value="${pageInfo.scri.pagenum}">
					<input type="hidden" name="amount" value="${pageInfo.scri.amount}">
					<input type="hidden" name="type" value="${pageInfo.scri.type}">
					<input type="hidden" name="keyword" value="${pageInfo.scri.keyword}">
				</form>
			</div>
		</div>
	</div>
</body>
<script>const cp="${pageContext.request.contextPath}"</script>
<script src="${cp}/resources/assets/js/jquery.min.js"></script>
<script src="${cp}/resources/assets/js/jquery.dropotron.min.js"></script>
<script src="${cp}/resources/assets/js/browser.min.js"></script>
<script src="${cp}/resources/assets/js/breakpoints.min.js"></script>
<script src="${cp}/resources/assets/js/util.js"></script>
<script src="${cp}/resources/assets/js/main.js"></script>
<script src="${cp}/resources/assets/js/board_list.js"></script>
</html>
