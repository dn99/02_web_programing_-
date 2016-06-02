<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.util.StringUtil"%>
<%
    String root = request.getContextPath();

	String pathInfo[] = ( request.getRequestURI() ).split( "/" );
	String leftMenuPath = "/include/admin/";
	String titlePath = root + "/images/";
	if ( StringUtil.hasContain( pathInfo, "reserve" ) )
	{
	    leftMenuPath += "leftMenuReserve.jsp";
	    titlePath += "left_title_01.jpg";
	}
	else if ( StringUtil.hasContain( pathInfo, "rentcar" ) )
	{
	    leftMenuPath += "leftMenuRentcar.jsp";
	    titlePath += "left_title_02.jpg";
	}
	else if ( StringUtil.hasContain( pathInfo, "travel" ) )
	{
	    leftMenuPath += "leftMenuTravel.jsp";
	    titlePath += "left_title_03.jpg";
	}
	else if ( StringUtil.hasContain( pathInfo, "community" ) )
	{
	    leftMenuPath += "leftMenuCommunity.jsp";
	    titlePath += "left_title_04.jpg";
	}
	else if ( StringUtil.hasContain( pathInfo, "customer" ) )
	{
	    leftMenuPath += "leftMenuCustomer.jsp";
	    titlePath += "left_title_05.jpg";
	}
	else if ( StringUtil.hasContain( pathInfo, "member" ) )
	{
	    leftMenuPath += "leftMenuMember.jsp";
	    titlePath += "left_title_06.jpg";
	}
%>
<table width="100%" height="100%" border="1">
 <tr>
   <td width="180" align="center" valign="middle" class="padding10">
   <!-- 좌측메뉴 시작 -->
   <jsp:include page="<%=leftMenuPath%>" flush="true" />
   <!-- 좌측메뉴 끝 -->
   </td>
   <td align="left" valign="top" class="padding20">