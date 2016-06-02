var root = "/BNCRent/";

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function getCookie(name) {
	var Found = false;
	var start,end;
	var i = 0;
	while (i <= document.cookie.length) {
		start = i;
		end = start + name.length;
		if (document.cookie.substring(start,end) == name) {
			Found = true;
			break;
		}
		i++;
	}
	if (Found) {
		start = end + 1;
		end = document.cookie.indexOf(";",start);
		if (end < start) end = document.cookie.length;
			return document.cookie.substring(start,end);
	}
	return "";
} 

function smartPopup(url,name,feature) {
	if ( getCookie('OpenPopupAgainA') != 'no') {
		window.open(url,name,feature);
	}
}

function isNull( value )
{
	var isNull = true;
	if ( value != "" && value != null ) isNull = false;
	
	return isNull;
}

//콤마삽입 (number_format)
function commaSplit(srcNumber) 
{ 
	var txtNumber = '' + srcNumber; 

	var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])'); 
	var arrNumber = txtNumber.split('.'); 
	arrNumber[0] += '.'; 
	do { 
		arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2'); 
	} 
	while (rxSplit.test(arrNumber[0])); 
	if (arrNumber.length > 1) { 
		return arrNumber.join(''); 
	} 
	else { 
		return arrNumber[0].split('.')[0]; 
	} 
}

//콤마제거
function filterNum(str) 
{ 
	re = /^\$|,/g; 
	return str.replace(re, ""); 
}

//좌우공간없애기
function trim(txt)
{
	return txt.replace(/(^\s*)|(\s*$)/g, "");
}

//숫자형
function isDigit(val, allowable)
{
	var	valid =	true;
	var	cmp	= "0123456789" + allowable;
	var bb;
	for	(var i=0; i<val.length;	i++) {
		if ( cmp.indexOf(val.charAt(i)) < 0)	{
			valid =	false;
			break;
		}
	}
	return valid;
}

//한글체크함수
function h_check(Objectname) 
{ 
	var intErr;
	var strValue = Objectname;
	var retCode = 0;
	for (i = 0; i < strValue.length; i++) {
		var retCode = strValue.charCodeAt(i);
		var retChar = strValue.substr(i,1).toUpperCase();
		retCode = parseInt(retCode);
		if ((retChar < '0' || retChar > '9') && (retChar < 'A' || retChar > 'Z') && ((retCode > 255) || (retCode < 0))) {
				intErr = -1;
				break;
		}
	}
	return (intErr);
}

//web browser size
function getBrowserSizeJS() 
{
	//var w = document.viewport.getWidth();
	//var h = document.viewport.getHeight();
	var w = document.body.clientWidth;
	var h = document.body.clientHeight;
	return w + "#" + h;
}

//web browser viewpoint scroll pos
function getScrollPosJS() 
{
	return document.viewport.getScrollOffsets();		
}

//web browser height + hidden area height
function getScrollHeight()
{
	return document.body.scrollHeight;
}

//flex height size control
function setViewHeight( vh )
{
	mainapp.height = vh;
}

/**
<div id='besthousemenu0' style="display:">
<table border=0 cellspacing=0 cellpadding=0>
  <tr>
	<td><img src="<%=root%>/images/main/chu_title.gif"></td>
	<td width=10></td>
	<td><img src="<%=root%>/images/main/best_01_1.gif"></td>
	<td><img src="<%=root%>/images/main/best_02.gif" style="cursor:hand" 
			 onMouseOver="ShowHideLayer(1, 2, 'besthousemenu');ShowHideLayer(1, 2, 'besthouse');document.getElementById('besthousemenu0').style.display = 'none';"></td>
  </tr>
</table>
</div>


<div id='besthousemenu1' style="display:none">
<table border=0 cellspacing=0 cellpadding=0>
  <tr>
	<td><img src="<%=root%>/images/main/chu_title.gif"></td>
	<td width=10></td>
	<td><img src="<%=root%>/images/main/best_01.gif" style="cursor:hand" 
			 onMouseOver="ShowHideLayer(0, 2, 'besthousemenu');ShowHideLayer(0, 2, 'besthouse');document.getElementById('besthousemenu1').style.display = 'none';"></td>
	<td><img src="<%=root%>/images/main/best_02_1.gif"></td>
  </tr>
</table>
</div>
*/

//레이어 보이고 감추기 2007-10-26
//ShowHideLayer(선택된 아이템 번호, 아이템 총갯수, 레이어이름)
//사용시 레이어이름에 번호를 먹일때는 0부터 시작한다.
function ShowHideLayer( selecteditem, totalitem, layername ) 
{
	for( i=0; i<totalitem; i++ )
	{
		document.getElementById( layername+i ).style.display = "none";
	}
	document.getElementById( layername+selecteditem ).style.display = "inline";
}


