<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<table width="100%" height="100%">
    <tr>
      <td height="40" align="right">
      <span class="txt_tit">커뮤니티 관리</span>
      </td>
    </tr>
    <tr>
     <td valign="top">
      <table width="100%">
        <tr>
         <td height="26" align="right" valign="middle">
         <a href="<%=root%>/cusctrl?act=list&btype=6&pg=1">고객센터 페이지 이동<img src="<%=root%>/images/bullet_02.gif"></a>
         </td>
        </tr>
      </table>
     </td>
    </tr>
  </table>