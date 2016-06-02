<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<!-- flex Div 贸府 -->
<script type="text/javascript">
<!--
	var swfVersionStr = "10.0.0";
	var xiSwfUrlStr = "playerProductInstall.swf";
	
	var flashvars = {};
	flashvars.userId = ""; 
	
	var params = {};
	params.quality = "high";
	params.bgcolor = "#ffffff";
	params.wmode = "transparent";
	params.allowscriptaccess = "always";
	params.allowfullscreen = "true";
	
	var attributes = {};
	attributes.id = "mainapp";
	attributes.name = "mainapp";
	attributes.align = "middle";
	
	swfobject.embedSWF
	(
		"<%=root%>/flex-debug/CodeInfoApp.swf?ver=1.1", 
		"flashContent", 
		"100%", "100%", 
		swfVersionStr, 
		xiSwfUrlStr, 
		flashvars, 
		params, 
		attributes
	);
	swfobject.createCSS( "#flashContent", "display:block;text-align:left;" );

	function stopWheel(e){
	    if(!e){ e = window.event; } /* IE7, IE8, Chrome, Safari */
	    if(e.preventDefault) { e.preventDefault(); } /* Chrome, Safari, Firefox */
	    e.returnValue = false; /* IE7, IE8 */
	} 
	
	function setFlashDiv( isDisplay )
	{
		var element = document.getElementById( "flashContainer" );
		if ( isDisplay )
		{
			element.style.display = "block";
			//mainapp.height = document.body.scrollHeight;
			
			document.onmousewheel = function(){ stopWheel(); } /* IE7, IE8 */
			if( document.addEventListener ){ /* Chrome, Safari, Firefox */
			    document.addEventListener( 'DOMMouseScroll', stopWheel, false );
			}
		}	
		else
		{	
			element.style.display = "none";
			
			document.onmousewheel = null;  /* IE7, IE8 */
			if( document.addEventListener ){ /* Chrome, Safari, Firefox */
			    document.removeEventListener( 'DOMMouseScroll', stopWheel, false );
			} 
		}	
	}
//-->
</script>
<tr>
  <td height="30" align="right">
  <a href="javascript:setFlashDiv(true)" onfocus="this.blur"><font color="#FFFFFF">Flex Div</font></a>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <a href="<%=root%>/admin/index.jsp" target="_blank" onfocus="this.blur"><font color="#FFFFFF">包府磊</font></a>
  </td>
</tr>