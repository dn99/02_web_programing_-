<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<jsp:include page="/include/admin/headerAdmin.jsp" flush="true" />
<jsp:include page="/include/admin/contentAdminStart.jsp" flush="true" />

<!-- 타이틀 시작 --> 
<table width="100%">
  <tr>
    <td valign="bottom">
    <img src="<%=root%>/images/bullet_01.gif"><span class="txt_head">예약현황 목록</span>
    </td>
  </tr>
  <tr>
    <td height="15"></td>
  </tr>
</table>
<!-- 타이틀 끝 --> 
 
<!-- 단위작업 영역 시작 -->    
<table width="100%">
  <tr>
  	<td>SEQ</td>
  	<td>ID</td>
  	<td>CAR</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  	<td>SEQ</td>
  </tr>
</table>
<!-- 단위작업 영역 끝 -->

<jsp:include page="/include/admin/contentAdminEnd.jsp" flush="true" />    
<jsp:include page="/include/admin/footerAdmin.jsp" flush="true" />