// controller 처리

var root = "/BNCRent/";

//controller 처리


function mi_getBoardType_cus(){
	document.location.href=root + "cusctrl?act=boardtype";
}

function mi_writeArticle_cus(){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("제목을 입력하세요..");
		return
	}else if(alice.getContent() == ""){
		alert("내용을 입력하세요..");
		return
	}else{
		f.content.value = alice.getContent();
		f.action = root + "cusctrl";
		f.submit();
	}
}

function mi_goWrite_cus(){
	var f = document.searchForm;
	f.act.value = "mvnew";
	f.action = root + "cusctrl";
	f.submit();
}

function mi_goList_cus(pg){
	var f = document.searchForm;
	f.act.value = "list";
	f.pg.value = pg;
	f.action = root + "cusctrl";
	f.submit();
}

function mi_goView_cus(num){
	var f = document.searchForm;
	f.act.value = "view";
	f.seq.value = num;
	f.action = root + "cusctrl";
	f.submit();
}

function mi_goModify_cus(num){
	var f = document.bbsForm;
	f.act.value = "mvmodify";
	f.seq.value = num;
	f.action = root + "cusctrl";
	f.submit();
}

function mi_goDelete_cus(num){
	var f = document.bbsForm;
	f.act.value = "delete";
	f.seq.value = num;
	if(confirm("정말 삭제하시겠습니까?")){
	f.action = root + "cusctrl";
	f.submit();
	}
}

function mi_modiArticle_cus(num){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("제목을 입력하세요..");
		return
	}else if(alice.getContent().value == ""){
		alert("내용을 입력하세요..");
		return
	}else{
		if(confirm("정말 수정하시겠습니까?")){
		f.act.value = "modify";
		f.content.value = alice.getContent();
		f.seq.value = num;
		f.action = root + "cusctrl";
		f.submit();
		}
	}
}

function mi_check_reply_cus(num, pg){
	 var f = document.searchForm;
	 f.act.value = "mvreply";
	 f.seq.value = num;
	 f.pg.value = pg;
	 f.action = root + "cusctrl";
	 f.submit();
}

//function mi_goBbsSearch_cus(pg){
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
//		 f.action = root + "cusctrl";
//		 f.submit();
//	
//}

function mi_goMyList_cus(id, pg){
	var f = document.searchForm;
	f.act.value = "list";
	f.myid.value = id;
	f.pg.value = pg;
	f.action = root + "cusctrl";
	f.submit();
}



OneDepth = "6";  TwoDepth = "2";   ThreeDepth ="2";


function mailqnaSave(){
	
	var fs = document.mailqna;
	
	if(!checkFrm(fs.subject, "제목", "", 2, 100)) return;

	if(!checkFrm(fs.mkname, "성명", "", 2, 15)) return;
	
	if(!checkFrm(fs.email, "이메일", "$email$", 5, 40)) return;

	if( ( fs.nhandp1.value=="" || fs.nhandp2.value=="" || fs.nhandp3.value=="" )&& ( fs.ntelno1.value=="" || fs.ntelno2.value=="" || fs.ntelno3.value=="" ) ){
			alert("연락처 최소 1개 이상은 입력해주시기 바랍니다.");
			return;		
	}

	if(!checkFrm(fs.nhandp1, "휴대폰", "$number$", 0, 4)) return;		
	if(!checkFrm(fs.nhandp2, "휴대폰", "$number$", 0, 4)) return;
	if(!checkFrm(fs.nhandp3, "휴대폰", "$number$", 0, 4)) return;

	if(!checkFrm(fs.ntelno1, "전화번호", "$number$", 0, 4)) return;
	if(!checkFrm(fs.ntelno2, "전화번호", "$number$", 0, 4)) return;
	if(!checkFrm(fs.ntelno3, "전화번호", "$number$", 0, 4)) return;		

	if( !checkRadio( fs.cgubun ) ){
		alert("서비스 종류를 선택하세요");
		fs.cgubun[0].focus();
		return;
	}

	if(!checkFrm(fs.mdescx, "내용", "", 10, 2000)) return;
	
	fs.submit();
	
	document.getElementById("submit1").style.display = "none";
	document.getElementById("submit2").style.display = "";
}

function sendMessage() {
	alert('메일을 보내고 있습니다.\n확인 버튼을 누르시고, 잠시만 기다려주세요.');
	return;
}

function onlyNumber(){
	if ((event.keyCode<48)||(event.keyCode>57))
	{
		event.returnValue = false;
	}
}
