<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<jsp:include page="/include/admin/headerAdmin.jsp" flush="true" />
<jsp:include page="/include/admin/contentAdminStart.jsp" flush="true" />

<!-- Ÿ��Ʋ ���� --> 
<table width="100%">
  <tr>
    <td valign="bottom">
    <img src="<%=root%>/images/bullet_01.gif"><span class="txt_head">������Ȳ ���</span>
    </td>
  </tr>
  <tr>
    <td height="15"></td>
  </tr>
</table>
<!-- Ÿ��Ʋ �� --> 
 
<!-- �����۾� ���� ���� -->    
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
<!-- �����۾� ���� �� -->

<jsp:include page="/include/admin/contentAdminEnd.jsp" flush="true" />    
<jsp:include page="/include/admin/footerAdmin.jsp" flush="true" />