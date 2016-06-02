<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.props.CodeProperties"%>
<%
	String root = request.getContextPath();

	CodeProperties.setCodeList();
%>
<html>
<head>
<title>::::::::::: BNC Rent :::::::::::</title>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="imagetoolbar" content="no">
<link rel="stylesheet" href="<%= root %>/css/style.css" type="text/css">
<link rel="stylesheet" href="<%= root %>/css/jquery.ui.all.css" type="text/css">
<script src="<%= root %>/js/common.js" type="text/javascript"></script>
<script src="<%= root %>/js/embed_patch.js" type="text/javascript"></script>
<script src="<%= root %>/js/httprequest.js" type="text/javascript"></script>
<script src="<%= root %>/js/jquery-1.5.1.js" type="text/javascript"></script>
<script src="<%= root %>/js/jquery.ui.datepicker.js" type="text/javascript"></script>
<script src="<%= root %>/js/jquery.ui.core.js" type="text/javascript"></script>
<script src="<%= root %>/js/customer.js" type="text/javascript"></script>
<script src="<%= root %>/js/community.js" type="text/javascript"></script>
<script src="<%= root %>/js/member.js" type="text/javascript"></script>
<script src="<%= root %>/js/rentcar.js" type="text/javascript"></script>
<script src="<%= root %>/js/reserve.js" type="text/javascript"></script>
<script src="<%= root %>/js/travel.js" type="text/javascript"></script>
<script src="<%= root %>/js/swfobject.js" type="text/javascript"></script>

<!-- Alice  -->
<%--  <link rel="stylesheet" type="text/css" HREF="<%=root%>/css/alice.css">
	<link rel="stylesheet" type="text/css" HREF="<%=root%>/css/oz.css">
	<script type="text/javascript" src="<%=root%>/js/prototype.js"></script>
	<script type="text/javascript" src="<%=root%>/js/extprototype.js"></script>	
	<script type="text/javascript" src="<%=root%>/js/oz.js"></script>	
	<script type="text/javascript" src="<%=root%>/js/alice.js"></script>  --%>

</head>