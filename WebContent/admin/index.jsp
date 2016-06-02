<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<jsp:include page="/include/admin/headerAdmin.jsp" flush="true" />
<jsp:include page="/include/admin/contentAdminStart.jsp" flush="true" />

<!-- 단위작업 영역 시작 -->
<table width="100%" height="100%">
  <tr>
    <td align="center" valign="middle"><img src="<%=root%>/images/adminMain.JPG"></td>
  </tr>
</table> 
<!-- 단위작업 영역 끝 -->

<jsp:include page="/include/admin/contentAdminEnd.jsp" flush="true" />    
<jsp:include page="/include/admin/footerAdmin.jsp" flush="true" /> 