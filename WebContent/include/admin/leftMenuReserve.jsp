<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<table width="100%" height="100%">
    <tr>
      <td height="40" align="right">
      <span class="txt_tit">예약 관리</span>
      </td>
    </tr>
    <tr>
     <td valign="top">
      <table width="100%">
        <tr>
         <td height="26" align="right" valign="middle">
         <a href="<%=root%>/reserve/adminRentList.action">예약현황<img src="<%=root%>/images/bullet_02.gif"></a>
         </td>
        </tr>
        <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
        <!--  
        <tr>
         <td height="26" align="right" valign="middle">
         <a href="">예약 통계<img src="<%=root%>/images/bullet_02.gif"></a>
         </td>
        </tr>
        -->
      </table>
     </td>
    </tr>
  </table>