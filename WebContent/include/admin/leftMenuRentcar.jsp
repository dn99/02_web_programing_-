<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<table width="100%" height="100%">
    <tr>
      <td height="40" align="right">
      <span class="txt_tit">��Ʈī ����</span>
      </td>
    </tr>
    <tr>
     <td valign="top">
      <table width="100%">
        <tr>
         <td height="26" align="right" valign="middle">
         <a href="<%=root%>/admin/rentcar/index.jsp">���� ���<img src="<%=root%>/images/bullet_02.gif"></a>
         </td>
        </tr>
        <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
        <tr>
         <td height="26" align="right" valign="middle">
         <a href="<%=root%>/carlist?act=list">���� ����Ʈ<img src="<%=root%>/images/bullet_02.gif"></a>
         </td>
        </tr>
        <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      </table>
     </td>
    </tr>
  </table>