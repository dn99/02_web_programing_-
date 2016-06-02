<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.common.model.CodeInfoDTO"%>
<%@ page import="com.bnc.props.CodeProperties"%>
<%@ page import="com.bnc.member.model.MemberDTO"%>
<%@ page import="com.bnc.util.DateUtil"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String root = request.getContextPath();

	String currentDay = DateUtil.getCurrentDate( DateUtil.FORMAT_DATE_DAY );
	String currentTime = DateUtil.getCurrentDate( DateUtil.FORMAT_DATE_TIME );
	Date date = DateUtil.getDayStrToDate( currentDay );
	
	System.out.println( "CURRENT DAY : " + currentDay );
	System.out.println( "CURRENT TIME : " + currentTime );
	System.out.println( "DATE : " + date );
	
	String numStr = "";
	String location = "";
	
	int codeType = 0;
	int codeOffice = 0;
	int codeCarLo = 0;
	
	codeType = CodeProperties.GRADE; 
	
	MemberDTO memberDTO = ( MemberDTO )session.getAttribute( "userInfo" );
	
	String userid = "";
	if ( memberDTO != null ) userid = memberDTO.getMember_id();
%>
<jsp:include page="/include/headerMain.jsp" flush="true" />
<script type="text/javascript">
<!--
	//대여/반납 시간 정보를 조합하여 반환
	function getTimeValue( isR )
	{
		var timeValue = "";
		var idH = isR ? "cbRtimeH" : "cbRettimeH";
		var idM = isR ? "cbRtimeM" : "cbRettimeM";
		var hh = document.getElementById( idH ).value;
		var mm = document.getElementById( idM ).value;
		var ss = "00";
		
		if ( !isNull( hh ) && !isNull( mm ) )
			timeValue = hh + ":" + mm + ":" + ss;
		
		return timeValue;
	}

	//날짜 문자열(2011.10.24)을 Date 객체로 반환
	function getStrToDate( dayStr )
	{
		var days = getSplitValues( dayStr, "." );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ) );
		
		return date;
	}

	// 값이 '|'로 연결된 문자열을 분리하여 배열에 담아 반환
	function getSplitValues( valueStr, del )
	{
		var values = valueStr.split( del );
		
		return values;
	}
	
	//선택한 날짜의 유효성 체크
	function checkDateValidate( dateStr, dateStartStr )
	{
		var currentDate = getStrToDate( "<%=currentDay%>" );
		var selectedDate = getStrToDate( dateStr );
		
		var startDate = "";
		var dateStartGap = 0;
		if ( !isNull( dateStartStr ) ) 
		{
			startDate = getStrToDate( dateStartStr );
			dateStartGap = selectedDate.getTime() - startDate.getTime();
			if ( dateStartGap <= 0 )
			{
				document.getElementById( "retdatepicker" ).value = "선택";
				alert( "시작 날짜 이후로 선택하셔야 합니다." );
				return false;
			}	
		}
		
		var dateCurrentGap = selectedDate.getTime() - currentDate.getTime();
		if ( dateCurrentGap <= 0 ) 
		{
			document.getElementById( "rdatepicker" ).value = "선택";
			alert( "오늘 날짜 이후로 선택하셔야 합니다." );
			return false;
		}
		else
		{
			return true;
		}	
	}

	// 해당 셀의 값 반환
	function getCellValue( elementId )
	{
		return document.getElementById( elementId ).value;
	}
	
	//폼에 선택한 값을 입력
	function setValue( elementId, value )
	{
		var form = document.reserveForm;
		form[elementId].value = value;
	}
	
	// 폼에 입력된 값을 반환
	function getValue( elementId )
	{
		var form = document.reserveForm;
		return form[elementId].value;
	}

	// 입력된 값의 유효성 체크 및 유효여부 반환
	function hasValidateValue( elementId, isInt )
	{
		var isValidateValue = false;
		var value = getValue( elementId );
		
		if ( !isNull( value ) )
		{
			if ( isInt )
			{	
				var valueInt = parseInt( value );
				if( valueInt != Infinity && !isNaN( valueInt ) )
					isValidateValue = true;
			}	
			else
			{
				isValidateValue = true;
			}
		}
		
		return isValidateValue;
	}
	
	// 예약 정보 등록 전 입력값의 유효성 체크
	function validateValue()
	{
		if ( !hasValidateValue( 'hdRday', false ) ) 
		{
			alert( "대여일을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdRtime', false ) ) 
		{
			alert( "대여시간을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdRetday', false ) ) 
		{
			alert( "반납일을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdRettime', false ) ) 
		{
			alert( "대여시간을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdRlocation', true ) || !hasValidateValue( 'hdRoffice', true ) ) 
		{
			alert( "대여점을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdRetlocation', true ) || !hasValidateValue( 'hdRetoffice', true ) ) 
		{
			alert( "반납점을 선택해주세요." );
			return false;
		}
		
		return true;
	}
	
	//이벤트핸들러 - 대여일 선택
	function onChangeRday( element )
	{
		var value = getCellValue( element.id );
		
		if ( !checkDateValidate( value, "" ) ) return;
		
		setValue( 'hdRday', value );
	}
	
	// 이벤트핸들러 - 대여시간 선택
	function onChangeRtimeH( element )
	{
		var value = getTimeValue( true );
		setValue( 'hdRtime', value );
	}
	
	// 이벤트핸들러 - 대여분 선택
	function onChangeRtimeM( element )
	{
		var value = getTimeValue( true );
		setValue( 'hdRtime', value );
	}
	
	// 이벤트핸들러 - 반납일 선택
	function onChangeRetday( element )
	{
		var value = getCellValue( element.id );
		var startValue = getValue( 'hdRday' );
		
		if ( !checkDateValidate( value, startValue ) ) return;
		
		setValue( 'hdRetday', value );
	}
	
	// 이벤트핸들러 - 반납시간 선택
	function onChangeRettimeH( element )
	{
		var value = getTimeValue( false );
		setValue( 'hdRettime', value );
	}
	
	// 이벤트핸들러 - 반납분 선택
	function onChangeRettimeM( element )
	{
		var value = getTimeValue( false );
		setValue( 'hdRettime', value );
	}
	
	// 이벤트핸들러 - 대여지점 선택
	function onChangeRoffice( element )
	{
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		setValue( 'hdRlocation', values[0] );
		setValue( 'hdRoffice', values[1] );
	}
	
	// 이벤트핸들러 - 반납지점 선택
	function onChangeRetoffice( element )
	{
		if ( isNull( element.value ) ) return;
		
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		setValue( 'hdRetlocation', values[0] );
		setValue( 'hdRetoffice', values[1] );
	}

	function goReserve()
	{
		var userid = "<%=userid%>";
		if ( isNull( userid ) )
		{
			alert( '로그인하셔야 예약진행이 가능합니다.' );
		}
		else
		{
			if ( !validateValue() ) return;
			
			form = document.reserveForm;
			window.open( "", 
					"_new", 
					"menubar=no, " +
					"status=yes, " +
					"toolbar=no, " +
					"location=no, " +
					"scrollbars=no, " +
					"top=200, " +
					"left=300, " +
					"width=900, " +
					"height=570" );
			form.target = "_new";
			form.submit();
		}
	}
//-->
</script>

<form name="reserveForm" method="POST" action="<%=root%>/pages/reserve/reserveAjax.jsp">
<input type="hidden" id="hdRday" name="hdRday" />
<input type="hidden" id="hdRtime" name="hdRtime" />
<input type="hidden" id="hdRetday" name="hdRetday" />
<input type="hidden" id="hdRettime" name="hdRettime" />
<input type="hidden" id="hdRlocation" name="hdRlocation" />
<input type="hidden" id="hdRoffice" name="hdRoffice" />
<input type="hidden" id="hdRetlocation" name="hdRetlocation" />
<input type="hidden" id="hdRetoffice" name="hdRetoffice" />
</form>

<form name="searchForm" method="get" action="">
<input type="hidden" name="act" value="">
<input type="hidden" name="btype" value="5">
<input type="hidden" name="pg" value="">
<input type="hidden" name="seq" value="">
<input type="hidden" name="myid" value="">
</form>

<form name="searchform" method="GET" action="">
<input type="hidden" name="act">
<input type="hidden" name="pg">
<input type="hidden" name="seq">
</form>

<!-- 컨텐츠 영역 시작 -->
<table width="980" border=0 cellspacing=0 cellpadding=0>
  <!-- 1행 시작 -->
  <tr>
  	<td>
    
    <table width="100%" border=0 cellspacing=0 cellpadding=0>
      <tr>
      	<td width="200" valign="top">
        
        <!-- 상단 좌측 내용 -->
        <table width="100%" border=0 cellspacing=0 cellpadding=0>
          <tr>
          	<td valign="top">
            <img src="<%=root%>/images/main/main_left.gif" />
            </td>
          </tr>
          <tr><td height="15" /></tr>
          <tr>
          	<td valign="top">
            <img src="<%=root%>/images/main/pon.gif" />
            </td>
          </tr>
          <tr><td height="15" /></tr>
          <tr>
          	<td valign="top" align="center">
            <img src="<%=root%>/images/main/realpen.gif" />
            </td>
          </tr>
        </table>
        
        </td>
        
        <td width="15" />
        
        <td valign="top">
        
        <!-- 상단 중앙 내용 -->
        <table border=0 cellspacing=0 cellpadding=0 width=522>
		  <tr>
			<td colspan=3><img src="<%=root%>/images/main/main_top09.gif"></td>
		  </tr>
		  <tr>
			<td valign=top width=349>
		
		    <table border=0 cellspacing=0 cellpadding=0>
			<tr>
			<td><a href="/pack/"><img src="<%=root%>/images/main/b-1.gif" border=0></a></td>
			<td><a href="/rent/"><img src="<%=root%>/images/main/b-2.gif" border=0></a></td>
			</tr>
			<tr>
			<td><a href="/pack/aircar.php"><img src="<%=root%>/images/main/b-3.gif" border=0></a></td>
			<td><a href="/pack/cartel.php"><img src="<%=root%>/images/main/b-4.gif" border=0></a></td>
			</tr>
			</table>
			
			</td>
			<td valign=top width=168><img src="<%=root%>/images/main/main_top09_1.gif"></td>
			<td width=5></td>
		  </tr>
		</table>
        
        </td>
        
        <td width="15" />
        
        <td valign="top">
        
        <!-- 상단 우측 내용 -->
        <table border="0" cellpadding="0" cellspacing="1">
          <tr>
          	<td bgcolor="#FFFFFF">
            <table border="0" cellspacing="0" cellpadding="0" width="240">
              <tr>
            	<td colspan=2 height=7></td>
              </tr>
              <tr>
            	<td colspan=2><img src="<%=root%>/images/main/ser_ti.gif"></td>
              </tr>
              <tr>
            	<td colspan=2 height=5></td>
              </tr>
              <tr>
            	<td valign="top">
            	
            	<!-- 예약 영역 시작 -->
		  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  	  	  <tr>
		  	  	  	<td valign="top">
		  	  	  	
		  	  	  	<!-- 단위 테이블 시작 -->
		  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  	  	  	  <tr>
		  	  	  	  	<td valign="top">
		  	  	  	  	<table width="100%" border="0" cellspacing="3" cellpadding="0">
		  	  	  	  	  <tr>
		  	  	  	  	  	<td><span class="txt_name">대여</span></td>
		  	  	  	  	  	<td>
		  	  	  	  	  	<input type="text" id="rdatepicker" size="10" value="선택"
		  	  	  	  	  		   onchange="javascript:onChangeRday(this)">
		  	  	  	  	  	</td>
		  	  	  	  	  	<td width="50">
		  	  	  	  	  	<select id="cbRtimeH" 
		  	  	  	  	  			onchange="javascript:onChangeRtimeH(this)">
		  	  	  	  	  		<option>선택</option>
		<%
			for ( int i=0; i<24; i++ )
			{
				if ( i < 10 ) numStr = "0" + i;
				else		  numStr = "" + i;
		%>  	  	  	  	  	
					         	<option value="<%=numStr%>"><%=numStr%></option>
		<%
			}
		%>			         	
					         </select>시
		  	  	  	  	  	</td>
		  	  	  	  	  	<td width="50">
		  	  	  	  	  	<select id="cbRtimeM" 
		  	  	  	  	  			onchange="javascript:onChangeRtimeM(this)">
		  	  	  	  	  		<option>선택</option>
		<%
			for ( int i=0; i<60; i+=10 )
			{
				if ( i < 10 ) numStr = "0" + i;
				else		  numStr = "" + i;
		%>  	  	  	  	  	
					         	<option value="<%=numStr%>"><%=numStr%></option>
		<%
			}
		%>	
					         </select>분
		  	  	  	  	  	</td>
		  	  	  	  	  </tr>
		  	  	  	  	  <tr><td colspan=3 background="<%=root%>/images/main/search_dot.gif" height="1"></td></tr>
		  	  	  	  	  <tr>
		  	  	  	  	  	<td><span class="txt_name">반납</span></td>
		  	  	  	  	  	<td>
		  	  	  	  	  	<input type="text" id="retdatepicker" size="10" value="선택"
		  	  	  	  	  		   onchange="javascript:onChangeRetday(this)">
		  	  	  	  	  	</td>
		  	  	  	  	  	<td width="50">
		  	  	  	  	  	<select id="cbRettimeH" 
		  	  	  	  	  			onchange="javascript:onChangeRettimeH(this)">
		  	  	  	  	  		<option>선택</option>
		<%
			for ( int i=0; i<24; i++ )
			{
				if ( i < 10 ) numStr = "0" + i;
				else		  numStr = "" + i;
		%>  	  	  	  	  	
					         	<option value="<%=numStr%>"><%=numStr%></option>
		<%
			}
		%>			         	
					         </select>시
		  	  	  	  	  	</td>
		  	  	  	  	  	<td width="50">
		  	  	  	  	  	<select id="cbRettimeM" 
		  	  	  	  	  			onchange="javascript:onChangeRettimeM(this)">
		  	  	  	  	  		<option>선택</option>
		<%
			for ( int i=0; i<60; i+=10 )
			{
				if ( i < 10 ) numStr = "0" + i;
				else		  numStr = "" + i;
		%>  	  	  	  	  	
					         	<option value="<%=numStr%>"><%=numStr%></option>
		<%
			}
		%>	
					         </select>분
		  	  	  	  	  	</td>
		  	  	  	  	  </tr>
		  	  	  	  	  <tr><td colspan=3 background="<%=root%>/images/main/search_dot.gif" height="1"></td></tr>
		  	  	  	  	</table>
		  	  	  	  	</td>
		  	  	  	  </tr>
		  	  	  	  <tr>
		  	  	  	  	<td valign="top">
		  	  	  	  	<table width="100%" border="0" cellspacing="2" cellpadding="0">
		  	  	  	  	  <tr>
		  	  	  	  	  	<td><span class="txt_name">대여점</span></td>
		  	  	  	  	  	<td>
		  	  	  	  	  	<select width="100%" id="cbRoffice"
		  	  	  	  	  			onchange="javascript:onChangeRoffice(this)">
		  	  	  	  	  		<option>선택하세요</option>
		<%		
			codeType = CodeProperties.CAR_LO;
			for ( CodeInfoDTO dto : CodeProperties.codeCarOfficeList )
			{
				codeOffice = dto.getCode();
				codeCarLo = CodeProperties.getCodeCarLo( dto.getCode() );
				location = CodeProperties.getCodeName( codeType, codeCarLo );
		%>
					         	<option value="<%=codeCarLo%>|<%=dto.getCode()%>">[<%=location%>] <%=dto.getName()%></option>
		<%
			}
		%>			         	
					         </select>
		  	  	  	  	  	</td>
		  	  	  	  	  </tr>
		  	  	  	  	  <tr><td colspan=2 background="<%=root%>/images/main/search_dot.gif" height="1"></td></tr>
		  	  	  	  	  <tr>
		  	  	  	  	  	<td><span class="txt_name">반납점</span></td>
		  	  	  	  	  	<td>
		  	  	  	  	  	<select width="100%" id="cbRetoffice"
		  	  	  	  	  			onchange="javascript:onChangeRetoffice(this)">
		  	  	  	  	  		<option>선택하세요</option>
		<%		
			codeType = CodeProperties.CAR_LO;
			for ( CodeInfoDTO dto : CodeProperties.codeCarOfficeList )
			{
				codeOffice = dto.getCode();
				codeCarLo = CodeProperties.getCodeCarLo( dto.getCode() );
				location = CodeProperties.getCodeName( codeType, codeCarLo );
		%>
					         	<option value="<%=codeCarLo%>|<%=dto.getCode()%>">[<%=location%>] <%=dto.getName()%></option>
		<%
			}
		%>	
					         </select>
		  	  	  	  	  	</td>
		  	  	  	  	  </tr>
		  	  	  	  	</table>
		  	  	  	  	</td>
		  	  	  	  </tr>
		  	  	  	  <tr><td colspan=2 background="<%=root%>/images/main/search_dot.gif" height="1"></td></tr>
		  	  	  	  <tr>
		  	  	  	  	<td>
		  	  	  	  	<img src="<%=root%>/images/blank.gif" width="65" height="24" />
		  	  	  	  	<img src="<%=root%>/images/reserve/btn_reserve_go.gif" style="cursor:hand" onclick="javascript:goReserve()">
		  	  	  	  	</td>
		  	  	  	  </tr>
		  	  	  	</table>
		  	  	  	<!-- 단위 테이블 끝 -->
		  	  	  	
		  	  	  	</td>
		  	  	  </tr>
		  	  	  <tr><td height="10" /></tr>
		  	  	</table>
		  	  	<!-- 예약 영역 끝 -->
            	
            	</td>
              </tr>
            </table>		        
        	</td>
        </tr>
        
        <tr>
          <td valign="top">
          
          <table border=0 cellspacing=0 cellpadding=0>
            <tr>
              <td height=5></td>
            </tr>
            <tr>
              <td><img src="<%=root%>/images/main/1_2.gif" border=0></td>
            </tr>
          </table>
          
          </td>
        </tr>
        
        <tr>
          <td valign="top">
          
          <!-- 공지사항 리스트 시작 -->
          <s:action name="noticelist" namespace="/main" executeResult="true" />
          <!-- 공지사항 리스트 끝 -->
          
          </td>
        </tr>
        
        </table>
        
        </td>
      </tr>
    </table>
    
    </td>
  </tr>
  <!-- 1행 끝 -->
  
  <tr><td height="15" /></tr>
  
  <!-- 2행 시작 -->
  <tr>
  	<td>

    <!-------------------------  베스트 시작 --------------------------------->
    <table width="100%" border=0 cellspacing=0 cellpadding=0>
      <tr>
        <td><img src="<%=root%>/images/main/chu_01.gif"></td>
        <td align="left" background="<%=root%>/images/main/chu_bg.gif">
        
        <div id='besthousemenu0' style="display:">
	    <table border=0 cellspacing=0 cellpadding=0>
		  <tr>
			<td><img src="<%=root%>/images/main/chu_title.gif"></td>
			<td width=10></td>
			<td><img src="<%=root%>/images/main/best_01_1.gif"></td>
			<td><img src="<%=root%>/images/main/best_02.gif" style="cursor:hand" 
					 onMouseOver="ShowHideLayer(1, 2, 'besthousemenu');ShowHideLayer(1, 2, 'besthouse');document.getElementById('besthousemenu0').style.display = 'none';"></td>
		  </tr>
		</table>
	    </div>
	 
	    <div id='besthousemenu1' style="display:none">
	    <table border=0 cellspacing=0 cellpadding=0>
		  <tr>
			<td><img src="<%=root%>/images/main/chu_title.gif"></td>
			<td width=10></td>
			<td><img src="<%=root%>/images/main/best_01.gif" style="cursor:hand" 
					 onMouseOver="ShowHideLayer(0, 2, 'besthousemenu');ShowHideLayer(0, 2, 'besthouse');document.getElementById('besthousemenu1').style.display = 'none';"></td>
			<td><img src="<%=root%>/images/main/best_02_1.gif"></td>
		  </tr>
		</table>
	    </div>
     
        </td>
     	<td><img src="<%=root%>/images/main/chu_02.gif"></td>
      </tr>
      <tr>
      	<td background="<%=root%>/images/main/chu_02_bg.gif" width=8></td>
		<td>
      
        <!-- 베스트 상품 시작 -->
        <div id='besthouse0' style="display:">
        <s:action name="bestcarlist" namespace="/main" executeResult="true" />
        </div>
        <!-- 베스트 상품 끝 -->
        
        <!-- 베스트 렌트카 시작 -->
        <div id='besthouse1' style="display:none">
        <s:action name="besttravellist" namespace="/main" executeResult="true" />
        </div>
        <!-- 베스트 렌트카 끝 -->
        
        </td>
        <td background="<%=root%>/images/main/chu_03_bg.gif"></td>
	  </tr>
	  <tr>
		<td><img src="<%=root%>/images/main/chu_03.gif"></td>
		<td background="<%=root%>/images/main/chu_04_bg.gif"></td>
		<td><img src="<%=root%>/images/main/chu_04.gif"></td>
	  </tr>
    </table>
    <!-------------------------  베스트 끝 --------------------------------->
    
    </td>
  </tr>
  <!-- 2행 끝 -->
  
  <tr><td height="15" /></tr>
  
  <!-- 3행 시작 -->
  <tr>
  	<td>
    
    <!-------------------------  렌트카 시작 --------------------------------->
    <s:action name="carlist" namespace="/main" executeResult="true" />
    <!-------------------------  렌트카 끝 --------------------------------->
    
    </td>
  </tr>
  <!-- 3행 끝 -->
  
  <tr><td height="15" /></tr>
  
  <!-- 4행 시작 -->
  <tr>
  	<td>
    
    <!-------------------------  상품 시작 --------------------------------->
    <s:action name="travellist" namespace="/main" executeResult="true" />
    <!-------------------------  상품 끝 --------------------------------->
    
    </td>
  </tr>
  <!-- 4행 끝 -->
  
  <tr><td height="15" /></tr>
  
  <tr>
  	<td colspan=2><img src="<%=root%>/images/main/copy_04.gif"></td>
  </tr>
  
  <tr><td height="15" /></tr>
  
</table>


<!-- 컨텐츠 영역 끝 -->
	
<jsp:include page="/include/footer.jsp" flush="true" />	