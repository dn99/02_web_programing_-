<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    import="com.bnc.member.model.*"%>

<% String root= request.getContextPath(); 
	MemberDTO memberDTO= (MemberDTO)session.getAttribute("userInfo");
	if(memberDTO == null)
 	response.sendRedirect(root+"/pages/member/login.jsp");
else{
%>
<tr>
  <td align="right">
  <table>
    <tr>
  	  <td>
  	  <%=memberDTO.getMember_name() %>(<%=memberDTO.getMember_id()%>)�� �ȳ��ϼ���.<br>
  	  </td>
<%--   	  <td>
  	  <a href="<%=root%>/memberctrl?act=logout">�α׾ƿ�</a>
  	  </td> --%>
    </tr>
  </table>
  </td>
</tr>
<%
}
%>