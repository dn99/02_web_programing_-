<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.util.StringUtil"%>

<jsp:include page="/include/head.jsp" flush="true" />
<jsp:include page="/include/header.jsp" flush="true" />
<%
	String root = request.getContextPath();

	String pathInfo[] = ( request.getRequestURI() ).split( "/" );
	String optionPath = root + "/images/";
	if ( StringUtil.hasContain( pathInfo, "reserve" ) )
		optionPath += "option_sub_01.jpg";
	else if ( StringUtil.hasContain( pathInfo, "rentcar" ) )
		optionPath += "option_sub_02.jpg";
	else if ( StringUtil.hasContain( pathInfo, "travel" ) )
		optionPath += "option_sub_03.jpg";
	else if ( StringUtil.hasContain( pathInfo, "community" ) )
		optionPath += "option_sub_04.jpg";
	else if ( StringUtil.hasContain( pathInfo, "customer" ) )
		optionPath += "option_sub_05.jpg";
	else if ( StringUtil.hasContain( pathInfo, "member" ) )
		optionPath += "option_sub_06.jpg";
%>  
  <tr>
  	<td align="center" class="bg_middle">
  	<table height="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td>
		<table height="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr><td><img src="<%=optionPath%>" /></td></tr>
		  <tr><td>