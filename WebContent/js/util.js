

/**************************************************************
���� : ������ ���� üũ�ؼ� �����̸� �޼��� �������� �ش� ������ ��Ŀ��
��) checkSpace(frm,strMsg) checkSpace(��.�̸�, �޼���)
����) ������ �ƴϸ� true | �����̸� false 
**************************************************************/
function checkSpace(frm,strMsg){
	var str = frm.value;
	if (str.search(/\S/)<0){			//\S ������ �ƴ� ���ڸ� ã�´�.
		alert (strMsg);
		frm.value = "";
		frm.focus();
		return false;
	}
	var temp=str.replace(' ','');
	if (temp.length == 0){
		alert (strMsg);
		frm.value = "";
		frm.focus();
		return false;
	}
	return true;
}



/**************************************************************
���� : ���� �Է� üũ
��) checkNum(frm,strMsg) checkNum(��.�̸�, �޼���)
����) ���ڰ� �´ٸ� true | ���ڰ� �ƴ϶�� �޼��� �˸��� false 
**************************************************************/
function checkNum(frm,strMsg){
	var strNum = frm.value;
	if (isNaN(strNum)){  
		alert(strMsg);
		frm.value="";
		frm.focus();
		return false;
	}
	return true;
}


/**************************************************************
���� : �ѱ� �Է� üũ
��) checkHangul(��.�̸�,�޼���)
����) �ѱ��̸� true | �ѱ��� �ƴϸ� false
**************************************************************/
function checkHangul(frm,strMsg){
	var str = frm.value;
	for(i=0;i<=str.length;i++){
		if(str.charCodeAt(i)<12644){  
			alert(strMsg);
			frm.focus();
			return false;
			break;
		}
	}
	return true;
}


/**************************************************************
���� : ���ڰ� �Է� üũ (YYYYMMDD)
��) checkDateYMD(ymd) checkDateYMD('20060512')
����) ��¥�� �´ٸ� true | ��¥�� �ƴ϶�� �޼��� �˸��� false 
**************************************************************/
//function checkDateYMD(sYmd){
//	
//	// ���� Ȯ��
//	if(sYmd.length != 8){
//		alert('���ڸ� ��� �Է��Ͻʽÿ�');
//		return false;
//	}
//
//	// ���� Ȯ��
//	if(isNaN(sYmd)){
//		alert('��¥�� ���ڸ� �Է��Ͻʽÿ�');
//		return false;
//	}
//
//	var iYear = parseInt(sYmd.substring(0,4),10);  // �⵵ �Է�(YYYY)
//	var iMonth = parseInt(sYmd.substring(4,6),10);   //���Է�(MM)
//	var iDay = parseInt(sYmd.substring(6,8),10);     //�����Է�(DD)
//
//	if((iMonth < 1) ||(iMonth >12))
//	{
//		alert(iMonth+' ���� �Է��� �߸� �Ǿ����ϴ�.');
//		return false;
//	}
//
//	var MonthArray = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
//
//	if (eval(iYear)%4 == 0 && eval(iYear)%100 != 0 || eval(iYear)%400 == 0){ //����
//		MonthArray[2] = 29;
//	}
//
//	iLastDay = MonthArray[eval(iMonth)];
//
//	if( (iDay < 1) || (iDay > iLastDay) ){	//��¥ ����
//		alert(iMonth+' ���� ���ڴ� 1 - '+ iLastDay +' �����Դϴ�.');
//		return false;
//	}
//
//	return true;
//}

/************************************************************
���� : �ֹι�ȣ üũ �Լ�
��)checkJumin(�ֹι�ȣ)
���� �߸��Ȱ� �ִٸ� false
���� �ùٸ��ٸ� true
************************************************************/
function checkJumin(it){
	IDtot = 0;
	IDAdd = "234567892345";

	for(i=0; i<12; i++) IDtot = IDtot + parseInt(it.substring(i, i+1)) * parseInt(IDAdd.substring(i, i+1));
	IDtot = 11 - (IDtot%11);
	if (IDtot == 10) IDtot = 0;
	else if (IDtot == 11) IDtot = 1;

	if(parseInt(it.substring(12, 13)) != IDtot) return false;
	else return true;
}

/************************************************************
���� : �Է��� email�� �����ڿ� @���� ��Ȯ�� �� �ִ��� 
��) checkEmail("test@test.co.kr")
���) true
���� : �̸����� �´ٸ�  True , Ʋ���ٸ� false
************************************************************/
function checkEmail(email){
	var str='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
	var flag=0;
	var comma=0;
	for(i=0; i<email.length; i++) {
		for(j=0; j<str.length; j++) {
			if(email.charAt(i)==str.charAt(j)){
				break;
			}
		}
		if(j==str.length) {
			if(email.charAt(i)=='@'){
				flag++;
			}else if(email.charAt(i)=='.'){
				comma++;
			}else{
				return false;
			}
		}
	}
	if(flag!=1){
		return false;
	}else if((comma<1)||(comma>3)){
		return false;
	}else{
		return true;
	}
}

function check_email(str){
    var regDoNot = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/;
    var regMust = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3})$/;

    if (!regDoNot.test(str) && regMust.test(str)) return true;
    else return false;
}

/************************************************************
  �Լ� : checkId(userid)
  ���� : �Է��� id ���� ��Ȯ���� Ȯ���Ѵ�
  ��� : id (����� id)
		  ��) checkId(id)
  ���� : �� (True) , ���� (false)
************************************************************/
function checkId(userid){
	
	if( userid.length < 4 || userid.length > 12){
		alert("�̿���ID�� ���̴� 4 ~ 12�� �Դϴ�.");
		return false;
	}
	
	if (('A' > userid.charAt(0)) || ('z' < userid.charAt(0)) ) {
		alert("�̿���ID�� ù���ڴ� �����ڸ� �����մϴ�.");
		return false;
	}

	for(k=0; k < userid.length; k++) {
			if( ('0' <= userid.charAt(k) &&
			'9' >= userid.charAt(k)) ||
			('A' <= userid.charAt(k) &&
			'Z' >= userid.charAt(k)) ||
			('a' <= userid.charAt(k) &&
			'z' >= userid.charAt(k)) ){
		} else {
			alert("�̿���ID�� �����ڿ� ���ڸ� �����մϴ�.");
			return false;
		}
	}
	return true;
}


/************************************************************
���� : üũ �ڽ�, ���� ��ư ���� üũ
��) checkRadio(��.�̸�)
���) üũ �Ѱ� �ִٸ� true üũ�Ѱ� ���ٸ� false
************************************************************/
function checkRadio(InputName){
	if(InputName){
		if(!InputName.length) {
			if(InputName.checked) {
				return true;
			}
		} else {
			for(i=0;i<InputName.length;i++) {
				if(InputName[i].checked) {
					return true;
				}
			}
		}
	}
	return false;
}


/************************************************************
���� : üũ �ڽ� ��� ���� , ����
��) checkAll(���̸�,�̸�,true �Ǵ� false)
���) true üũ�ڽ� ��� ���� , false ����
************************************************************/
function checkAll(frm,name,bool){
	var obj = eval("document.forms."+frm+"."+name);
	if(obj){
		if(!obj.length) {
			obj.checked = bool;  //üũ�ڽ��� �ϳ��� ���
		}else{
			for (var i = 0; i < obj.length; i++) {  //�������� ���
				obj[i].checked = bool;
			}
		}
	}
}

/************************************************************
���� : �� üũ �Լ�
��) checkFrm(��.�̸�, "�Է¶�", "", ������, ū��)
���� �߸��Ȱ� �ִٸ� false
���� �ùٸ��ٸ� true
ex ) if(!checkFrm(frm.mem_name, "�̸�", "", 1, 5)) return;
************************************************************/
function checkFrm(target, cmt, astr, lmin, lmax){
	
	var i;
	var t = target.value;
	
	if(lmin==0){
		if(t.length==0){
			return true;
		}
	}

	if(t.search(/\S/)<0){
		alert(cmt + ' �Է¶��� ������ �ֽ��ϴ�. ���� �Է��� �ּ���.');
		target.value = "";
		target.focus();
		return false;
	}

	var temp = t.replace(' ','');
	if (temp.length == 0){
		alert(cmt + ' �Է¶��� ������ �ֽ��ϴ�. ���� �Է��� �ּ���.');
		target.value = "";		
		target.focus();
		return false;
	}

	if(t.length < lmin || t.length > lmax){
		
		if (lmin == lmax){
			alert(cmt + ' �Է¶��� ' + lmin + ' �� �̳��� �Է��ϼž� �մϴ�');
		}else if(lmin == 0){
			alert(cmt + ' �Է¶��� ' + lmax + ' �� �̳��� �Է��ϼž� �մϴ�');
		}else{
			alert(cmt + ' �Է¶��� ' + lmin + ' ~ ' + lmax + ' �� �̳��� �Է��ϼž� �մϴ�');
		}
		target.focus();
		return false;
	}
	
	if (astr.length > 1) {
		
		if( astr=="$email$" ){
			
			if(!checkEmail( t )){
				alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�.");
				target.focus();
				return false;
			}
	
		}else if( astr=="$hangul$" ){

			for( i=0;i<=t.length;i++ ){
				if( t.charCodeAt(i)<12644 ){
					
					alert(cmt + ' �Է¶��� �ѱ۸� �Է� �����մϴ�.');
					
					target.focus();
					return false;
				}
			}

		}else if( astr=="$number$" ){
					
			if (isNaN(t)){  
				alert(cmt + ' �Է¶��� ���ڸ� �Է� �����մϴ�.');	
				target.focus();
				return false;
			}
			
		}else{
		
			for (i=0; i < t.length; i++){
				if(astr.indexOf(t.substring(i,i+1))<0){
					alert(cmt + ' �Է¶��� ����� �� ���� ���ڰ� �ԷµǾ����ϴ�');
					target.focus();
					return false;
				}
			}
		}
		
	}
	return true;
}



/************************************************************
���� : ��â ����� ��Ŀ�� �ֱ�
��) windowOpen('�ּ�','�������̸�',����,����,'��Ÿ ����')
,scrollbars=yes ,personalbar=no ,resizable=no ,directories=no ,status=no ,menubar=no
************************************************************/
function windowOpen(pUrl,pName,pW,pH,val){
	var winWidth  = window.screen.width;    //�ػ󵵰���
	var winHeight  = window.screen.height;     //�ػ󵵼���
	
	// XP�� ��� height 29 �߰�
	//if( window.navigator.userAgent.indexOf("SV1") != -1 ) {
	//	pH += 29;
	//}
	
	var pLeft,pTop;
	pLeft = parseInt((winWidth-pW)/2);
	pTop = parseInt((winHeight-pH)/2);
	
	var newWin=window.open(pUrl,pName,"width="+pW+",height="+pH+",left="+pLeft+",top="+pTop+" "+ val );
	newWin.focus(); 
}


/***** �ԷµǸ� �������� �̵� *******/
function nextChk(arg,len,nextname) { 
	if (arg.value.length==len) {
		nextname.focus() ;
		return;
	}
}
	
	

/***********************************
���� : �ѱ� �ѱ��ڸ� 2byte�� �ν��Ͽ�, IE�� Netscape�� ����� byte���̸� ���� �ݴϴ�.
��) getByteLength("abc������") getByteLength(��.�̸�.���) 
���) 9
���� : ����
 ****************************************/
function getByteLength(s){
	var len = 0;
	if ( s == null ) return 0;
	for(var i=0;i<s.length;i++){
		var c = escape(s.charAt(i));
		if ( c.length == 1 ) len ++;
		else if ( c.indexOf("%u") != -1 ) len += 2;
		else if ( c.indexOf("%") != -1 ) len += c.length/3;
	}
	return len;
}

/**
HTML ��ü�� ��ƿ��Ƽ �Լ�
**/
function GetObjectTop(obj){
	if (obj.offsetParent == document.body)
		return obj.offsetTop;
	else
		return obj.offsetTop + GetObjectTop(obj.offsetParent);
}

function GetObjectLeft(obj){
	if (obj.offsetParent == document.body)
		return obj.offsetLeft;
	else
		return obj.offsetLeft + GetObjectLeft(obj.offsetParent);
}

/*=========================================================
��Ű ����
=========================================================/

/*
setCookie( "Notice", "done" , 1);
(�̸�,��,��¥)  �Ϸ絿�� ��Ű ����
*/
function setCookie( name, value, expiredays ){ 
       var todayDate = new Date(); 
       todayDate.setDate( todayDate.getDate() + expiredays ); 
       document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

/*
getCookie(��Ű�̸�)
*/
function getCookie( name ) { 
       var nameOfCookie = name + "="; 
       var x = 0; 
       while ( x <= document.cookie.length ) 
       { 
               var y = (x+nameOfCookie.length); 
               if ( document.cookie.substring( x, y ) == nameOfCookie ) { 
                       if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                               endOfCookie = document.cookie.length; 
                       return unescape( document.cookie.substring( y, endOfCookie ) ); 
               } 
               x = document.cookie.indexOf( " ", x ) + 1; 
               if ( x == 0 ) 
                       break; 
       } 
       return ""; 
} 

//��Ű �Ҹ� �Լ�
function clearCookie(name) {
    var today = new Date()
    //���� ��¥�� ��Ű �Ҹ� ��¥�� �����Ѵ�.
    var expire_date = new Date(today.getTime() - 60*60*24*1000)
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString()
}

//�̹��� Ȯ�뺸��
//popImgWin(�̹��� �ּ�)
function popImgWin(imgSrc){

	var viewSrc;
	var src1,src2;
	if( imgSrc.lastIndexOf("/")>-1 ){
		src1 = imgSrc.substring(0, imgSrc.lastIndexOf("/")+1 );
		src2 = imgSrc.slice(imgSrc.lastIndexOf("/")+1);
	}else{
		src1 = "";
		src2 = imgSrc;
	}
	
	viewSrc = src1+escape(src2);	//�̹����� ���ڵ� �ѱ� ���ϸ��ϰ�� ����
	
	var strhtml = "";
	
	var w = 100;
	var h = 100;
	
	var swfPattern = /\.(swf)$/ig;//Ȯ���� �÷��� ����
	var imgPattern = /\.(jpg|gif)$/ig;//�̹��� Ȯ���� ����

	//���� �÷��� ���� �̶��
	if( swfPattern.test( imgSrc ) ){
		w = 400;
		h = 400;

		strhtml +="<html><head><title>Ȯ�뺸��</title><style>body{margin:0;}</style>";
		strhtml +="</head><body>";
		strhtml +="<table width='100%' height='100%' cellspacing='0' cellpadding='0'><tr>";
		strhtml +="<td align='center' valign='center'>";
		strhtml +="<embed src='"+viewSrc+"' width='100%'>";
		strhtml +="</td></tr></table></body></html>";
		
	}else if( imgPattern.test( imgSrc ) ){
	
		strhtml +="<html><head><title>�̹���Ȯ�뺸��</title><style>body{margin:0;}</style>";
		strhtml +="<s"+"cript language=\"JavaScript\">";
		strhtml +="function win_resize(){";
		strhtml +="var imgWidth  = parseInt(document.content_img.offsetWidth);";
		strhtml +="var imgHeight = parseInt(document.content_img.offsetHeight);";
		strhtml +="var winWidth  = window.screen.width;";
		strhtml +="var winHeight  = window.screen.height;";
		strhtml +="var reWidth,reHeight;";
		strhtml +="if(imgWidth>winWidth-100){";
		strhtml +="reWidth  = winWidth-100;";
		strhtml +="}else{";
		strhtml +="reWidth = imgWidth+50;";
		strhtml +="}";
		strhtml +="if(imgHeight>winHeight-100){";
		strhtml +="reHeight = winHeight-100;";
		strhtml +="}else{";
		strhtml +="reHeight = imgHeight+75;";
		//strhtml +="if(window.navigator.userAgent.indexOf(\"SV1\") != -1)reHeight+=29;";
		strhtml +="}";
		strhtml +="window.resizeTo(reWidth,reHeight);";
		strhtml +="window.moveTo(parseInt((winWidth-reWidth)/2),parseInt((winHeight-reHeight)/2));";
		strhtml +="window.focus();";
		strhtml +="}";
		strhtml +="</s"+"cript>";
		strhtml +="</head><body onload='win_resize()'>";
		strhtml +="<table width='100%' height='100%' cellspacing='0' cellpadding='0'><tr>";
		strhtml +="<td align='center' valign='center'>";
		strhtml +="<img src='"+viewSrc+"' name='content_img' id='content_img' border=0 onclick='window.close();' style='cursor:hand;'>";
		strhtml +="</td></tr></table></body></html>";
	}else{
		return;
	}
	
	var imageWin = window.open('', "imageWin", "width="+ w +", height="+ h +", top=100,left=100,scrollbars=1,resizable=1,toolbar=0,menubar=0,location=0,directories=0,status=0"); 
	imageWin.document.open(); 
	imageWin.document.write(strhtml);
	imageWin.document.close();
	imageWin.focus();
}


/***********************************************************
�Լ���		:newXMLHttpRequest()
ó������		:��û��ü�� ������ ��ȯ
***********************************************************/
// function from http://www-128.ibm.com/developerworks/kr/library/j-ajax1/index.html
function newXMLHttpRequest() {
	var xmlreq = false;
	if (window.XMLHttpRequest) {
		// Create XMLHttpRequest object in non-Microsoft browsers
		xmlreq = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		// Create XMLHttpRequest via MS ActiveX
		try {
			// Try to create XMLHttpRequest in later versions
			// of Internet Explorer
			xmlreq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e1) {
			// Failed to create required ActiveXObject
			try {
				// Try version supported by older versions
				// of Internet Explorer
				xmlreq = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e2) {
				// Unable to create an XMLHttpRequest with ActiveX
			}
		}
	}
	return xmlreq;
}


//
// �¿� ���� ����
//
function Trim( value ) 
{
	var len = value.length;
	if (len == 0) return('');

	var value1 = RTrim(value);
	var value2 = LTrim(value1);
	return(value2);
}

//
// ���� ���� ����
//
function LTrim( arg ) 
{
	var len = arg.length;
	if (len == 0) return('');

	var i = 0;
	for (; i < arg.length; i++) {
		var ch = arg.charAt(i);
		if (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r') {
			continue;
		}
		else
			break;
	}
	return(arg.substr(i));
}

//
// ������ ��������
//
function RTrim( arg ) 
{
	var len = arg.length;
	if (len == 0) return('');

	var i = len - 1;
	for (; i >= 0; i--) {
		var ch = arg.charAt(i);
		if (ch == ' ' || ch == '\t' || ch == '\n')
			continue;
		else
			break;
	}
	return(arg.substring(0, i+1));
}



/*------------------------------------------
���� üũ ��� ����
-------------------------------------------*/
//��¥�� üũ ��) 2006-04-05 �̷� ���� 
//�´ٸ� true Ʋ���� false
function checkDateStr(str){
	var pattern = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
	return(pattern.test(str));
}

//���̵� üũ 
//����, ���ĺ� �ҹ��� �ԷµȰ� �´ٸ� 4~12 true Ʋ���� false
function check_userid(str){
	var pattern = /^[0-9a-z]{4,12}$/;
	return(pattern.test(str));
}

//�н����� üũ
//����, ���ĺ� �ҹ���,�빮�� �ԷµȰ� �´ٸ� 4~15  true Ʋ���� false
function check_password(str){
	var pattern = /^[0-9a-zA-Z]{4,15}$/;
	return(pattern.test(str));
}

function check_zipcode(str){
	var pattern = /^[0-9]{6}$/;
	return(pattern.test(str));
}

//���� üũ 
//���� �´ٸ� true Ʋ���� false
function check_isnumber(str){
	pattern = /^[0-9]+$/;
	return(pattern.test(str));
}

function check_phone(str){
	var pattern = /^[0-9][0-9\-]+[0-9]$/;
	return(pattern.test(str));
}

function check_local_mobile(str){
	var pattern = /^[0-9\-]{1,6}$/;
	return(pattern.test(str));
}

function check_mobile(str){
	var pattern = /^[0-9][0-9\-]+[0-9]$/;
	return(pattern.test(str));
}



//-----------------------------------------------


/**********************************************************
name (form.�̸� ) , ivalue(Value)
��) optionValueSel(form.job , 2)
�ش� �ɼǿ��� ����� �������� ����Ʈ ��Ų��.
 *********************************************************/
function optionValueSel(name,ivalue)
{
	var i,sel = 0;
	for(i=0;i<name.length;i++)
	{
		if(name.options[i].value == ivalue ) {
			sel = i;
		}
	}
	name.options[sel].selected = true  
}


/**********************************************************
��) optionValueRtn(form.name)
�ش� �ɼǿ��� ���õ� ������� ���� ��Ų��.
 *********************************************************/
function optionValueRtn(name)
{
	var name_value = "";
  
	for(i=0;i<name.length;i++)
	{
		if ( name[i].selected == true ) 
		{
			name_value = name[i].value;
		}
	}
	return name_value;
}

/**********************************************************
��) optionTextRtn(form.name)
�ش� �ɼǿ��� ���õ� �ؽ�Ʈ���� ���� ��Ų��.
 *********************************************************/
function optionTextRtn(name){
	var name_value = "";
  
	for(i=0;i<name.length;i++)
	{
		if ( name[i].selected == true ) 
		{
			name_value = name[i].text;
		}
	}
	return name_value;
}

/************************************************************
��) radioValueRtn(form.name)
���� ��ư���� ������ ���� ������� �����Ѵ�
�����Ѱ��� ���ٸ� "" ������ �����Ѵ�.
************************************************************/
function radioValueRtn(name){
	if(name){
		if(!name.length) {
			if(name.checked) {
				return name.value;
			}
		} else {
			for(var i=0;i<name.length;i++) {
				if(name[i].checked) {
					return name[i].value;
				}
			}
		}
	}
	return "";

}


/*************************************************************
��) checkInsert ( name (form�̸� ) , ivalue(Int�� Value) )
radio�� checkbox ���� �ش� ������� �������� ���� �ǵ��� �Ѵ�.
 ************************************************************/
function checkInsert(name,ivalue)
{
	if(name){
		if(!name.length) {
			if(name.value == ivalue) {
				name.checked = true;
			}
		} else {
			for(var i=0;i<name.length;i++) {
				if(name[i].value == ivalue) {
					name[i].checked = true;
				}
			}
		}
	}
}

//üũ���� �ʱ�ȭ üũ�Ȱ��� ��� false �� �Ѵ�.
function checkInit(name)
{
	if(name){
		if(!name.length) {
			name.checked = false;
		} else {
			for(var i=0;i<name.length;i++) {
				name[i].checked = false;
			}
		}
	}
}

//-----------------------------------------------



//�̹��� �ڵ� �������� ó��
var arrObjImg = new Array(); //�̹�����ü ���� �迭

function set_onload_resize(img,resizeWidth){
	var imgLen = arrObjImg.length;
	arrObjImg[imgLen] = new imgClass(img, resizeWidth);
	resize_img(imgLen);
}

function imgClass(img,resizeWidth){
	this.img = img;
	this.resizeWidth = resizeWidth;
}

function resize_img(idx){
	var objImg = arrObjImg[idx].img;
	var resizeWidth = arrObjImg[idx].resizeWidth;
	if(objImg){
		if(objImg.complete == false){//�̹����� �ε� ���� �ʾҴٸ�
			setTimeout("resize_img("+idx+")",100);
		}else{
			if(objImg.width>resizeWidth){
				objImg.height = parseInt((resizeWidth * objImg.height) / objImg.width);
				objImg.width = resizeWidth;
				objImg.onclick=function(){window.open(objImg.src);}
			}
		}
			
	}
}

/*
javascript�� ������ Request
��ҹ��� ���о���
�ش簪�� ������ "" ���� ����
*/
function Request(valuename){
	var rtnval = "";
	var nowAddress = unescape(location.href);
	var parameters = (nowAddress.slice(nowAddress.indexOf("?")+1,nowAddress.length)).split("&");
    
	for(var i = 0 ; i < parameters.length ; i++){
		var varName = parameters[i].split("=")[0];
		if(varName.toUpperCase() == valuename.toUpperCase())
		{
			rtnval = parameters[i].split("=")[1];
			break;
		}
	}
	return rtnval;
}

//���� document.write 
function dw(str){
	document.write(str); 
}


//�ͽ��÷η� ��ġ�� ���� �÷��� ��ũ���� write ó��
//(�÷����ּ�,����,����,�Ѱܹ�����,���̵�,�̸�,����)
function flashWrite(fSrc,sWidth,sHeight,fVars,fId,fName,fBgcolor){
	
	var strFlash;
	
	strFlash ='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"';
	strFlash += ' id="'+fId+'" name="'+fName+'"';
	strFlash += ' width="'+sWidth+'" height="'+sHeight+'">';  
	strFlash += '<param name=flashVars value="'+fVars+'">';        
	strFlash += '<param name="movie" value="'+fSrc+'">';
	strFlash += '<param name="wmode" value="transparent">';
	strFlash += '<param name=bgcolor value="'+fBgcolor+'">';   
	strFlash += '<param name="quality" value="high">';
	strFlash += '<param name="menu" value="false">';
	strFlash += '<embed src="'+fSrc+'" quality="high" swLiveConnect=true pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"';
	strFlash += ' id="'+fId+'" name="'+fName+'"';	
	strFlash += ' width="'+sWidth+'" height="'+sHeight+'">';
	strFlash += '</embed></object>';
	
	document.write(strFlash);
}


/*
���ȿ� �ִ� ������ ���ڵ��ؼ� �����Ѵ�.
��) formData2QueryString(document.pageForm)
����) gotoPage=3&col=1&search=
*/
function formData2QueryString(docForm) {

	var submitContent = '';
	var formElem;
	var lastElemName = '';
	for (i = 0; i < docForm.elements.length; i++) {
    
		formElem = docForm.elements[i];

		switch (formElem.type) {
			// Text fields, hidden form elements
			case 'text':
			case 'hidden':
			case 'password':
			case 'textarea':
			case 'select-one':
				submitContent += formElem.name + '=' + escape(formElem.value) + '&'
				break;
        
			// Radio buttons
			case 'radio':
				if (formElem.checked) {
					submitContent += formElem.name + '=' + escape(formElem.value) + '&'
				}
				break;
        
			// Checkboxes
			case 'checkbox':
				if (formElem.checked) {
					// Continuing multiple, same-name checkboxes
					if (formElem.name == lastElemName) {
						// Strip of end ampersand if there is one
						if (submitContent.lastIndexOf('&') == submitContent.length-1) {
							submitContent = submitContent.substr(0, submitContent.length - 1);
						}
						// Append value as comma-delimited string
						submitContent += ',' + escape(formElem.value);
					}else {
						submitContent += formElem.name + '=' + escape(formElem.value);
					}
					submitContent += '&';
					lastElemName = formElem.name;
				}
			break;
		}
	}

	// Remove trailing separator
	submitContent = submitContent.substr(0, submitContent.length - 1);
	return submitContent;
}


/************************************************************
  �Լ� : currence(cur)
  ���� : ���� ���� �°� �޸��� ǥ���Ѵ�
  ��� : cur (��ġ)
          ��) currence("1000000")
        ���) 1,000,000
  ���� : ��� ��
************************************************************/
function currence(cur)
{
  var i,c;
  var rev="";
  var tmp="";
  var ver="";
  var num="";

  // ���� comma�� ������ ���� �Ѵ�.
  for(i=0;i<cur.length;i++){
    if(cur.charAt(i) == ",")
      num += ""
    else
      num += cur.charAt(i)
  }
  // �켱 reverse�� �Ѵ�.
  for(i=num.length;i>=0;--i)
      rev += num.charAt(i)

  // comma�� ������.
  c = 1;
  for(i=0;i<rev.length;i++)
  {
    if(i==3*c)
    {
      tmp += ",";
      tmp += rev.charAt(i);
      c=c+1;
    }
    else
    {
      tmp += rev.charAt(i);
    }
  }
  // �ٽ� reverse�� �Ѵ�.
  for(i=tmp.length;i>=0;--i)
      ver += tmp.charAt(i)

  return ver;
}

/************************************************************
  �Լ� : window_center(����,����)
  ���� : ����â�� ������ ����
  ��� : window_center (����,����)
          ��) window_center(100,100)
        
************************************************************/

function window_center(w, h) { 
	
		width=screen.width;
		height=screen.height;
	
		x=(width/2)-(w/2);
		y=(height/2)-(h/2);
	
		window.resizeTo(w,h);
		window.moveTo(x,y);
	}


function getWeekEnd(str)
{
	var weekInfo = new Array('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
	d = toTimeObject(str);
	day=d.getDay();
	
	return weekInfo[day];
}	

function toTimeObject(time){
	var year = time.substr(0,4);
	var month = time.substr(4,2)-1;
	var day = time.substr(6,2);
	
	return new Date(year,month,day);
}

function GetSelectedVal(objSelect){
        var i;
        var selectedval ;
        for(i=0;i<objSelect.options.length;i++){
                if(objSelect.options[i].selected==true){
                        selectedval = objSelect.options[i].value;
                        break;
                }
        }
        return selectedval ;
}

function GetSelectedTxt(objSelect){
        var i;
        var selectedtext;
        for(i=0;i<objSelect.options.length;i++){
                if(objSelect.options[i].selected==true){
                        selectedtext= objSelect.options[i].text;
                        break;
                }
        }
        return selectedtext;
}

