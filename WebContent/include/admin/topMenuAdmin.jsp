<%@ page contentType="text/html; charset=EUC-KR" %>
<%
    String root = request.getContextPath();
%>
<a href="<%=root%>/memberctrl?act=list_admin&pg=1" class="mainMenu">ȸ������</a>
<img src="<%=root%>/images/blank.gif" width="10" />|<img src="<%=root%>/images/blank.gif" width="10" />
<a href="<%=root%>/admin/rentcar/index.jsp" class="mainMenu">��Ʈī ����</a>
<img src="<%=root%>/images/blank.gif" width="10" />|<img src="<%=root%>/images/blank.gif" width="10" />
<a href="<%=root%>/admin/travel/index.jsp" class="mainMenu">�����ǰ ����</a>
<img src="<%=root%>/images/blank.gif" width="10" />|<img src="<%=root%>/images/blank.gif" width="10" />
<%-- <a href="<%=root%>/admin/community/index.jsp" class="mainMenu">Ŀ�´�Ƽ ����</a>
<img src="<%=root%>/images/blank.gif" width="10" />|<img src="<%=root%>/images/blank.gif" width="10" />
<a href="<%=root%>/admin/customer/index.jsp" class="mainMenu">������ ����</a>
<img src="<%=root%>/images/blank.gif" width="10" />|<img src="<%=root%>/images/blank.gif" width="10" /> --%>
<a href="<%=root%>/reserve/adminRentList.action" class="mainMenu">�������</a>