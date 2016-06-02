<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<jsp:include page="/include/head.jsp" flush="true" />
<body>
<table width="100%" height="100%" border="1">
  <tr>
    <td height="80">
    <table width="100%">
      <tr>
        <td>
        <table width="100%">
          <tr>
            <td width="100"></td>
            <td align="center">
            <a href="<%=root%>/admin/index.jsp"><h3>BNCRent 관리자 !!</h3></a>
            </td>
            <td width="100" align="right" valign="bottom">
            <a href="<%=root%>/index.jsp" target="_blank"><h6>BNCRent 바로가기<img src="<%=root%>/images/blank.gif" width="20" /></h6></a>
            </td>
          </tr>
        </table>
        </td>
      </tr>
      <tr>
        <td align="center">
        <!-- 상단메뉴 시작 -->
		<jsp:include page="/include/admin/topMenuAdmin.jsp" flush="true" />
        <!-- 상단메뉴 끝 -->
        </td>
      </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td align="center">