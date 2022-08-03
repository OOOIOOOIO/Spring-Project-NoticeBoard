/**
 *
 * reply 관리 모듈(module)
 */

const replyService = (function(){
	
	// 댓글 등록하기
	function insert(reply, callback, err){
		$.ajax(
				{ // 객체로 담아서 보내준다. {}
					type:"POST",
					url:"/reply/regist", // ReplyController의 /regist로 간다.
					data:JSON.stringify(reply), // JS와 java의 타입은 다르기 때문에 JS에서 JAVA로 보낼 때 JSON으로 변환해 보내준다. pom.xml에 JSON 설정
					contentType:"application/json; charset=utf-8",
					success:function(result, status, xhr){
						if(callback){
							console.log("Ajax regist result : " + result); // result에 success가 떠야하ㅏㄴ??
							//DOM 써서 내용 바꾸기
							callback(result);
						}
					},
					error:function(xhr, status, e){
						if(err){
							err(e);
						}
					}
				}
			)
		}
	
	
	//댓글 쭈루루룩 보여주기
	function getList(data, callback, err){
		let board_num = data.board_num;
		let pagenum = data.pagenum;
		
		// url의 json 파일 가져오기
		$.getJSON( 
			"/reply/pages/"+board_num+"/"+pagenum+".json", // 통신할 url(통신할 곳이 json 데이터를 리턴해주므로 .json을 붙인다.) 
			// url에서 데이터 가져오는 것을  성공할 경우, 
			function(data){ // url에서 가져오는 data(service에서 board든 reply든 mapper를 사용하고 로직을 만들어 넘겨주어야 한다!
				if(callback){
					callback(data.replyCnt, data.list);
				}
			}
		).fail( // 실패할 경우
			function(xhr, status, e){
				if(err){
					err(e);
				}
			}
		)
	}
	
	
	// 댓글 삭제하기
	// REST 방식 : url 그 자체!!!
	function remove(reply_num, callback, err){
		$.ajax(
				{	// data가 없는 이유는 url에 reply_num을 넘겨주었기 때문에 여기선 딱히 무언가를 보내지 않아도 됨
					type:"DELETE",
					url:"/reply/"+reply_num,
					success:function(result, status, xhr){
						if(callback){
							callback(result);
						}
					},
					error:function(e, status, xhr){
						err(e);
					}
					
				}
 		)
		
	}
	
	
	// 댓글 수정하기
	function update(reply, callback, err){
		$.ajax(
				{
					type:"PUT",
					url:"/reply/"+reply.reply_num,
					data:JSON.stringify(reply),
					contentType:"application/json; charset=utf-8",
					success:function(result, status, xhr){
						if(callback){
							callback(result);
						}
					},
					error:function(status, xhr, e){
						if(err){
							alert(e)
						}
					}
					
					
					
					
				}
		)
	}
	
	
	
	// 댓글 수정 시간 알려주기
	function fmtTime(reply){
		let now = new Date(); // 현재 시간
		let regi_date = reply.regi_date; // 등록 시간
		let update_date = reply.update_date; // 수정 시간
		let check = regi_date == update_date; // 수정 여부(F : 수정)
		let dateObj = new Date(check ? regi_date : update_date); // 등록 or 수정 시간
		let gap = now.getTime() - dateObj.getTime(); // 데이트객체.getTime() : 시간 정보를 밀리초로 변환
		
		let str = "";
		// 1000밀리 * 60(초) * 60(분) * 24(시간) = 하루
		if(gap < 1000 * 60 * 60 * 24){
			let hh = dateObj.getHours();
			let mi =  dateObj.getMinutes();
			let ss = dateObj.getSeconds();
			
			// 01:01:01 이런 식으로 출력하기 위해
			str = (hh > 9 ? '' : '0')+hh + ":" + (mi > 9 ? '' : '0') + mi + ":" + (ss > 9 ? '' : '0') + ss;
		}
		else{
			let yy = dateObj.getFullYear();
			let mm = dateObj.getMonth() + 1; // (1월 : 0, 2월 : 1, ...)
			let dd = dateObj.getDate();
			
			str = yy + "/" + (mm > 9 ? '' : '0') + mm + "/" + (dd > 9 ? '' : '0') + dd;
		}
		return(check ? '' : '(수정됨)') + str;
	}	
	
	
	
	return {"insert" : insert, "getList" : getList, "remove" : remove, "update" : update, "get" : "", "displayTime" : fmtTime};
//	return {"insert" : insert, "getList" : getList, "displayTime" : fmtTime};
})();





