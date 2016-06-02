<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.member.model.MemberDTO"%>
<%
    String root = request.getContextPath();

	MemberDTO memberDTO= (MemberDTO)session.getAttribute("userInfo");
%>
<table height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
<!-- 스마트 예약 -->  
<%--<td><a href="<%=root%>/pages/reserve/reserve.jsp" onfocus="this.blur()"> --%>
    <td><a href="javascript:hs_openReserveAjax('<%=root%>')" onfocus="this.blur()">
    <img src="<%=root%>/images/top_memu_sp.gif" id="sp" name="sp" 
         onMouseOver="MM_swapImage('sp','','<%=root%>/images/top_memu_sp_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></td></a>
         
    <td width="30"></td>

<!-- 렌트카 -->     
    <td><a href="<%=root%>/carlist?act=page_list&pg=1" onfocus="this.blur()">
    <img src="<%=root%>/images/top_menu_01.gif" id="m1" name="m1" 
         onMouseOver="MM_swapImage('m1','','<%=root%>/images/top_menu_01_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></a><td>

<!-- 여행 상품 -->          
    <td><a href="<%=root%>/travel?act=page_list&pg=1" onfocus="this.blur()">
    <img src="<%=root%>/images/top_menu_02.gif" id="m2" name="m2" 
         onMouseOver="MM_swapImage('m2','','<%=root%>/images/top_menu_02_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></a><td>

<!-- 커뮤니티 -->          
    <td><a href="<%=root%>/comctrl?act=list&btype=5&pg=1" onfocus="this.blur()">
    <img src="<%=root%>/images/top_menu_03.gif" id="m3" name="m3" 
         onMouseOver="MM_swapImage('m3','','<%=root%>/images/top_menu_03_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></a><td>

<!-- 고객센터 -->          
    <td><a href="<%=root%>/cusctrl?act=list&btype=6&pg=1" onfocus="this.blur()">
    <img src="<%=root%>/images/top_menu_04.gif" id="m4" name="m4" 
         onMouseOver="MM_swapImage('m4','','<%=root%>/images/top_menu_04_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></a><td>
<%
	if ( memberDTO != null )
	{
%>
         
<!-- 마이페이지 -->          
    <td><a href="<%=root%>/memberctrl?act=list&pg=1&id=<%=memberDTO.getMember_id()%>" onfocus="this.blur()">
    <img src="<%=root%>/images/top_menu_05.gif" id="m5" name="m5" 
         onMouseOver="MM_swapImage('m5','','<%=root%>/images/top_menu_05_ov.gif',0)" 
         onMouseOut="MM_swapImgRestore()" /></a><td>
<%
	}
%>         
  </tr>
</table>