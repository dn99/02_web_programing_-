// controller 처리

var root = "/BNCRent/";

function mi_getBoardType(){
	document.location.href=root + "comctrl?act=boardtype";
}

function mi_writeArticle(){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("제목을 입력하세요..");
		return
	}else if(alice.getContent() == ""){
		alert("내용을 입력하세요..");
		return
	}else{
		f.content.value = alice.getContent();
		f.action = root + "comctrl";
		f.submit();
	}
}

function mi_goWrite(){
	var f = document.searchForm;
	f.act.value = "mvnew";
	f.action = root + "comctrl";
	f.submit();
}

function mi_goList(pg){
	var f = document.searchForm;
	f.act.value = "list";
	f.pg.value = pg;
	f.action = root + "comctrl";
	f.submit();
}

function mi_goView(num){
	var f = document.searchForm;
	f.act.value = "view";
	f.seq.value = num;
	f.action = root + "comctrl";
	f.submit();
}

function mi_goModify(num){
	var f = document.bbsForm;
	f.act.value = "mvmodify";
	f.seq.value = num;
	f.action = root + "comctrl";
	f.submit();
}

function mi_goDelete(num){
	var f = document.bbsForm;
	f.act.value = "delete";
	f.seq.value = num;
	if(confirm("정말 삭제하시겠습니까?")){
	f.action = root + "comctrl";
	f.submit();
	}
}

function mi_modiArticle(num){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("제목을 입력하세요..");
		return
	}else if(alice.getContent() == ""){
		alert("내용을 입력하세요..");
		return
	}else{
		if(confirm("정말 수정하시겠습니까?")){
		f.act.value = "modify";
		f.content.value = alice.getContent();
		f.seq.value = num;
		f.action = root + "comctrl";
		f.submit();
		}
	}
}

function mi_check_reply(num, pg){
	 var f = document.searchForm;
	 f.act.value = "mvreply";
	 f.seq.value = num;
	 f.pg.value = pg;
	 f.action = root + "comctrl";
	 f.submit();
}

//function mi_goBbsSearch(pg){
//	var f = document.searchForm;
//		f.pg.value = pg;
//		
//	 if (f.item.value == ""){
//		  alert("검색하고자 하는 항목을 선택해 주세요.");
//		  document.searchForm.item.focus();
//		  return;
//		 }
//	 
//	 if (f.item.value == "subject" && document.searchForm.query.value.length < 2) {
//		  alert("검색하실 단어을 다시 입력해 주세요.\n단어는 한글2자,영문4자 이상을 입력해 주셔야 검색이 가능합니다.");
//		  return;
//		 }
//
//		 if (f.item.value == "writer" && document.searchForm.query.value.length < 1) {
//		  alert("검색하실 닉네임을 다시 입력해 주세요.\n닉네임은 한글1자,영문2자 이상을 입력해 주셔야 검색이 가능합니다.");
//		  return;
//		 }
//
//		 else if((f.item.value == "no") && (isNaN(document.searchForm.query.value) == true)){
//		  alert("검색하실 글번호를 다시 입력해 주세요.\n글 번호는 숫자 입력만이 가능합니다.");
//		  return;
//		 }
//		 
//
//		 f.act.value = "list";
//		 f.action = root + "comctrl";
//		 f.submit();
//	
//}

function mi_goMyList(id, pg){
	var f = document.searchForm;
	f.act.value = "list";
	f.myid.value = id;
	f.pg.value = pg;
	f.action = root + "comctrl";
	f.submit();
}



