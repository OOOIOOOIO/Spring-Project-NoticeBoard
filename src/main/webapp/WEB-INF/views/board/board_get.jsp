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
					<p>게시글 상세보기</p>
				</header>
				<a href="${cp}/board/board_list${scri.listLink}" class="button primary small">목록 보기</a>
				<br>
				<br>
				<div class="col-12">
					<form method="post" action="/board/board_remove">
						<input type="hidden" value="${scri.pagenum}" name="pagenum">
						<input type="hidden" value="${scri.amount}" name="amount">
						<input type="hidden" value="${scri.keyword}" name="keyword">
						<input type="hidden" value="${scri.type}" name="type">
						<div class="col-12">
							<h4>번호</h4>
							<input name="board_num" type="text" value="${board.board_num}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<h4>제목</h4>
							<input name="board_title" type="text" value="${board.board_title}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<h4>내용</h4>
							<textarea name="board_contents" rows="10" style="resize:none;" readonly>${board.board_contents}</textarea>
						</div>
						<hr>
						<!-- 여기에 첨부파일 만들기, 리스트로 뿌려주기 게시물이랑 댓글마냥 -->
						<div>
							<ul class="files"></ul>
							<input type="file" name="uploadFile">
						</div>
						
						<hr>
						<div class="col-12">
							<h4>작성자</h4>
							<input name="board_writer" type="text" value="${board.board_writer}" readonly>
						</div>
						<hr>
						<div class="col-12">
							<input class="modifyBtn" type="button" value="수정" class="primary" onclick="location.href='${cp}/board/board_modify${scri.listLink}&board_num=${board.board_num}'">
							<input class="removeBtn"type="submit" value="삭제" class="primary">
						</div>
					</form>
					<hr>
					<!-- 댓글  -->
					<h3 style="text-align:center;">댓 글</h3>
					<a href="#" class="button primary regist">댓글 등록</a>
					<br>
					<br>
					<!-- style="display:none" -->
					<div class="replyForm row" style="display:none; justify-content: center; ">
						<div style="width:15%;">
							<h4>작성자</h4>
							<input name="reply_id" value="${user_id}" type="text" readonly>						
						</div>
						<div style="width:65%; ">
							<h4>내용</h4>
							<textarea name="reply_contents" rows="2" style="resize:none;" placeholder="Contents"></textarea>
						</div>

						<div style="width:10%; margin-left:1%" class="row">
							<h4 style="margin-bottom:1.3rem !important;">&nbsp;</h4>
							<a href="#" style="margin-bottom:0.7rem;" class="button primary small finish">등록</a>
							<a href="#" class="button primary small cancel">취소</a>
						</div>
					</div>
					<!-- 댓글 띄우는 ul -->
					<ul class="alt replies"></ul>
					<!-- 댓글 페이징 처리할 div -->
					<div class="page" style="text-align:center">
					</div>
				</div>
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
<script src="${cp}/resources/assets/js/reply.js"></script> <!-- 먼저 reply.js를 걸었기 때문에 이미 만들어져 있다. -->
<script>
	
	// 댓글 수정 하나만 되게 확인하기
	let modiCheck = false;
	
	//댓글 등록 보이게 하기
	$(".regist").on("click", function(e){
		e.preventDefault();
		$(".replyForm").show();
		$(this).hide();
	})
	
	
	//취소하기
	$(".cancel").on("click", function(e){
		e.preventDefault();
		$("input[name='reply_id']").val("");
		$("textarea[name='reply_contents']").val("");
		$(".replyForm").hide();
		$(".regist").show();
	})
	
	

	$(".finish").on("click", function(e){ 
		let board_num = "${board.board_num}";
		let reply_id = $("input[name='reply_id']").val();
		let reply_contents = $("textarea[name='reply_contents']").val();
		
		replyService.insert(
			//
			{"board_num" : board_num, "reply_id" : reply_id, "reply_contents" : reply_contents},
			// callback 함수
			function(result){
				alert("댓글 등록 성공~~" + "${user_id}")
			},		
			function(result){
				alert("댓글 등록 실패~~")
			}		
		);
		// 원래는 DOM 써서 내용 바꾸기(Ajax나) but 여기선 그냥 새로고침만 해준단다
		
		// 새로고침을 해주면 $(document).ready에 걸려서 리스트가 띄워진다.
		location.reload();
	})	
	
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
					
					replies.html(str); // 댓글 보여주기
					

					
					showReplyPage(replyCnt); // 댓글 페이징 처리
					
					
					// 로그인 유저와 작성자가 같을 경우에만 "수정", "삭제" 버튼 보여주기
					for(let i = 0, len = list.length; i < len; i++){
						if(list[i].reply_id != "${user_id}"){
							
							$(".modify").css("display", "none");
							$(".remove").css("display", "none");
						}
						
					}
					
					
					// 댓글 삭제
					$(".reomve").on("click", function(e){
						e.preventDefault();
						let reply_num = $(this).attr("href"); // 지금 누른 아이의 속성 중에, 어떤 속성? href에 써져 있는 애(값)
						
						replyService.remove(
								reply_num, // data
								function(result){ // callback, result = ajax에서 받아온 값
									if(result == "success"){
										alert(reply_num + "번 댓글 삭제 완료!");
									}
									
								},
								function(e){ // err
									alert("에러에러!\n" + e)
								}
						);
						
						// DOM으로 댓글 리스트 수정 but 귀찮으니 새로고침
						location.reload();
					})
					
					
					// 댓글 수정
					$(".modify").on("click", function(e){
						e.preventDefault();
						if(!(modiCheck)){
							
							let reply_num = $(this).attr("href");
							let replyTag = $(".reply"+reply_num); // 댓글 내용(reply_contents)가 써져있는 p 태그
							
							// 수정하기 위해서 <p>태그 안에 <textarea>를 넣어준다. .text() : 원래 있던 내용
							// 수정 후 : <p class="reply+reply_num"><textarea class="reply_num">원래 있던 내용</textarea></p>
							// 실제 모습 : <p class="reply3"><textarea class="modi3">원래 있던 내용</textarea></p>
							replyTag.html('<textarea class="modi'+reply_num+'">'+replyTag.text()+'</textarea>');
							
							// 수정 버튼 없애기
							$(this).hide()
							
							// node의 개념을 알자!
							// 현재 클릭한 아이의 다음 요소를 보여줘라!
							$(this).next().show();
							modiCheck = true;
							
						}
						else{
							alert("이미 수정중인 댓글이 있습니다!");
						}
					})
					
					
					// 댓글 수정 완료
					$(".mfinish").on("click", function(e){
						e.preventDefault();
						
						let reply_num = $(this).attr("href");
						let board_num = "${board.board_num}";
						let reply_id = $(".reply_id"+reply_num).text();
						let reply_contents = $(".modi"+reply_num).val();
						
						replyService.update(
							{"reply_num" : reply_num, "reply_contents" : reply_contents, "reply_id" : reply_id, "board_num" : board_num},
							function(result){
								if(result == "success"){
									alert(reply_num+"번 수정 완료!");
								}
							},
							function(e){
								alert(e); 
							}
						);
						location.reload();
					})
				
				}
			)
		}
		
		// 댓글 페이징처리
		function showReplyPage(replyCnt){
			let endPage = Math.ceil(pagenum / 5.0) * 5;
			let startPage = endPage - 4;
			let prevBtn = (startPage != 1);
			let nextBtn = false;
			

			if(endPage * 5 >= replyCnt){
				endPage = Math.ceil(replyCnt / 5);
			}			
			
			if(endPage * 5 < replyCnt){
				nextBtn = true;
			}
			
			
			let str = "";
			
			// mobile
			if(matchMedia("screen and (max-width:918px)").matches){
				if(pagenum > 1){
				str += "<a class='changePage' href='"+ (pagenum-1) +"'><code>&lt;</code></a>";
				}
				str += "<code>"+ pagenum +"</code>";
				if(pagenum != endPage){
					str += "<a class='changePage' href='"+ (pagenum+1) +"'><code>&gt;</code></a>";
				}
			}
			// pc
			else{
				let start = (pagenum != 1);
				let last = (pagenum != Math.ceil(replyCnt / 5));
				
				
				if(start){
					str += "<a class='changePage' href='1'><code>&lt;&lt;</code></a>";
				}
				if(prevBtn){
					str += "<a class='changePage' href='"+ (startPage-1) +"'><code>&lt;</code></a>";
				}
				for(let i = startPage; i <= endPage; i++){
					if(i == pagenum){
						str += "<code>"+i+"</code>";
					}
					else{
						str += "<a class='changePage' href='"+i+"'><code>"+i+"</code></a>"
					}
				}
				if(nextBtn){
					str += "<a class='changePage' href='"+ (endPage+1) +"'><code>&gt;</code></a>";
				}
				if(last){
					str += "<a class='changePage' href='"+ Math.ceil(replyCnt/5) +"'><code>&gt;&gt;</code></a>";
				}
			}
			
			page.html(str); // 페이징 처리
			
			
			// 페이징 처리하고, 댓글 페이지 누르면  이동하는거
			$(".changePage").on("click", function(e){
				e.preventDefault();
				let target = $(this).attr("href");
				pagenum = parseInt(target);
				
				// 댓글 가져오는 향수, 페이지 이동했으니 당연히 댓글 목록 불러와서 보여줘야됨
				showList(pagenum);
			})
			
		}
		
		
	})




</script>
</html>




















