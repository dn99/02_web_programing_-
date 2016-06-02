<%@ page contentType="text/html; charset=EUC-KR" %>
<%@page import="com.bnc.props.AppProperties"%>
<%
    String root = request.getContextPath();

%>
<jsp:include page="/include/headerSub.jsp" flush="true" />
<jsp:include page="/include/contentStart.jsp" flush="true" />

<!-- 타이틀 시작 --> 
<table width="100%">
  <tr>
    <td valign="bottom">
    <img src="<%=root%>/images/bullet_01.gif"><span class="txt_head">스마트 예약</span>
    </td>
  </tr>
  <tr>
    <td height="15"></td>
  </tr>
</table>
<!-- 타이틀 끝 --> 
 
<!-- 단위작업 영역 시작 -->    
<img src="<%=root%>/images/sample_sub_02.jpg">
<!-- 단위작업 영역 끝 -->

<jsp:include page="/include/contentEnd.jsp" flush="true" />
<jsp:include page="/include/footerSub.jsp" flush="true" />  