// controller ó��

var root = "/BNCRent/";

//controller ó��


function mi_getBoardType_cus(){
	document.location.href=root + "cusctrl?act=boardtype";
}

function mi_writeArticle_cus(){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("������ �Է��ϼ���..");
		return
	}else if(alice.getContent() == ""){
		alert("������ �Է��ϼ���..");
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
	if(confirm("���� �����Ͻðڽ��ϱ�?")){
	f.action = root + "cusctrl";
	f.submit();
	}
}

function mi_modiArticle_cus(num){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("������ �Է��ϼ���..");
		return
	}else if(alice.getContent().value == ""){
		alert("������ �Է��ϼ���..");
		return
	}else{
		if(confirm("���� �����Ͻðڽ��ϱ�?")){
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
//		  alert("�˻��ϰ��� �ϴ� �׸��� ������ �ּ���.");
//		  document.searchForm.item.focus();
//		  return;
//		 }
//	 
//	 if (f.item.value == "subject" && document.searchForm.query.value.length < 2) {
//		  alert("�˻��Ͻ� �ܾ��� �ٽ� �Է��� �ּ���.\n�ܾ�� �ѱ�2��,����4�� �̻��� �Է��� �ּž� �˻��� �����մϴ�.");
//		  return;
//		 }
//
//		 if (f.item.value == "writer" && document.searchForm.query.value.length < 1) {
//		  alert("�˻��Ͻ� �г����� �ٽ� �Է��� �ּ���.\n�г����� �ѱ�1��,����2�� �̻��� �Է��� �ּž� �˻��� �����մϴ�.");
//		  return;
//		 }
//
//		 else if((f.item.value == "no") && (isNaN(document.searchForm.query.value) == true)){
//		  alert("�˻��Ͻ� �۹�ȣ�� �ٽ� �Է��� �ּ���.\n�� ��ȣ�� ���� �Է¸��� �����մϴ�.");
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
	
	if(!checkFrm(fs.subject, "����", "", 2, 100)) return;

	if(!checkFrm(fs.mkname, "����", "", 2, 15)) return;
	
	if(!checkFrm(fs.email, "�̸���", "$email$", 5, 40)) return;

	if( ( fs.nhandp1.value=="" || fs.nhandp2.value=="" || fs.nhandp3.value=="" )&& ( fs.ntelno1.value=="" || fs.ntelno2.value=="" || fs.ntelno3.value=="" ) ){
			alert("����ó �ּ� 1�� �̻��� �Է����ֽñ� �ٶ��ϴ�.");
			return;		
	}

	if(!checkFrm(fs.nhandp1, "�޴���", "$number$", 0, 4)) return;		
	if(!checkFrm(fs.nhandp2, "�޴���", "$number$", 0, 4)) return;
	if(!checkFrm(fs.nhandp3, "�޴���", "$number$", 0, 4)) return;

	if(!checkFrm(fs.ntelno1, "��ȭ��ȣ", "$number$", 0, 4)) return;
	if(!checkFrm(fs.ntelno2, "��ȭ��ȣ", "$number$", 0, 4)) return;
	if(!checkFrm(fs.ntelno3, "��ȭ��ȣ", "$number$", 0, 4)) return;		

	if( !checkRadio( fs.cgubun ) ){
		alert("���� ������ �����ϼ���");
		fs.cgubun[0].focus();
		return;
	}

	if(!checkFrm(fs.mdescx, "����", "", 10, 2000)) return;
	
	fs.submit();
	
	document.getElementById("submit1").style.display = "none";
	document.getElementById("submit2").style.display = "";
}

function sendMessage() {
	alert('������ ������ �ֽ��ϴ�.\nȮ�� ��ư�� �����ð�, ��ø� ��ٷ��ּ���.');
	return;
}

function onlyNumber(){
	if ((event.keyCode<48)||(event.keyCode>57))
	{
		event.returnValue = false;
	}
}
