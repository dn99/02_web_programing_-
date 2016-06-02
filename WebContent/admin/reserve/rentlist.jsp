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
	//�̺�Ʈ �ڵ鷯 - ������ Ŭ��
	function hs_goRentList( pg )
	{
		document.location.href = "<%=root%>/reserve/adminRentList.action?pg=" + pg;
	}
//-->
</script>

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
<table width="100%" border="1" cellspacing="2" cellpadding="3">
  <tr>
  	<td align="center">SEQ</td>
  	<td align="center">ID</td>
  	<td align="center">CAR</td>
  	<td align="center">�뿩�Ͻ�</td>
  	<td align="center">�ݳ��Ͻ�</td>
  	<td align="center">�뿩����</td>
  	<td align="center">�ݳ�����</td>
  	<td align="center">����</td>
  	<td align="center">�׺񿩺�</td>
  	<td align="center">���η�</td>
  	<td align="center">���̿�Ⱓ</td>
  	<td align="center">������</td>
  	<td align="center">����ݾ�</td>
  </tr>
  <s:iterator value="%{rentList}" status="rentList">
  <tr>
  	<td align="center"><s:property value="%{rent_seq}" /></td>
  	<td align="center"><s:property value="%{rent_member_id}" /></td>
  	<td align="center"><s:property value="%{rent_car_seq}" /></td>
  	<td align="center"><s:property value="%{rent_rday}" /> <s:property value="%{rent_rtime}" /></td>
  	<td align="center"><s:property value="%{rent_retday}" /> <s:property value="%{rent_rettime}" /></td>
  	<td align="center">[<s:property value="%{rlocationList.get(#rentList.index)}" />] <s:property value="%{rofficeList.get(#rentList.index)}" />��</td>
  	<td align="center">[<s:property value="%{retlocationList.get(#rentList.index)}" />] <s:property value="%{retofficeList.get(#rentList.index)}" />��</td>
  	<td align="center"><s:property value="%{insuranceList.get(#rentList.index)}" /> (<s:property value="%{insurancePriceList.get(#rentList.index)}" />��)</td>
  	<td align="center"><s:property value="%{rent_navicheck}" /></td>
  	<td align="center"><s:property value="%{rent_dc}" />%</td>
  	<td align="center"><s:property value="%{rent_totalday}" />�� <s:property value="%{rent_totaltime}" />�ð�</td>
  	<td align="center"><s:property value="%{rent_price}" />��</td>
  	<td align="center"><s:property value="%{rent_totalprice}" />��</td>
  </tr>
  </s:iterator>
</table>
<!-- �ϴ� ����¡ -->
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
<!-- �����۾� ���� �� -->

<jsp:include page="/include/admin/contentAdminEnd.jsp" flush="true" />    
<jsp:include page="/include/admin/footerAdmin.jsp" flush="true" />