<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<table width="100%">
  <tr>
   <td>
    <table width="100%">
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/comctrl?act=list&btype=5&pg=1">공지사항<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/comctrl?act=list&btype=1&pg=1">추천 드라이브 코스<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/comctrl?act=list&btype=2&pg=1">자동차 리뷰/시승기<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/comctrl?act=list&btype=3&pg=1">렌트카 여행기<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/comctrl?act=list&btype=4&pg=1">자동차 프리뷰/카달로그<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
    </table>
   </td>
   <td width="10"><img src="<%=root%>/images/blank.gif" width="10" /></td>
  </tr>
</table>