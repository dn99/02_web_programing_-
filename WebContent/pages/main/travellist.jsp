<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
	String root = request.getContextPath();
%>    

<table width="100%" border=0 cellspacing=0 cellpadding=0>
 <tr>
   <td><img src="<%=root%>/images/main/ch_title3.gif"></td>
 </tr>
 <tr>
   <td>
   <table border=0 cellpadding=0 cellspacing=0>
     <tr>
   	<td valign=top width=220 bgcolor=f7f7f7 align=center>
   
   	<table border=0 cellpadding=5 cellspacing=0>
      <tr>
       	<td valign=top>
       
        <table border=0 cellpadding=0 cellspacing=0>
          <tr>
         	<td><DIV id=event style="POSITION: absolute"><IMG src="<%=root%>/images/main/event_001.gif"></DIV>
         	<a href="javascript:dk_page_goDetail('<s:property value="%{tour_seq}" />');">
         	<img src="<%=root%>/upload/travel/<s:property value="%{travelList.get(0).tour_spic}" />" width=200 border=0>
         	</a>
         	</td>
          </tr>
          <tr>
         	<td>
         	<span style="color:#999999;font-family:µ¸¿ò;font-size:11px;">
<%--          	[<s:property value="%{makerList.get(0)}" />]&nbsp; --%>
         	<s:property value="%{travelList.get(0).tour_name}" />
         	</span>
         	</td>
          </tr>
          <tr>
         	<td>
         	<span style="color:#009966;font-family:µ¸¿ò;font-size:11px;">
         	<b><s:property value="%{travelList.get(0).tour_price}" />¿ø</b>
         	</span>
         	</td>
          </tr>
        </table>

       	</td>
         </tr>
       </table>
   
		</td>
       <td>
       
       <table width="100%" border=0 cellpadding=5 cellspacing=0>
         <tr>
         <s:iterator value="%{travelList}" status="idx">
         	<td valign=top>
         	<table border=0 cellpadding=0 cellspacing=0>
              <tr>
           		<td>
           		<a href="javascript:dk_page_goDetail('<s:property value="%{tour_seq}" />');">
           		<img src="<%=root%>/upload/travel/<s:property value="%{tour_spic}" />" width=120 height=77 border=0>
           		</a>
           		</td>
              </tr>
              <tr>
           		<td>
           		<span style="color:#999999;font-family:µ¸¿ò;font-size:11px;">
<%--            		[<s:property value="%{makerList.get(#idx.index)}" />] --%>
           		&nbsp;<s:property value="%{tour_name}" />
           		</span>
           		</td>
              </tr>
              <tr>
           		<td>
           		<span style="color:#009966;font-family:µ¸¿ò;font-size:11px;">
           		<b><s:property value="%{tour_price}" />¿ø</b>
           		</span>
           		</td>
              </tr>
            </table>
         	</td>
         	
			<!-- ´ÙÀ½ ÇàÀ¸·Î Ã³¸® -->
			<s:if test="%{#idx.count % 6 == 0}">
			</tr>
			<tr>
			</s:if>

	        </s:iterator>
         </tr>
        </table>
        
        </td>
      </tr>
    </table>
    </td>
  </tr>
</table>