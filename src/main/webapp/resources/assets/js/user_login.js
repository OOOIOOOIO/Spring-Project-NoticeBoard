
let user_id = document.loginForm.user_id;
let user_pw = document.loginForm.user_pw;
let loginForm = document.loginForm

// 로그인
function sendit(){
	
	if(user_id.value == ""){
		alert("아이디를 입력하세요!");
	}
	else if(user_pw.value == ""){
		alert("비밀번호를 입력하세요!");
	}
	else{
		
		$.ajax(
			{
				type:"POST",
				url:"/user/checkLogin",
				data:JSON.stringify({"user_id" : user_id.value, "user_pw" : user_pw.value}),
				dataType:"json",
				contentType:"application/json; charset:utf-8",
				success:function(result){
					if(result > 0){
						alert("로그인에 성공하였습니다!")
						loginForm.action = "/board/board_list";
						loginForm.method = "POST";
						loginForm.submit();
					}
					else{
						alert("로그인 정보를 확인해주세요!")
					}
				},
				error:function(error){
					alert("에러에러!!")
				}
			}
		)
	}	
}

// pw 찾기
function find_pw(){
	
}