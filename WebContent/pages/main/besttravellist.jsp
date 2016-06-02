<%@page import="com.bnc.community.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="s" uri="/struts-tags" %>    
<%
	String root = request.getContextPath();
%>

<table border=0 cellspacing=0 cellpadding=0>
  <tr>
    <td></td>
    <td>
    
    <table border=0 cellspacing=0 cellpadding=0>
      <tr>
        <td><!--<img src="<%=root%>/images/main/hou_title.gif">--></td>
      </tr>
      <tr>
        <td width=775>
        
        <table width="100%" border=0 cellspacing=0 cellpadding=6 bgcolor=f2f2f2>
          <tr>
            <td>
       
            <table width="100%" border=0 cellspacing=0 cellpadding=4 bgcolor=ffffff>
              <tr>
              
              	<!-- 베스트 이벤트 시작 -->
              	<s:iterator value="%{bestTravelEventList}" status="idx">
              	
              	<td>
                <table border=0 cellspacing=0 cellpadding=0>
                  <tr>
                    <td>
                    <DIV id=event style="POSITION: absolute">
                    <IMG height=49 src="<%=root%>/images/main/event_001.gif" >
                    </DIV>
                    <a href="javascript:dk_page_goDetail('<s:property value="%{tour_seq}" />');">
                    <img src="<%=root%>/upload/travel/<s:property value="%{tour_spic}" />" width=155 border=0 height=100>
                    </a>
                    </td>
                  </tr>
                  <tr>
                    <td height=9></td>
                  </tr>
                  <tr>
                    <td style="font-size:8pt;line-height:150%">
                    <b><s:property value="%{tour_name}" /></b>
<!--                     <font color=999999>[펜션]</font> -->
                    </td>
                  </tr>
                  <tr>
                    <td height=3></td>
                  </tr>
                  <tr>
                    <td style="font-size:8pt;line-height:150%">
     				<img src="<%=root%>/images/main/do.gif" align="absmiddle"> 
     				<font color=669900>[1박2일]</font>&nbsp;
     				<b><font color=ff6600><s:property value="%{tour_price}" /> 원</font></b>
     				</td>
                  </tr>
                  <tr>
                    <td height=5></td>
                  </tr>
                </table>
                </td>
                
              	</s:iterator>
                <!-- 베스트 이벤트 끝 -->
                
                <td width="100%" valign=top>
                
                <table width="100%" valign="to">
                  <tr>
                    <td>
                    
                    <!-- 오른쪽 작은 상품 영역 시작 -->    
                    <table border=0 cellspacing=0 cellpadding=0>
                      <tr>
                      
                      	<!-- 베스트 노멀 시작 -->
              			<s:iterator value="%{bestTravelNormalList}" status="idx">
                        <td valign=top>
                       
                        <table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td colspan=5 height=3></td>
                          </tr>
                          <tr>
              				<td valign=top>
                            <table border=0 cellspacing=0 cellpadding=2 bgcolor=ffffff width=150>
                              <tr>
                                <td valign=top width=70>
                                <a href="javascript:dk_page_goDetail('<s:property value="%{tour_seq}" />');">
                                <img src="<%=root%>/upload/travel/<s:property value="%{tour_spic}" />" width=70 height=45 border=0>
                                </a>
                                </td>
                                <td valign=top width=80 style="font-size:8pt;line-height:150%">
                                <img src="<%=root%>/images/main/dot.gif" align="absmiddle">
                                <font color=669900><b><s:property value="%{tour_name}" /></b><br>
                                <font color=aaaaaa>[1박2일]</font><br>
                                <font color=666666><s:property value="%{tour_price}" /> 원</font>
                                </td>
                              </tr>
                            </table>
                            </td>
                            <td width=5></td>
                         </tr>
                       </table>
                       </td>
                       
                       <!-- 다음 행으로 처리 -->
					   <s:if test="%{#idx.count % 3 == 0}">
					   </tr>
					   <tr>
					   </s:if>
                       
                       </s:iterator>
                       <!-- 베스트 노멀 끝 -->
                       
                      </tr>
                    </table>  
                    <!-- 오른쪽 작은 상품 영역 끝 -->   
                    
                    </td>
                  </tr>
                  <tr>
                    <td colspan="3">
                    
                    <table width="100%" border=0 cellspacing=0 cellpadding=0>
                    
                      <!-- 베스트 라인 시작 -->
              		  <s:iterator value="%{bestTravelLineList}" status="idx">
              		  
                      <tr>
                        <td height=16 style="font-size:8pt;line-height:150%">
                        <img src="<%=root%>/images/main/dot.gif" align="absmiddle">
                        <a href="javascript:dk_page_goDetail('<s:property value="%{tour_seq}" />');">
                        <font color=666666><s:property value="%{tour_name}" /></font>&nbsp;&nbsp;&nbsp;
                        <font color=999999><s:property value="%{tour_content}" /></font>&nbsp;&nbsp;&nbsp;
                        <font color=999999><s:property value="%{tour_price}" />원</font>
                        </a>
                        </td>
                      </tr>
                    
                      </s:iterator>
                      <!-- 베스트 라인 끝 -->
                      
                    </table>
                    
                    </td>
                  </tr>
                
                </table>
                
                </td>
              </tr>
             </table>
             
             </td>
           </tr>
         </table>
        
        </td>
      </tr>
    </table>
    
    </td>
  </tr>	
</table>