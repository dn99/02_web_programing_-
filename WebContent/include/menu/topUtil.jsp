<%@ page contentType="text/html; charset=EUC-KR" 
import="com.bnc.member.model.*"%>
<%
    String root = request.getContextPath();
	MemberDTO memberDTO= (MemberDTO)session.getAttribute("userInfo");
	if(memberDTO == null){
%>
<a href="<%=root%>/pages/member/login.jsp"><img src="<%=root%>/images/btn_login_s.gif" /></a> 
<a href="<%=root%>/pages/member/join.jsp"><img src="<%=root%>/images/top_util_01.gif" /></a>
<%-- <a href="<%=root%>/pages/member/booking.jsp"><img src="<%=root%>/images/top_util_02.gif" /></a>  --%>
<a href="<%=root%>/cusctrl?act=list&btype=6&pg=1"><img src="<%=root%>/images/top_util_03.gif" /></a>
<%}else{ %>
<a href="<%=root%>/memberctrl?act=logout"><img src="<%=root%>/images/btn_logout_s.jpg" /></a>
<a href="<%=root%>/pages/member/modify.jsp"><img src="<%=root%>/images/top_util_01_01.gif" /></a>
<%-- <a href="<%=root%>/memberctrl?act=list&pg=1&id=<%=memberDTO.getMember_id()%>"><img src="<%=root%>/images/top_util_02.gif" /></a>  --%>
<a href="<%=root%>/cusctrl?act=list&btype=6&pg=1"><img src="<%=root%>/images/top_util_03.gif" /></a>
<%} %>
