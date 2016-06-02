<%@ page contentType="text/html; charset=EUC-KR" %>
<%
	String root = request.getContextPath();
%>
		</td>
	  </tr>
	</table>	
  	</td>
  </tr>
  
  <tr>
  	<td height="120" align="center" valign="middle" class="bg_bottom">
  	<table width="980" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  <tr>
  	  	<td height="6" bgcolor="#0072bc" colspan="3"></td>
  	  </tr>
  	  <tr>
  	    <td width="20"></td>
  	    <td width="120" valign="middle"><img src="<%=root%>/images/bottom_logo.gif" /></td>
  	  	<td valign="middle" align="left">
  	  	<jsp:include page="/include/menu/bottomMain.jsp" flush="true" />
  	  	</td>
  	  </tr>
  	</table>
  	</td>
  </tr>
  
</table>
</body>
</html>