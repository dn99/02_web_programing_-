<%@page import="com.bnc.community.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
	String root = request.getContextPath();
%>

<table height="100%" border=0 cellspacing=0 cellpadding=0>
  <tr>
	<td><img src="<%=root%>/images/main/new_title.gif"></td>
  </tr>
  <tr>
	<td height=10></td>
  </tr>
  
  <%
  	List<NoticeDTO> list = ( List<NoticeDTO> )request.getAttribute( "noticeList" );
  %>
  
  <s:iterator value="%{noticeList}" status="idx">
  <tr>
	<td height=18 style="font-size:8pt;line-height:150%">
	<img src="<%=root%>/images/main/dot01.gif">&nbsp;
	<a href="javascript:mi_goView_cus('<s:property value="%{seq}" />');">
	<font color=999999><s:property value="%{subject}" /></font>
	</a>
	<img src="<%=root%>/images/main/new.gif">
	</td>
  </tr>
  </s:iterator>
  
</table>