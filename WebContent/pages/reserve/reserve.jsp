<%@ page contentType="text/html; charset=EUC-KR" %>
<%@page import="com.bnc.props.AppProperties"%>
<%
    String root = request.getContextPath();

%>
<jsp:include page="/include/headerSub.jsp" flush="true" />
<jsp:include page="/include/contentStart.jsp" flush="true" />

<!-- Ÿ��Ʋ ���� --> 
<table width="100%">
  <tr>
    <td valign="bottom">
    <img src="<%=root%>/images/bullet_01.gif"><span class="txt_head">����Ʈ ����</span>
    </td>
  </tr>
  <tr>
    <td height="15"></td>
  </tr>
</table>
<!-- Ÿ��Ʋ �� --> 
 
<!-- �����۾� ���� ���� -->    
<img src="<%=root%>/images/sample_sub_02.jpg">
<!-- �����۾� ���� �� -->

<jsp:include page="/include/contentEnd.jsp" flush="true" />
<jsp:include page="/include/footerSub.jsp" flush="true" />  