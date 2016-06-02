<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.util.StringUtil"%>
<%
    String root = request.getContextPath();

    String pathInfo[] = ( request.getRequestURI() ).split( "/" );
    String leftMenuPath = "/include/menu/";
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
<table width="980" height="100%">
  <tr>
    <td width="200" align="right">
    <table width="100%" height="100%">
      <tr>
        <td height="230">
        <img src="<%=titlePath%>">
        </td>
      </tr>
      <tr>
        <td valign="top">
        <!-- 좌측 메뉴 시작 -->
        <jsp:include page="<%=leftMenuPath%>" flush="true" />
        <!-- 좌측 메뉴 끝 -->
        </td>
      </tr>
      <tr>
        <td height="20"></td>
      </tr>
      <tr>
        <td valign="top">
        <!-- 배너 시작 -->
        <jsp:include page="/include/menu/leftBanner.jsp" flush="true" />
        <!-- 배너 끝 -->
        </td>
      </tr>
    </table>
    </td>
    <td>
    <img src="<%=root%>/images/blank.gif" width="50">
    </td>
    <td>