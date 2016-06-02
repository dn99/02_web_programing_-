<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<jsp:include page="/include/head.jsp" flush="true" />
<body>

<div id="flashContainer" style='position:absolute;left:0;top:0;width:100%;height:100%;display:none'>
	<div id="flashContent" style='z-index:100;position:absolute;left:0;top:0;width:100%;height:100%'></div>
</div>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="130" align="center" class="bg_top">
    <table width="980" height="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>
        <table width="100%" height="90" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><a href="<%=root%>/index.jsp" onfocus="this.blur()"><img src="<%=root%>/images/top_img.jpg" /></a></td>
            <td align="right" valign="bottom">
            <table border="0" cellspacing="0" cellpadding="0">
              <jsp:include page="/include/menu/topTempMenu.jsp" flush="true" />
              <jsp:include page="/include/menu/topUserInfo.jsp" flush="true" />
              <tr>
                <td>
                <!-- 유틸메뉴 시작 -->
                <jsp:include page="/include/menu/topUtil.jsp" flush="true" />
                <!-- 유틸메뉴 끝 -->
                </td>
              </tr>
              <tr>
                <td height="10"></td>
              </tr>
            </table>
            </td>
          </tr>
        </table>
        </td>
      </tr>
      <tr>
        <td height="40">
        <!-- 상단메뉴 시작 -->
        <jsp:include page="/include/menu/topMain.jsp" flush="true" />
        <!-- 상단메뉴 끝 -->
        </td>
      </tr>
    </table>
    </td>
  </tr>