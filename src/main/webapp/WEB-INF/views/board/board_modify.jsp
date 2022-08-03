<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD</title>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="/resources/assets/css/board_all.css">
<style>
	.mdf{
		height:75px; width:100%; resize:none;
	}
</style>
</head>
<body class="is-preload">
	<div id="main">
		<div class="wrapper">
			<div class="inner">
				<header class="major">
					<h1 class="home">Board</h1>
					<p>게시글 수정하기</p>
				</header>
				<a href="${cp}/board/board_list${scri.listLink}" class="button primary small">목록 보기</a>
				<br>
				<br>
				<div class="col-12">
					<form method="post" action="${cp}/board/board_modify" enctype="multipart/form-data">
						<input type="hidden" value="${scri.pagenum}" name="pagenum">
						<input type="hidden" value="${scri.amount}" name="amount">
						<input type="hidden" value="${scri.keyword}" name="keyword">
						<input type="hidden" value="${scri.type}" name="type">
						<div class="col-12">
							<h4>번호</h4>
							<input name="board_num" type="text" value="${board.board_num}" >
						</div>
						<hr>
						<div class="col-12">
							<h4>제목</h4>
							<input name="board_title" type="text" value="${board.board_title}" >
						</div>
						<hr>
						<div class="col-12">
							<h4>내용</h4>
							<textarea name="board_contents" rows="10" style="resize:none;" >${board.board_contents}</textarea>
						</div>
						<hr>
						<!-- 여기에 첨부파일 만들기 -->
						<div>
							<input type="file" name="uploadFile">
						</div>
						<hr>
						<div class="col-12">
							<h4>작성자</h4>
							<input name="board_writer" type="text" value="${board.board_writer}" readonly>
							<input name="user_id" type="hidden" value="${sessionScope.user_id}">
						</div>
						<hr>
						<div class="col-12">
							<input type="submit" value="수정완료" class="primary">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/resources/assets/js/jquery.min.js"></script>
<script src="/resources/assets/js/jquery.dropotron.min.js"></script>
<script src="/resources/assets/js/browser.min.js"></script>
<script src="/resources/assets/js/breakpoints.min.js"></script>
<script src="/resources/assets/js/util.js"></script>
<script src="/resources/assets/js/main.js"></script>
<script src="/resources/assets/js/board_reply.js"></script> <!-- 먼저 reply.js를 걸었기 때문에 이미 만들어져 있다. -->

</html>



<script>
//댓글 보여주기, locatino.reload()가 된 후 댓글을 띄워준다.
$(document).ready(function(){
	let board_num = "${board.board_num}";
	let replies = $(".replies"); // 댓글 넣을 곳
	let page = $(".page"); // 페이징처리
	let pagenum = 1;
	
	
	showList(1);
	
	// 댓글 쭈루룩 보여주기, pagenum 초깃값은 1
	function showList(pagenum){
		
		replyService.getList(
			{"board_num" : board_num, "pagenum" : pagenum || 1}, // data
			function(replyCnt, list){							 // callback
				// 댓글이 없는 경우
				if(list == null || list.length == 0){
					replies.html("<li>댓글이 없습니다.</li>");
					return;
				}
				
				// 댓글이 있는 경우 댓글 리스트 불러와서 보여주기, 게시물처럼!
				let str = "";
				
				for(let i = 0, len = list.length; i < len; i++){
					str += '<li style="clear:both;">';
					str += '<div style="display:inline;float:left;width:80%;">';
/*댓글 작성자*/			str += '<strong class="reply_id'+list[i].reply_num+'">'+list[i].reply_id+'</strong>';
/*댓글 내용*/			str += '<p class="reply'+ list[i].reply_num +'">'+list[i].reply_contents+'</p></div>';
					str += '<div style="text-align:right">';
					str += '<strong>'+replyService.displayTime(list[i])+'</strong><br>';
/* 댓글 수정 */			str += '<a href="'+list[i].reply_num+'" class="modify">수정</a>';
/* 댓글 수정 완료 */		str += '<a href="'+list[i].reply_num+'" class="mfinish" style="display:none;">수정완료</a>&nbsp;&nbsp;';
/* 댓글 삭제 */			str += '<a href="'+list[i].reply_num+'" class="remove">삭제</a></div></li>';
				}
			}
		)
	}
}

</script>








