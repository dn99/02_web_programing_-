<%@ page contentType="text/html; charset=EUC-KR" 
import = "com.bnc.util.*, java.util.*, com.bnc.member.model.*"    %>

<%
    String root = request.getContextPath();
	MemberDTO memberDTO = (MemberDTO)session.getAttribute("userInfo");
%>
<table width="100%">
  <tr>
   <td>
  
    <table width="100%">
     <%if(memberDTO != null){ %>
    <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/memberctrl?act=list&pg=1&id=<%=memberDTO.getMember_id()%>">차량 예약 현황<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/memberctrl?act=list_trent&pg=1&id=<%=memberDTO.getMember_id()%>">상품 예약 현황<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
    
    
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/pages/member/modify.jsp">회원정보수정<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <tr><td height="1" background="<%=root%>/images/line_dot_01.gif"></td></tr>
      <tr>
       <td height="26" align="right" valign="middle">
       <a href="<%=root%>/pages/member/delete.jsp">회원 탈퇴<img src="<%=root%>/images/bullet_02.gif"></a>
       </td>
      </tr>
      <%} %>
    </table>
   </td>
   <td width="10"><img src="<%=root%>/images/blank.gif" width="10" /></td>
  </tr>
</table>
