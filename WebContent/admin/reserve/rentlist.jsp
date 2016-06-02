<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.util.PageNavi"%>
<%@ page import="com.bnc.reserve.model.RentDTO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String root = request.getContextPath();
	PageNavi navigator = ( PageNavi )request.getAttribute( "navigator" );
	String naviHTML = navigator.pageNavi().toString();
%>
<jsp:include page="/include/admin/headerAdmin.jsp" flush="true" />
<jsp:include page="/include/admin/contentAdminStart.jsp" flush="true" />
<script type="text/javascript">
<!--
	//이벤트 핸들러 - 페이지 클릭
	function hs_goRentList( pg )
	{
		document.location.href = "<%=root%>/reserve/adminRentList.action?pg=" + pg;
	}
//-->
</script>

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
<table width="100%" border="1" cellspacing="2" cellpadding="3">
  <tr>
  	<td align="center">SEQ</td>
  	<td align="center">ID</td>
  	<td align="center">CAR</td>
  	<td align="center">대여일시</td>
  	<td align="center">반납일시</td>
  	<td align="center">대여지점</td>
  	<td align="center">반납지점</td>
  	<td align="center">보험</td>
  	<td align="center">네비여부</td>
  	<td align="center">할인률</td>
  	<td align="center">총이용기간</td>
  	<td align="center">정상요금</td>
  	<td align="center">적용금액</td>
  </tr>
  <s:iterator value="%{rentList}" status="rentList">
  <tr>
  	<td align="center"><s:property value="%{rent_seq}" /></td>
  	<td align="center"><s:property value="%{rent_member_id}" /></td>
  	<td align="center"><s:property value="%{rent_car_seq}" /></td>
  	<td align="center"><s:property value="%{rent_rday}" /> <s:property value="%{rent_rtime}" /></td>
  	<td align="center"><s:property value="%{rent_retday}" /> <s:property value="%{rent_rettime}" /></td>
  	<td align="center">[<s:property value="%{rlocationList.get(#rentList.index)}" />] <s:property value="%{rofficeList.get(#rentList.index)}" />점</td>
  	<td align="center">[<s:property value="%{retlocationList.get(#rentList.index)}" />] <s:property value="%{retofficeList.get(#rentList.index)}" />점</td>
  	<td align="center"><s:property value="%{insuranceList.get(#rentList.index)}" /> (<s:property value="%{insurancePriceList.get(#rentList.index)}" />원)</td>
  	<td align="center"><s:property value="%{rent_navicheck}" /></td>
  	<td align="center"><s:property value="%{rent_dc}" />%</td>
  	<td align="center"><s:property value="%{rent_totalday}" />일 <s:property value="%{rent_totaltime}" />시간</td>
  	<td align="center"><s:property value="%{rent_price}" />원</td>
  	<td align="center"><s:property value="%{rent_totalprice}" />원</td>
  </tr>
  </s:iterator>
</table>
<!-- 하단 페이징 -->
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td colspan="3" height="5"></td>
	</tr>
	<tr valign="top">
		<td nowrap>
		<td id="pageCell" width="100%" align="center">
		<!--PAGE--> 
		<%=naviHTML%>
		</td>
		<td nowrap class="stext">
		<%--<b><%=navigator.No()%></b> / <%=navigator.getTotalPage()%>pages --%>
		<b><s:property value="navigator.No()" /></b> / <s:property value="navigator.getTotalPage()" />pages
		</td>
	</tr>
</table>
<!-- 단위작업 영역 끝 -->

<jsp:include page="/include/admin/contentAdminEnd.jsp" flush="true" />    
<jsp:include page="/include/admin/footerAdmin.jsp" flush="true" />