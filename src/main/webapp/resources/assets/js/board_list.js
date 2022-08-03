var searchForm = $("#searchForm");
var pageForm = $("#pageForm");


// 검색하기
$("#searchForm a").on("click", function(e){
	
	if(!(searchForm.find("input[name='keyword']").val())){  // js는 if()안에가 공백일 경우 false가 들어간다.
		alert("검색어를 입력해주세요");
		return false;
	}
	
	if(!(searchForm.find("option:selected").val())){
		alert("검색 기준을 선택해주세요")
		return false;
	}
	
	searchForm.find("input[name='pagenum']").val("1");
	searchForm.submit();
	
})


// 페이지 번호 눌러서 이동하기
$(".changePage").on("click", function(e){
	
	e.preventDefault();
	
	pageForm.find("input[name='pagenum']").val($(this).attr("href"))
	pageForm.submit();
})


// 글을 regist 한 후 다시 list로 넘어올 때 알려주기. bn : board_num
bn = "${bn}";
$(document).ready(
		function(){
			if(bn =="" || history.state) return;
			
			if(parseInt(bn) > 0){
				alert(bn + "번 게시글이 등록되었습니다.");
				history.replaceState({}, null, null);
			}
		}
)

$(".get").on("click", function(e){
	
	e.preventDefault();
	
})

// 제목 눌러서 이동하기, boardnum을 같이 넘겨주어야 하기 때문에 아래와 같이 만들어준다.
$(".get").on("click", function(e){
	
	e.preventDefault();
	pageForm.append("<input type='hidden' name='board_num' value='"+$(this).attr("href")+"'>"); // this의 href값
	pageForm.attr("action", "/board/board_get");
	pageForm.submit();
	
	
})


// 글을 수정 한 후 다시 list로 넘어올 때 알려주기. bn : board_num
mbn = "${mbn}";
$(document).ready(
		function(){
			if(mbn =="" || history.state) return;
			
			if(parseInt(bn) > 0){
				alert(bn + "번 게시글이 수정되었습니다.");
				history.replaceState({}, null, null);
			}
		}
)






















