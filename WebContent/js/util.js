

/**************************************************************
설명 : 폼에서 공백 체크해서 공백이면 메세지 보여지고 해당 폼값에 포커스
예) checkSpace(frm,strMsg) checkSpace(폼.이름, 메세지)
리턴) 공백이 아니면 true | 공백이면 false 
**************************************************************/
function checkSpace(frm,strMsg){
	var str = frm.value;
	if (str.search(/\S/)<0){			//\S 공백이 아닌 문자를 찾는다.
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
설명 : 숫자 입력 체크
예) checkNum(frm,strMsg) checkNum(폼.이름, 메세지)
리턴) 숫자가 맞다면 true | 숫자가 아니라면 메세지 알림후 false 
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
설명 : 한글 입력 체크
예) checkHangul(폼.이름,메세지)
리턴) 한글이면 true | 한글이 아니면 false
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
설명 : 날자값 입력 체크 (YYYYMMDD)
예) checkDateYMD(ymd) checkDateYMD('20060512')
리턴) 날짜가 맞다면 true | 날짜가 아니라면 메세지 알림후 false 
**************************************************************/
//function checkDateYMD(sYmd){
//	
//	// 길이 확인
//	if(sYmd.length != 8){
//		alert('일자를 모두 입력하십시오');
//		return false;
//	}
//
//	// 숫자 확인
//	if(isNaN(sYmd)){
//		alert('날짜는 숫자만 입력하십시오');
//		return false;
//	}
//
//	var iYear = parseInt(sYmd.substring(0,4),10);  // 년도 입력(YYYY)
//	var iMonth = parseInt(sYmd.substring(4,6),10);   //월입력(MM)
//	var iDay = parseInt(sYmd.substring(6,8),10);     //일자입력(DD)
//
//	if((iMonth < 1) ||(iMonth >12))
//	{
//		alert(iMonth+' 월의 입력이 잘못 되었습니다.');
//		return false;
//	}
//
//	var MonthArray = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
//
//	if (eval(iYear)%4 == 0 && eval(iYear)%100 != 0 || eval(iYear)%400 == 0){ //윤년
//		MonthArray[2] = 29;
//	}
//
//	iLastDay = MonthArray[eval(iMonth)];
//
//	if( (iDay < 1) || (iDay > iLastDay) ){	//날짜 오류
//		alert(iMonth+' 월의 일자는 1 - '+ iLastDay +' 까지입니다.');
//		return false;
//	}
//
//	return true;
//}

/************************************************************
설명 : 주민번호 체크 함수
예)checkJumin(주민번호)
값이 잘못된게 있다면 false
값이 올바르다면 true
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
설명 : 입력한 email이 영문자와 @값이 정확이 들어가 있는지 
예) checkEmail("test@test.co.kr")
결과) true
리턴 : 이메일이 맞다면  True , 틀리다면 false
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
  함수 : checkId(userid)
  목적 : 입력한 id 값이 정확한지 확인한다
  방법 : id (사용자 id)
		  예) checkId(id)
  리턴 : 참 (True) , 거짓 (false)
************************************************************/
function checkId(userid){
	
	if( userid.length < 4 || userid.length > 12){
		alert("이용자ID의 길이는 4 ~ 12자 입니다.");
		return false;
	}
	
	if (('A' > userid.charAt(0)) || ('z' < userid.charAt(0)) ) {
		alert("이용자ID의 첫글자는 영문자만 가능합니다.");
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
			alert("이용자ID는 영문자와 숫자만 가능합니다.");
			return false;
		}
	}
	return true;
}


/************************************************************
설명 : 체크 박스, 라디오 버튼 선택 체크
예) checkRadio(폼.이름)
결과) 체크 한게 있다면 true 체크한게 없다면 false
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
설명 : 체크 박스 모두 선택 , 해제
예) checkAll(폼이름,이름,true 또는 false)
결과) true 체크박스 모드 선택 , false 해제
************************************************************/
function checkAll(frm,name,bool){
	var obj = eval("document.forms."+frm+"."+name);
	if(obj){
		if(!obj.length) {
			obj.checked = bool;  //체크박스가 하나일 경우
		}else{
			for (var i = 0; i < obj.length; i++) {  //여러개일 경우
				obj[i].checked = bool;
			}
		}
	}
}

/************************************************************
설명 : 폼 체크 함수
예) checkFrm(폼.이름, "입력란", "", 작은값, 큰값)
값이 잘못된게 있다면 false
값이 올바르다면 true
ex ) if(!checkFrm(frm.mem_name, "이름", "", 1, 5)) return;
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
		alert(cmt + ' 입력란에 공백이 있습니다. 값을 입력해 주세요.');
		target.value = "";
		target.focus();
		return false;
	}

	var temp = t.replace(' ','');
	if (temp.length == 0){
		alert(cmt + ' 입력란에 공백이 있습니다. 값을 입력해 주세요.');
		target.value = "";		
		target.focus();
		return false;
	}

	if(t.length < lmin || t.length > lmax){
		
		if (lmin == lmax){
			alert(cmt + ' 입력란은 ' + lmin + ' 자 이내로 입력하셔야 합니다');
		}else if(lmin == 0){
			alert(cmt + ' 입력란은 ' + lmax + ' 자 이내로 입력하셔야 합니다');
		}else{
			alert(cmt + ' 입력란은 ' + lmin + ' ~ ' + lmax + ' 자 이내로 입력하셔야 합니다');
		}
		target.focus();
		return false;
	}
	
	if (astr.length > 1) {
		
		if( astr=="$email$" ){
			
			if(!checkEmail( t )){
				alert("올바른 이메일 주소가 아닙니다.");
				target.focus();
				return false;
			}
	
		}else if( astr=="$hangul$" ){

			for( i=0;i<=t.length;i++ ){
				if( t.charCodeAt(i)<12644 ){
					
					alert(cmt + ' 입력란은 한글만 입력 가능합니다.');
					
					target.focus();
					return false;
				}
			}

		}else if( astr=="$number$" ){
					
			if (isNaN(t)){  
				alert(cmt + ' 입력란은 숫자만 입력 가능합니다.');	
				target.focus();
				return false;
			}
			
		}else{
		
			for (i=0; i < t.length; i++){
				if(astr.indexOf(t.substring(i,i+1))<0){
					alert(cmt + ' 입력란에 허용할 수 없는 문자가 입력되었습니다');
					target.focus();
					return false;
				}
			}
		}
		
	}
	return true;
}



/************************************************************
설명 : 새창 띄워서 포커스 주기
예) windowOpen('주소','윈도우이름',가로,세로,'기타 설정')
,scrollbars=yes ,personalbar=no ,resizable=no ,directories=no ,status=no ,menubar=no
************************************************************/
function windowOpen(pUrl,pName,pW,pH,val){
	var winWidth  = window.screen.width;    //해상도가로
	var winHeight  = window.screen.height;     //해상도세로
	
	// XP인 경우 height 29 추가
	//if( window.navigator.userAgent.indexOf("SV1") != -1 ) {
	//	pH += 29;
	//}
	
	var pLeft,pTop;
	pLeft = parseInt((winWidth-pW)/2);
	pTop = parseInt((winHeight-pH)/2);
	
	var newWin=window.open(pUrl,pName,"width="+pW+",height="+pH+",left="+pLeft+",top="+pTop+" "+ val );
	newWin.focus(); 
}


/***** 입력되면 다음으로 이동 *******/
function nextChk(arg,len,nextname) { 
	if (arg.value.length==len) {
		nextname.focus() ;
		return;
	}
}
	
	

/***********************************
설명 : 한글 한글자를 2byte로 인식하여, IE든 Netscape든 제대로 byte길이를 구해 줍니다.
예) getByteLength("abc가나다") getByteLength(폼.이름.밸류) 
결과) 9
리턴 : 길이
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
HTML 개체용 유틸리티 함수
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
쿠키 관련
=========================================================/

/*
setCookie( "Notice", "done" , 1);
(이름,값,날짜)  하루동안 쿠키 저장
*/
function setCookie( name, value, expiredays ){ 
       var todayDate = new Date(); 
       todayDate.setDate( todayDate.getDate() + expiredays ); 
       document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
} 

/*
getCookie(쿠키이름)
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

//쿠키 소멸 함수
function clearCookie(name) {
    var today = new Date()
    //어제 날짜를 쿠키 소멸 날짜로 설정한다.
    var expire_date = new Date(today.getTime() - 60*60*24*1000)
    document.cookie = name + "= " + "; expires=" + expire_date.toGMTString()
}

//이미지 확대보기
//popImgWin(이미지 주소)
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
	
	viewSrc = src1+escape(src2);	//이미지명 인코딩 한글 파일명일경우 에러
	
	var strhtml = "";
	
	var w = 100;
	var h = 100;
	
	var swfPattern = /\.(swf)$/ig;//확장자 플래시 패턴
	var imgPattern = /\.(jpg|gif)$/ig;//이미지 확장자 패턴

	//만약 플래시 파일 이라면
	if( swfPattern.test( imgSrc ) ){
		w = 400;
		h = 400;

		strhtml +="<html><head><title>확대보기</title><style>body{margin:0;}</style>";
		strhtml +="</head><body>";
		strhtml +="<table width='100%' height='100%' cellspacing='0' cellpadding='0'><tr>";
		strhtml +="<td align='center' valign='center'>";
		strhtml +="<embed src='"+viewSrc+"' width='100%'>";
		strhtml +="</td></tr></table></body></html>";
		
	}else if( imgPattern.test( imgSrc ) ){
	
		strhtml +="<html><head><title>이미지확대보기</title><style>body{margin:0;}</style>";
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
함수명		:newXMLHttpRequest()
처리내용		:요청객체를 생성후 반환
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
// 좌우 공백 제거
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
// 왼쪽 공백 제거
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
// 오른쪽 공백제거
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
패턴 체크 사용 안함
-------------------------------------------*/
//날짜값 체크 예) 2006-04-05 이런 형식 
//맞다면 true 틀리면 false
function checkDateStr(str){
	var pattern = /^[0-9]{4}\-[0-9]{2}\-[0-9]{2}$/;
	return(pattern.test(str));
}

//아이디값 체크 
//숫자, 알파벳 소문자 입력된게 맞다면 4~12 true 틀리면 false
function check_userid(str){
	var pattern = /^[0-9a-z]{4,12}$/;
	return(pattern.test(str));
}

//패스워드 체크
//숫자, 알파벳 소문자,대문자 입력된게 맞다면 4~15  true 틀리면 false
function check_password(str){
	var pattern = /^[0-9a-zA-Z]{4,15}$/;
	return(pattern.test(str));
}

function check_zipcode(str){
	var pattern = /^[0-9]{6}$/;
	return(pattern.test(str));
}

//숫자 체크 
//숫자 맞다면 true 틀리면 false
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
name (form.이름 ) , ivalue(Value)
예) optionValueSel(form.job , 2)
해당 옵션에서 밸류값 같은것을 셀렉트 시킨다.
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
예) optionValueRtn(form.name)
해당 옵션에서 선택된 밸류값을 리턴 시킨다.
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
예) optionTextRtn(form.name)
해당 옵션에서 선택된 텍스트값을 리턴 시킨다.
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
예) radioValueRtn(form.name)
라디오 버튼에서 선택한 것의 밸류값을 리턴한다
선택한것이 없다면 "" 공백을 리턴한다.
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
예) checkInsert ( name (form이름 ) , ivalue(Int형 Value) )
radio나 checkbox 에서 해당 밸류값과 같은것이 선택 되도록 한다.
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

//체크상자 초기화 체크된것을 모두 false 로 한다.
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



//이미지 자동 리사이즈 처리
var arrObjImg = new Array(); //이미지객체 담을 배열

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
		if(objImg.complete == false){//이미지가 로드 되지 않았다면
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
javascript로 구현한 Request
대소문자 구분없이
해당값이 없을때 "" 공백 리턴
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

//쓰기 document.write 
function dw(str){
	document.write(str); 
}


//익스플로러 패치에 따른 플래시 스크립로 write 처리
//(플래시주소,넓이,높이,넘겨받은값,아이디,이름,배경색)
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
폼안에 있는 값들을 인코딩해서 리턴한다.
예) formData2QueryString(document.pageForm)
리턴) gotoPage=3&col=1&search=
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
  함수 : currence(cur)
  목적 : 단위 값에 맞게 콤마를 표시한다
  방법 : cur (수치)
          예) currence("1000000")
        결과) 1,000,000
  리턴 : 결과 값
************************************************************/
function currence(cur)
{
  var i,c;
  var rev="";
  var tmp="";
  var ver="";
  var num="";

  // 먼저 comma가 있을시 제거 한다.
  for(i=0;i<cur.length;i++){
    if(cur.charAt(i) == ",")
      num += ""
    else
      num += cur.charAt(i)
  }
  // 우선 reverse를 한다.
  for(i=num.length;i>=0;--i)
      rev += num.charAt(i)

  // comma를 붙힌다.
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
  // 다시 reverse를 한다.
  for(i=tmp.length;i>=0;--i)
      ver += tmp.charAt(i)

  return ver;
}

/************************************************************
  함수 : window_center(넓이,높이)
  목적 : 예약창의 사이즈 조절
  방법 : window_center (넓이,높이)
          예) window_center(100,100)
        
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

