// controller ó��

var root = "/BNCRent/";

function mi_getBoardType(){
	document.location.href=root + "comctrl?act=boardtype";
}

function mi_writeArticle(){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("������ �Է��ϼ���..");
		return
	}else if(alice.getContent() == ""){
		alert("������ �Է��ϼ���..");
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
	if(confirm("���� �����Ͻðڽ��ϱ�?")){
	f.action = root + "comctrl";
	f.submit();
	}
}

function mi_modiArticle(num){
	var f = document.writeForm;
	if(f.subject.value == ""){
		alert("������ �Է��ϼ���..");
		return
	}else if(alice.getContent() == ""){
		alert("������ �Է��ϼ���..");
		return
	}else{
		if(confirm("���� �����Ͻðڽ��ϱ�?")){
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



