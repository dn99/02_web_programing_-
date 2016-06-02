<%@page import="com.bnc.util.StringCheck"%>
<%@page import="com.bnc.reserve.model.RentManager"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="com.bnc.util.NumberCheck"%>
<%@ page import="com.bnc.util.PageNavi"%>
<%@ page import="com.bnc.util.StringUtil"%>
<%@ page import="com.bnc.util.DateUtil"%>
<%@ page import="com.bnc.reserve.model.RentDTO"%>
<%@ page import="com.bnc.reserve.model.InsuranceDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="com.bnc.member.model.MemberDTO"%>
<%@ page import="com.bnc.props.*" %>
<%@ page import="com.bnc.common.model.*" %>
<%!
	private static final int NAVI_PRICE = 5000;
%>
<%
	//예약 등록 성공 여부 체크
	String reserveOK = request.getParameter( "reserveOK" );
	System.out.println( "reserveOK : " + reserveOK );
	if ( !StringUtil.hasNull( reserveOK ) )
	{	
		out.println("<script language=javascript>");
		out.println("alert( '성공적으로 예약이 등록 되었습니다.' );");
		out.println("self.close();");
		out.println("opener.location.reload();");
		out.println("</script>");
	}

	//MemberDTO memberDTO = new MemberDTO();
	//memberDTO.setMember_id("hansik");
	//memberDTO.setMember_name("김한식");
	//memberDTO.setMember_grade( 0 );
	//session.setAttribute("userInfo", memberDTO);
	//memberDTO = ( MemberDTO )session.getAttribute( "userInfo" );
	MemberDTO memberDTO = ( MemberDTO )session.getAttribute( "userInfo" );
	
    String root = request.getContextPath();
	String currentDay = DateUtil.getCurrentDate( DateUtil.FORMAT_DATE_DAY );
	
	String hdRday = StringCheck.nullToBlank( request.getParameter( "hdRday" ) );
	String hdRtime = StringCheck.nullToBlank( request.getParameter( "hdRtime" ) );
	String hdRetday = StringCheck.nullToBlank( request.getParameter( "hdRetday" ) );
	String hdRettime = StringCheck.nullToBlank( request.getParameter( "hdRettime" ) );
	String hdRlocation = StringCheck.nullToBlank( request.getParameter( "hdRlocation" ) );
	String hdRoffice = StringCheck.nullToBlank( request.getParameter( "hdRoffice" ) );
	String hdRetlocation = StringCheck.nullToBlank( request.getParameter( "hdRetlocation" ) );
	String hdRetoffice = StringCheck.nullToBlank( request.getParameter( "hdRetoffice" ) );
	
	System.out.println( "hdRday : " + hdRday );
	System.out.println( "hdRtime : " + hdRtime );
	System.out.println( "hdRetday : " + hdRetday );
	System.out.println( "hdRettime : " + hdRettime );
	System.out.println( "hdRlocation : " + hdRlocation );
	System.out.println( "hdRoffice : " + hdRoffice );
	System.out.println( "hdRetlocation : " + hdRetlocation );
	System.out.println( "hdRetoffice : " + hdRetoffice );
	
	String hdRtimeH = "";
	String hdRtimeM = "";
	if ( !StringUtil.hasNull( hdRtime ) )
	{
		String hdRtimeValues[] = StringUtil.getSplitValues( hdRtime, ":" );
		hdRtimeH = hdRtimeValues[0];
		hdRtimeM = hdRtimeValues[1];
		
		System.out.println( "hdRtimeH : " + hdRtimeH );
		System.out.println( "hdRtimeM : " + hdRtimeM );
	}
	
	String hdRettimeH = "";
	String hdRettimeM = "";
	if ( !StringUtil.hasNull( hdRtime ) )
	{
		String hdRettimeValues[] = StringUtil.getSplitValues( hdRettime, ":" );
		hdRettimeH = hdRettimeValues[0];
		hdRettimeM = hdRettimeValues[1];
		
		System.out.println( "hdRettimeH : " + hdRettimeH );
		System.out.println( "hdRettimeM : " + hdRettimeM );
	}
	
	String numStr = "";
	String location = "";
	
	String value = "";
	String selectedValue = "";
	
	int codeType = 0;
	int codeOffice = 0;
	int codeCarLo = 0;
	
	codeType = CodeProperties.GRADE; 
	
	RentDTO rentDTO = new RentDTO();
	
	if ( memberDTO == null )
	{
		out.println("<script language=javascript>");
		out.println("alert( '로그인하셔야 예약이 가능합니다.' );");
		out.println("self.close();");
		out.println("</script>");
	}
	else
	{
		String memberGrade = CodeProperties.getCodeName( codeType, memberDTO.getMember_grade() );
		int memberGradeDcRate = CodeProperties.getGradeDC( memberDTO.getMember_grade() );
%>
<jsp:include page="/include/head.jsp" flush="true" />
<style> 
	select{ behavior: url("<%=root%>/js/selectbox.htc"); }
</style>
<script type="text/javascript">
<!--
	var carGradeCodes = [];		// 차량 목록 개수만큼의 차량 등급 코드 배열
	var carMakerCodes = [];		// 차량 목록 개수만큼의 제조사 코드 배열
	var carFuelTypeCodes = [];	// 차량 목록 개수만큼의 연료타입 코드 배열

	var isCarGrade = false;		// 차량 등급 이름 셋팅 완료 여부
	var isCarMaker = false;		// 제조사 이름 셋팅 완료 여부
	var isCarFuelType = false;	// 연료타입 이름 셋팅 완료 여부
	
	var totalTime = 0;			// 차량 토탈 이용시간
	var rentPrice = 0;			// 일당 렌트가격
	var insurancePrice = 0;		// 보험가격
	var naviPrice = 0;			// 네비가격
	var dcRate = 0;				// 할인률
	var totalPrice = 0;			// 차량 렌트 토탈 가격
	
	var totalTimeInfo = "";
	var pg = 1;
	
	// 차량 등급 이름 호출
	function callCarGradeName( codeValues )
	{
		var codeType = CAR_GRADE;
		callCodeName( codeType, codeValues, receiveCarGradeName );
	}
	
	// 제조사 이름 호출
	function callCarMakerName( codeValues )
	{
		var codeType = MAKER;
		callCodeName( codeType, codeValues, receiveCarMakerName );
	}
	
	// 연료타입 이름 호출
	function callCarFuelTypeName( codeValues )
	{
		var codeType = FUEL_TYPE;
		callCodeName( codeType, codeValues, receiveCarFuelTypeName );
	}
	
	// 대여지점 이름 호출
	function callCarROfficeName( codeValues )
	{
		//alert("1===> " + codeValues);
		var codeType = CAR_OFFICE;
		callCodeName( codeType, codeValues, receiveRCarOfficeName );
	}
	
	// 반납지점 이름 호출
	function callCarRetOfficeName( codeValues )
	{
		var codeType = CAR_OFFICE;
		callCodeName( codeType, codeValues, receiveRetCarOfficeName );
	}
	
	// httpRequest - 코드에 대한 이름 호출
	function callCodeName( codeType, codeValues, callBackFun )
	{
		alert("2===> " + codeValues);
		var param = "act=getCodeName&codeType=" + codeType + "&codeValues=" + codeValues;
		sendRequest( "<%=root%>/reserve", param, callBackFun, "GET" );
	}
	
	// 모든 코드 정보 초기화
	function initCodes()
	{
		carGradeCodes = [];
		carMakerCodes = [];
		carFuelTypeCodes = [];
		
		isCarGrade = false;
		isCarMaker = false;
		isCarFuelType = false;
	}
	
	// httpRequest - 차량 목록 네비정보 호출
	function callCarPageNavi( pg )
	{
		initCodes();
		var values = getSplitValues( document.getElementById( "cbRoffice" ).value, "|" );
		var rlocation = values[0];
		var roffice = values[1];
		var param = "act=carPageNavi&pg=" + pg + "&roffice=" + roffice;
		sendRequest( "<%=root%>/reserve", param, receiveCarPageNavi, "GET" );
	}
	
	// httpRequest - 차량 목록 호출
	function callCarList( pg )
	{
		var values = getSplitValues( document.getElementById( "cbRoffice" ).value, "|" );
		var rlocation = values[0];
		var roffice = values[1];
		var param = "act=carList&pg=" + pg + "&roffice=" + roffice;
		sendRequest( "<%=root%>/reserve", param, receiveRentCarList, "GET" );
	}
	
	// 콜백 함수 - 차량 등급 이름
	function receiveCarGradeName()
	{
		if ( hasResult() )
		{
			isCarGrade = true;
			var carGradeNameValues = httpRequest.responseText;
			var carGradeNames = getSplitValues( carGradeNameValues, "|" );
			setRowCodeName( carGradeNames, "car_grade" );
			
			getRowCodeName();
		}
	}
	
	// 콜백 함수 - 제조사 이름
	function receiveCarMakerName()
	{
		if ( hasResult() )
		{
			isCarMaker = true;
			var carMakerNameValues = httpRequest.responseText;
			var carMakerNames = getSplitValues( carMakerNameValues, "|" );
			setRowCodeName( carMakerNames, "car_maker" );
			
			getRowCodeName();
		}
	}
	
	// 콜백 함수 - 연료타입 이름
	function receiveCarFuelTypeName()
	{
		if ( hasResult() )
		{
			isCarFuelType = true;
			var carFuelTypeNameValues = httpRequest.responseText;
			var carFuelTypeNames = getSplitValues( carFuelTypeNameValues, "|" );
			setRowCodeName( carFuelTypeNames, "car_fueltype" );
			
			getRowCodeName();
		}
	}
	
	// 콜백 함수 - 대여지점 이름
	function receiveRCarOfficeName()
	{
		if ( hasResult() )
		{
			alert( "------> " );
			var carOfficeNameValues = httpRequest.responseText;
			var carOfficeNames = getSplitValues( carOfficeNameValues, "|" );
			setCellInfo( carOfficeNames[0], "cellRoffice", "" );
			//callCarList( pg );
			callCarPageNavi( pg );
		}
	}
	
	// 콜백 함수 - 반납지점 이름
	function receiveRetCarOfficeName()
	{
		if ( hasResult() )
		{
			var carOfficeNameValues = httpRequest.responseText;
			var carOfficeNames = getSplitValues( carOfficeNameValues, "|" );
			setCellInfo( carOfficeNames[0], "cellRetoffice", "" );
		}
	}
	
	// 콜백 함수 - 차량 목록 페이지 네비 
	function receiveCarPageNavi()
	{
		if ( hasResult() ) 
		{
			var pageNaviJsonData = eval('(' + httpRequest.responseText +')');
			createPageNavi( pageNaviJsonData );
			callCarList( pg );
		}	
	}
	
	// 콜백 함수 - 차량 목록 
	function receiveRentCarList()
	{
		if ( hasResult() ) setData( httpRequest.responseXML );
	}
	
	// httpRequest 호출 성공 여부 반환
	function hasResult()
	{
		var isResult = false;
		if ( httpRequest.readyState == 4 )
			if ( httpRequest.status == 200 ) isResult = true;
		
		return isResult;
	}
	
	// 페이징 관련 요소 생성 및 셋팅
	function createPageNavi( pageNaviJsonData )
	{
		var cellPageNavi, cellPageInfo;
		var txtNode;
		
		var row = document.getElementById( "rowPage" );
		removeAllChild( row );
		
		cellPageNavi = document.createElement( "td" );
		cellPageNavi.innerHTML = pageNaviJsonData["pageNavi"];
		cellPageNavi.align = "center";
		
		cellPageInfo = document.createElement( "td" );
		txtNode = document.createTextNode( pageNaviJsonData["no"] + " / " + pageNaviJsonData["totalPage"] );
		cellPageInfo.appendChild( txtNode );
		cellPageInfo.width = "50";
		cellPageInfo.align = "right";
		
		row.appendChild( cellPageNavi );
		row.appendChild( cellPageInfo );
	}
	
	// 챠량 목록 개수 만큼 생성 및 데이타 셋팅
	function setData( rentCarXMLData )
	{
		removeData();
		
		var rowTop = createRowTop();
		carRentTable.appendChild( rowTop );
		
		// 차량 목록 XML 파싱 이후 화면 출력
		var row = null;
		var rowLine = null;
		var len = rentCarXMLData.getElementsByTagName( "car" ).length;
		for ( var i=0; i<len; i++ )
		{
			row = createRow( rentCarXMLData.getElementsByTagName( "car" )[i].childNodes );
			if ( ( i + 1 ) % 2 == 0 ) row.bgColor = "#232323";
			
			carRentTable.appendChild( row );
			
			if ( i < len - 1 ) 
			{
				rowLine = createRowLine();
				carRentTable.appendChild( rowLine );
			}
		}
		
		if ( len != 0 ) getRowCodeName();
	}
	
	// 차량 목록 데이타 초기화
	function removeData()
	{
		var len = carRentTable.childNodes.length - 1;
		for ( var i=len; i>=1; i-- )
		{
			carRentTable.removeChild( carRentTable.childNodes[i] );
		}
	}
	
	// 차량 목록 상단 줄바꿈 처리
	function createRowTop()
	{
		var rowLine = document.createElement( "tr" );
		var colLine = document.createElement( "td" );
		colLine.background = "<%=root%>/images/reserve/line_blur_01.png";
		colLine.height = 15;
		colLine.colSpan = 9;
		rowLine.appendChild( colLine );
		
		return rowLine;
	}
	
	// 차량 목록 줄바뀜 마다 라인 처리
	function createRowLine()
	{
		var rowLine = document.createElement( "tr" );
		var colLine = document.createElement( "td" );
		colLine.background = "<%=root%>/images/reserve/line_dot_01.gif";
		colLine.height = 1;
		colLine.colSpan = 9;
		rowLine.appendChild( colLine );
		
		return rowLine;
	}
	
	// 차량 목록 한개 ROW 생성
	function createRow( data )
	{
		var row, txtNode;
		var cellSeq, cellSpic, cellGrade, cellName, cellMaker;
		var cellFueltype, cellDisvolume, cellNumofpeople, cellRentPrice;
		var tagImg;
		var nodeName;
		var nodeValue;
		var len = data.length;
		row = document.createElement( "tr" );
		for ( var i=0; i<len; i++ )
		{
			nodeName = data[i].nodeName;
			nodeValue = data[i].firstChild.nodeValue;
			if ( nodeName == "car_seq" ) 
			{
				cellSeq = document.createElement( "td" );
				txtNode = document.createTextNode( data[i].firstChild.nodeValue );
				cellSeq.appendChild( txtNode );
				cellSeq.id = nodeName;
				cellSeq.height = 34;
			}
			if ( nodeName == "car_spic" ) 
			{
				cellSpic = document.createElement( "td" );
				tagImg = document.createElement( "img" );
				tagImg.src = root + "/upload/rentcar/" + data[i].firstChild.nodeValue;
				tagImg.width = tagImg.height = 25;
				cellSpic.appendChild( tagImg );
				cellSpic.id = nodeName;
			}
			if ( nodeName == "car_grade" ) 
			{
				cellGrade = document.createElement( "td" );
				cellGrade.id = nodeName;
				
				// row 개수만큼의 차량등급 코드를 담아 둔다.
				carGradeCodes[ carGradeCodes.length ] = data[i].firstChild.nodeValue;
			}
			if ( nodeName == "car_name" ) 
			{
				cellName = document.createElement( "td" );
				txtNode = document.createTextNode( data[i].firstChild.nodeValue );
				cellName.appendChild( txtNode );
				cellName.id = nodeName;
			}
			if ( nodeName == "car_maker" ) 
			{
				cellMaker = document.createElement( "td" );
				cellMaker.id = nodeName;
				
				// row 개수만큼의 차량등급 코드를 담아 둔다.
				carMakerCodes[ carMakerCodes.length ] = data[i].firstChild.nodeValue;
			}
			if ( nodeName == "car_fueltype" ) 
			{
				cellFueltype = document.createElement( "td" );
				cellFueltype.id = nodeName;
				
				// row 개수만큼의 차량등급 코드를 담아 둔다.
				carFuelTypeCodes[ carFuelTypeCodes.length ] = data[i].firstChild.nodeValue;
			}
			if ( nodeName == "car_disvolume" ) 
			{
				cellDisvolume = document.createElement( "td" );
				txtNode = document.createTextNode( data[i].firstChild.nodeValue );
				cellDisvolume.appendChild( txtNode );
				cellDisvolume.id = nodeName;
			}
			if ( nodeName == "car_numofpeople" ) 
			{
				cellNumofpeople = document.createElement( "td" );
				txtNode = document.createTextNode( data[i].firstChild.nodeValue );
				cellNumofpeople.appendChild( txtNode );
				cellNumofpeople.id = nodeName;
			}
			if ( nodeName == "car_rentprice" ) 
			{
				cellRentPrice = document.createElement( "td" );
				txtNode = document.createTextNode( data[i].firstChild.nodeValue );
				cellRentPrice.appendChild( txtNode );
				cellRentPrice.id = nodeName;
			}
		}
		row.appendChild( cellSeq );
		row.appendChild( cellSpic );
		row.appendChild( cellGrade );
		row.appendChild( cellName );
		row.appendChild( cellMaker );
		row.appendChild( cellFueltype );
		row.appendChild( cellDisvolume );
		row.appendChild( cellNumofpeople );
		row.appendChild( cellRentPrice );
		
		row.style.cssText = "cursor:hand";
		
		row.onclick = function() {
			onClickRentCar( this );
		};
		row.onmouseover = function() {
			onRentCarOverColor( this );
			this.style.backgroundColor = '#111111'; 
			this.style.color = '#fff';
		};
		row.onmouseout = function() {
			onRentCarOutColor( this );
			this.style.backgroundColor = ''; 
			this.style.color = '';
		};
		
		return row;
	}
	
	// 차량 목록의  코드를 해당 이름으로 호출
	function getRowCodeName()
	{
		// 동적 바인딩
		if ( !isCarGrade ) 
		{
			var gradeCodeValues = getCodeValues( carGradeCodes );
			callCarGradeName( gradeCodeValues );
			return;
		}	
		if ( !isCarMaker ) 
		{
			var makerCodeValues = getCodeValues( carMakerCodes );
			callCarMakerName( makerCodeValues );
			return;
		}	
		if ( !isCarFuelType ) 
		{
			var FuelTypeCodeValues = getCodeValues( carFuelTypeCodes );
			callCarFuelTypeName( FuelTypeCodeValues );
			return;
		}	
	}
	
	// 전체 코드를 '|'으로 연결한 문자열 반환 
	function getCodeValues( codes )
	{
		var codeValues = "";
		len = codes.length;
		for ( var i=0; i<len; i++ )
		{
			codeValues += codes[i];
			if ( i != len-1 ) codeValues += "|";
		}
		
		return codeValues;
	}
	
	// 차량 목록에서 코드로 된 부분을 해당 이름으로 셋팅
	function setRowCodeName( codeNames, id )
	{
		var rowTable = document.getElementById( "carRentTable" );
		var rows = rowTable.childNodes;
		var row;
		
		var nodeId = "";
		var nodeValue = "";
		var txtNode;
		
		var rowLen = rows.length;
		var len = 0;
		for ( var i=1; i<rowLen; i++ )
		{
			row = rows[i];
			len = row.childNodes.length;
			for ( var j=0; j<len; j++ )
			{
				nodeId = row.childNodes[j].id;
				if ( nodeId == id )
				{
					txtNode = document.createTextNode( codeNames[i-1] );
					row.childNodes[j].appendChild( txtNode );
				}
			}
		}
	}
	
	// 해당 셀의 아이디로 정보 셋팅
	function changeCellInfo( elementId, cellId, del )
	{
		var value = getCellValue( elementId );
		setCellInfo( value, cellId, del );
	}
	
	// 해당 셀의 값으로 정보 셋팅
	function setCellInfo( value, cellId, del )
	{
		var txtNode = document.createTextNode( value + del );
		var cell = document.getElementById( cellId );
		removeAllChild( cell );
		cell.appendChild( txtNode );
	}
	
	// 해당 셀의 값 반환
	function getCellValue( elementId )
	{
		return document.getElementById( elementId ).value;
	}
	
	// 모든 자식 객체 제거
	function removeAllChild( element )
	{
		var len = element.childNodes.length - 1;
		for ( var i=len; i>=0; i-- )
		{
			element.removeChild( element.childNodes[i] );
		}
	}
	
	// 폼에 선택한 값을 입력
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
		if ( !hasValidateValue( 'hdCarSeq', true ) ) 
		{
			alert( "차량을 선택해주세요." );
			return false;
		}
		if ( !hasValidateValue( 'hdInsuranceSeq', true ) ) 
		{
			alert( "보험을 선택해주세요." );
			return false;
		}
		
		return true;
	}
	
	// 선택한 날짜의 유효성 체크
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
	
	// 예약 가격 정보 영역 셋팅
	function setReservePriceInfo()
	{
		setReservePriceValue( "infoTotalTime", totalTimeInfo );
		setReservePriceValue( "infoRentPrice", rentPrice );
		setReservePriceValue( "infoDcRate", <%=memberGradeDcRate%> );
		setReservePriceValue( "infoNaviPrice", naviPrice );
		setReservePriceValue( "infoInsurancePrice", insurancePrice );
		
		totalPrice = getTotalPrice();
		setValue( 'hdTotalPrice', totalPrice );
		setReservePriceValue( "infoTotalPrice", totalPrice );
	}
	
	// 예약 가격 정보 영역 셀값 셋팅
	function setReservePriceValue( elementId, value )
	{
		var cellInfo = document.getElementById( elementId );
		
		// 셀값 없으면 생성하여 값을 넣고 있다면 값 수정
		if ( cellInfo.childNodes.length == 0 )
		{
			var txtNode = document.createTextNode( value );
			cellInfo.appendChild( txtNode );
		}
		else
		{
			cellInfo.firstChild.nodeValue = value;
		}
	}
	
	// 예약 가격 정보 영역 모두 제거
	function removeReservePriceInfo()
	{
		removeReservePriceValue( "infoTotalTime" );
		removeReservePriceValue( "infoRentPrice" );
		removeReservePriceValue( "infoDcRate" );
		removeReservePriceValue( "infoNaviPrice" );
		removeReservePriceValue( "infoInsurancePrice" );
		removeReservePriceValue( "infoTotalPrice" );
	}
	
	// 예약 가격 정보 영역 셀값 제거
	function removeReservePriceValue( elementId )
	{
		var cellInfo = document.getElementById( elementId );
		cellInfo.removeChild( cellInfo.firstChild );
	}
	
	// 적용 가격 계산하여 반환
	function getTotalPrice()
	{
		var timePerPrice = rentPrice / 24;
		var sumPrice = totalTime * timePerPrice + insurancePrice + naviPrice;
		
		// 100원 단위 이하 반올림
		//var totalPrice = ( Math.round( parseInt( sumPrice ) * 100 ) ) / 100;
		var totalPrice = ( Math.round( sumPrice / 100 ) ) * 100;
		
		return totalPrice;
	}
	
	// 대여/반납 시간 정보를 조합하여 반환
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
	
	// 총이용시간, 총이용 일수 셋팅
	function setDatePeriod()
	{
		// 모든 날짜/시간 정보가 모두 선택되었다면 실행
		if ( !hasValidateValue( 'hdRday', false ) ) return;
		if ( !hasValidateValue( 'hdRtime', false ) ) return;
		if ( !hasValidateValue( 'hdRetday', false ) ) return;
		if ( !hasValidateValue( 'hdRettime', false ) ) return;
		
		var startDate = getFullDate( 'hdRday', 'hdRtime' );
		var endDate = getFullDate( 'hdRetday', 'hdRettime' );
		
		// 두 일자(startTime, endTime) 사이의 차이를 구한다.
		var dateGap = endDate.getTime() - startDate.getTime();
		var timeGap = new Date( 0, 0, 0, 0, 0, 0, endDate - startDate ); 
		
		// 두 일자(startTime, endTime) 사이의 간격을 "일-시간-분"으로 표시한다.
		var diffDay  = Math.floor( dateGap / ( 1000 * 60 * 60 * 24 ) );		// 일수       
		var diffHour = timeGap.getHours();       							// 시간 
		var diffMin  = timeGap.getMinutes();      							// 분
		var diffSec  = timeGap.getSeconds();      							// 초
		
		// 30분 이상이면 1시간을 더하는걸로 간주 - ex) 2일 2시간 40분일 경우 이용시간에 따른 계산은 2일 3시간으로 계산
		if ( diffMin >= 30 ) diffHour += 1;
		
		//alert( "diffDay : " + diffDay + "    diffHour : " + diffHour + "    diffMin : " + diffMin + "    diffSec : " + diffSec );
		
		totalTimeInfo = diffDay + " 일  " + diffHour + " 시간";
		totalTime = diffDay * 24 + diffHour;
		
		setValue( 'hdTotalDay', diffDay );
		setValue( 'hdTotalTime', diffHour );
	}
	
	// 날짜+시간 정보를 통한 Date 객체 반환
	function getFullDate( dayId, timeId )
	{
		var form = document.reserveForm;
		
		//alert( form[dayId].value + "   " + form[timeId].value );
		
		var days = getSplitValues( form[dayId].value, "." );
		var times = getSplitValues( form[timeId].value, ":" );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ), parseInt( times[0] ), parseInt( times[1] ), parseInt( times[2] ) );
	
		return date;
	}
	
	// 날짜 정보를 통한 Date 객체 반환
	function getDate( dayId )
	{
		var form = document.reserveForm;
		
		var days = getSplitValues( form[dayId].value, "." );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ) );
	
		return date;
	}
	
	// 날짜 문자열(2011.10.24)을 Date 객체로 반환
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
	
	// 스타일 - 차량 목록 오버시 컬러
	function onRentCarOverColor( row ) 
	{
		row.style.background = "#DDDDDD";
	}
	
	// 스타일 - 차량 목록 아웃시 컬러
	function onRentCarOutColor( row ) 
	{
		row.style.background = "#FFFFFF";
	}
	
	// 이벤트핸들러 - 차량 목록에서 차량 클릭
	function onClickRentCar( row )
	{
		var form = document.reserveForm;
		var nodeId = "";
		var nodeValue = "";
		var len = row.childNodes.length;
		for ( var i=0; i<len; i++ )
		{
			nodeId = row.childNodes[i].id;
			nodeValue = row.childNodes[i].firstChild.nodeValue;
			
			if ( nodeId == "car_grade" )
				setCellInfo( nodeValue, "cellCarGrade", "" );
			
			if ( nodeId == "car_name" )
				setCellInfo( nodeValue, "cellCarName", "" );
			
			if ( nodeId == "car_seq" )
				setValue( 'hdCarSeq', nodeValue );
				
			if ( nodeId == "car_rentprice" )
			{
				rentPrice = parseInt( nodeValue );
				setValue( 'hdPrice', nodeValue );
			}	
		}
		
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 대여일 선택
	function onChangeRday( element )
	{
		var value = getCellValue( element.id );
		
		if ( !checkDateValidate( value, "" ) ) return;
		
		setCellInfo( value, "cellRday", "" );
		setValue( 'hdRday', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 대여시간 선택
	function onChangeRtimeH( element )
	{
		var value = getTimeValue( true );
		changeCellInfo( element.id, "cellRtimeH", "시" );
		setValue( 'hdRtime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 대여분 선택
	function onChangeRtimeM( element )
	{
		var value = getTimeValue( true );
		changeCellInfo( element.id, "cellRtimeM", "분" );
		setValue( 'hdRtime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 반납일 선택
	function onChangeRetday( element )
	{
		var value = getCellValue( element.id );
		var startValue = getValue( 'hdRday' );
		
		if ( !checkDateValidate( value, startValue ) ) return;
		
		setCellInfo( value, "cellRetday", "" );
		setValue( 'hdRetday', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 반납시간 선택
	function onChangeRettimeH( element )
	{
		var value = getTimeValue( false );
		changeCellInfo( element.id, "cellRettimeH", "시" );
		setValue( 'hdRettime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 반납분 선택
	function onChangeRettimeM( element )
	{
		var value = getTimeValue( false );
		changeCellInfo( element.id, "cellRettimeM", "분" );
		setValue( 'hdRettime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 대여지점 선택
	function onChangeRoffice( element )
	{
		pg = 1;
		if ( isNull( element.value ) ) 
		{
			removeData();
			return;
		}
		
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		callCarROfficeName( values[1] );
		setValue( 'hdRlocation', values[0] );
		setValue( 'hdRoffice', values[1] );
	}
	
	// 이벤트핸들러 - 반납지점 선택
	function onChangeRetoffice( element )
	{
		if ( isNull( element.value ) ) return;
		
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		callCarRetOfficeName( values[1] );
		setValue( 'hdRetlocation', values[0] );
		setValue( 'hdRetoffice', values[1] );
	}
	
	// 이벤트핸들러 - 보험 선택
	function onChangeInsurance( element )
	{
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		setValue( 'hdInsuranceSeq', values[0] );
		insurancePrice = parseInt( values[1] );
		
		setReservePriceInfo();
	}
	
	var timeout = null;
	
	// 이벤트핸들러 - 메인에서 선택하고 온 경우
	function onSelctedRoffice()
	{
		timeout = setTimeout( setSelectedRoffice,  500 );
	}
	
	function setSelectedRoffice()
	{
		clearTimeout( timeout );
		pg = 1;
		//if ( isNull( '<%=hdRoffice%>' ) ) 
		//{
		//	removeData();
		//	return;
		//}
		
		callCarROfficeName( '<%=hdRoffice%>' );
		
		setSelectedRetoffice();
		setSelectedDate();
	}
	
	function setSelectedRetoffice()
	{
		if ( isNull( '<%=hdRoffice%>' ) ) return;
		
		callCarRetOfficeName( '<%=hdRoffice%>' );
	}
	
	function setSelectedDate()
	{
		setCellInfo( '<%=hdRday%>', "cellRday", "" );
		setCellInfo( '<%=hdRtimeH%>', "cellRtimeH", "시" );
		setCellInfo( '<%=hdRtimeM%>', "cellRtimeM", "분" );
		setCellInfo( '<%=hdRetday%>', "cellRetday", "" );
		setCellInfo( '<%=hdRettimeH%>', "cellRettimeH", "시" );
		setCellInfo( '<%=hdRettimeM%>', "cellRettimeM", "분" );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 네비 선택
	function onClickNavi( element )
	{
		var value = "";
		if ( element.checked )
		{
			value = "Y";
			naviPrice = <%=NAVI_PRICE%>;
		}
		else
		{
			value = "N";
			naviPrice = 0;
		}	
		setValue( 'hdNaviCheck', value );
		
		setReservePriceInfo();
	}
	
	// 이벤트핸들러 - 예약하기 클릭
	function onClickReserve()
	{
		if ( !validateValue() ) return;
		
		var cf = confirm( "선택하신 정보로 예약하시겠습니까?" );
		if ( cf )
		{
			var form = document.reserveForm;
			form.action = "<%=root%>/reserve";
			form.submit();
		}	
	}
	
	// 이벤트 핸들러 - 페이지 클릭
	function hs_goCarList( pg )
	{
		this.pg = pg;
		callCarPageNavi( pg );
	}
//-->
</script>

<body>

<form name="reserveForm" method="POST">
<input type="hidden" id="act" name="act" value="setReserve"> 
<input type="hidden" id="hdMemberId" name="hdMemberId" value="<%=memberDTO.getMember_id()%>" />
<input type="hidden" id="hdCarSeq" name="hdCarSeq" />
<input type="hidden" id="hdRday" name="hdRday" value="<%=hdRday%>" />
<input type="hidden" id="hdRtime" name="hdRtime" value="<%=hdRtime%>" />
<input type="hidden" id="hdRetday" name="hdRetday" value="<%=hdRetday%>" />
<input type="hidden" id="hdRettime" name="hdRettime" value="<%=hdRettime%>" />
<input type="hidden" id="hdRlocation" name="hdRlocation" value="<%=hdRlocation%>" />
<input type="hidden" id="hdRoffice" name="hdRoffice" value="<%=hdRoffice%>" />
<input type="hidden" id="hdRetlocation" name="hdRetlocation" value="<%=hdRetlocation%>" />
<input type="hidden" id="hdRetoffice" name="hdRetoffice" value="<%=hdRetoffice%>" />
<input type="hidden" id="hdNaviCheck" name="hdNaviCheck" />
<input type="hidden" id="hdInsuranceSeq" name="hdInsuranceSeq" />
<input type="hidden" id="hdTotalDay" name="hdTotalDay" />
<input type="hidden" id="hdTotalTime" name="hdTotalTime" />
<input type="hidden" id="hdPrice" name="hdPrice" />
<input type="hidden" id="hdTotalPrice" name="hdTotalPrice" />
<input type="hidden" id="hdDc" name="hdDc" value="<%=memberGradeDcRate%>" />
</form>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
  	<td bgcolor="#D5D5D5">
  	
  	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  <tr>
  		<td>
  	
	  	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	  	  <tr>
	  		<td width="20"><img src="<%=root%>/images/reserve/side_left_top.gif"></td>
	  		<td width="100%" height="20" background="<%=root%>/images/reserve/side_top.gif"></td>
	  	  	<td><img src="<%=root%>/images/reserve/side_right_top.gif"></td>
	  	  </tr>
	  	  <tr>
	  	  	<td width="20" background="<%=root%>/images/reserve/side_left.gif"></td>
	  	  	<td valign="top" bgcolor="#3F3F3F">
	  	  	
	<!-- 컨텐츠 영역 테이블 시작 -->
  	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  <tr>
  	  	<td width="300" valign="top">
  	  	
  	  	<!-- 좌측 영역 시작 -->
  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td height="32">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_left.gif"></td>
  	  	  	  	  	<td background="<%=root%>/images/reserve/bar_bg.gif"><img src="<%=root%>/images/reserve/title_01_01.gif"></td>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_right.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr><td height="5"></td></tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">대여</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<input type="text" id="rdatepicker" size="12" value="<%=hdRday%>"
  	  	  	  	  		   onchange="javascript:onChangeRday(this)"
  	  	  	  	  		   class="input_dark">&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRtimeH" 
  	  	  	  	  			onchange="javascript:onChangeRtimeH(this)"
  	  	  	  	  			class="select">
  	  	  	  	  		<option>선택</option>
<%
	for ( int i=0; i<24; i++ )
	{
		if ( i < 10 ) numStr = "0" + i;
		else		  numStr = "" + i;
%>  	  	  	  	  	
			         	<option value="<%=numStr%>" <%=numStr.equals( hdRtimeH )? "selected" : ""%>><%=numStr%></option>
<%
	}
%>	
			        </select>시&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRtimeM" 
  	  	  	  	  			onchange="javascript:onChangeRtimeM(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택</option>
<%
	for ( int i=0; i<60; i+=10 )
	{
		if ( i < 10 ) numStr = "0" + i;
		else		  numStr = "" + i;
%>  	  	  	  	  	
			         	<option value="<%=numStr%>" <%=numStr.equals( hdRtimeM )? "selected" : ""%>><%=numStr%></option>
<%
	}
%>	
			         </select>분
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td colspan="4">
  	  	  	  	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	      <tr><td height="5"></td></tr>
  	  	  	  	      <tr><td background="<%=root%>/images/reserve/line_dot_01.gif"></td></tr>
  	  	  	  	      <tr><td height="5"></td></tr>
  	  	  	  	    </table>
  	  	  	  	    </td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">반납</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<input type="text" id="retdatepicker" size="12" value="<%=hdRetday%>"
  	  	  	  	  		   onchange="javascript:onChangeRetday(this)"
  	  	  	  	  		   class="input_dark">&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRettimeH" 
  	  	  	  	  			onchange="javascript:onChangeRettimeH(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택</option>
<%
	for ( int i=0; i<24; i++ )
	{
		if ( i < 10 ) numStr = "0" + i;
		else		  numStr = "" + i;
%>  	  	  	  	  	
			         	<option value="<%=numStr%>" <%=numStr.equals( hdRettimeH )? "selected" : ""%>><%=numStr%></option>
<%
	}
%>			         	
			        </select>시&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRettimeM" 
  	  	  	  	  			onchange="javascript:onChangeRettimeM(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택</option>
<%
	for ( int i=0; i<60; i+=10 )
	{
		if ( i < 10 ) numStr = "0" + i;
		else		  numStr = "" + i;
%>  	  	  	  	  	
			         	<option value="<%=numStr%>" <%=numStr.equals( hdRettimeM )? "selected" : ""%>><%=numStr%></option>
<%
	}
%>	
			         </select>분
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	</table>
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td height="32">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_left.gif"></td>
  	  	  	  	  	<td background="<%=root%>/images/reserve/bar_bg.gif"><img src="<%=root%>/images/reserve/title_01_02.gif"></td>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_right.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr><td height="5"></td></tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			  	<!-- 컨텐츠 시작 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">대여점</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbRoffice"
  	  	  	  	  			value="<%=hdRlocation%>|<%=hdRoffice%>"
  	  	  	  	  			onchange="javascript:onChangeRoffice(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택하세요</option>
<%	
	value = "";
	selectedValue = hdRlocation + "|" + hdRoffice;
	codeType = CodeProperties.CAR_LO;
	for ( CodeInfoDTO dto : CodeProperties.codeCarOfficeList )
	{
		codeOffice = dto.getCode();
		codeCarLo = CodeProperties.getCodeCarLo( dto.getCode() );
		location = CodeProperties.getCodeName( codeType, codeCarLo );
		value = codeCarLo + "|" + dto.getCode();
%>
			         	<option value="<%=value%>" <%=value.equals( selectedValue )? "selected" : ""%>>[<%=location%>] <%=dto.getName()%></option>
<%
	}
	if ( !StringUtil.hasNull( selectedValue ) )
	{
		System.out.println( "selectedValue : " + selectedValue );
		System.out.println( "-- SCRIPT CALL --" );
		out.println("<script language=javascript>");
		out.println("onSelctedRoffice();");
		out.println("</script>");
	}
%>			         	
			         </select>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td colspan="2">
  	  	  	  	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	      <tr><td height="5"></td></tr>
  	  	  	  	      <tr><td background="<%=root%>/images/reserve/line_dot_01.gif"></td></tr>
  	  	  	  	      <tr><td height="5"></td></tr>
  	  	  	  	    </table>
  	  	  	  	    </td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">반납점</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbRetoffice"
  	  	  	  	  			value="<%=hdRetlocation%>|<%=hdRetoffice%>"
  	  	  	  	  			onchange="javascript:onChangeRetoffice(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택하세요</option>
<%		
	value = "";
	selectedValue = hdRetlocation + "|" + hdRetoffice;
	codeType = CodeProperties.CAR_LO;
	for ( CodeInfoDTO dto : CodeProperties.codeCarOfficeList )
	{
		codeOffice = dto.getCode();
		codeCarLo = CodeProperties.getCodeCarLo( dto.getCode() );
		location = CodeProperties.getCodeName( codeType, codeCarLo );
		value = codeCarLo + "|" + dto.getCode();
%>
			         	<option value="<%=value%>" <%=value.equals( selectedValue )? "selected" : ""%>>[<%=location%>] <%=dto.getName()%></option>
<%
	}
%>	
			         </select>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	</table>
				<!-- 컨텐츠 끝 -->
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td height="32">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_left.gif"></td>
  	  	  	  	  	<td background="<%=root%>/images/reserve/bar_bg.gif"><img src="<%=root%>/images/reserve/title_01_03.gif"></td>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_right.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr><td height="5"></td></tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			  	<!-- 컨텐츠 시작 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">아이디</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_id()%></td>
  	  	  	  	  	<td width="60"><span class="txt_name">등급</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberGrade%></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">이름</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_name()%></td>
  	  	  	  	  	<td width="60"><span class="txt_name">연락처</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_phone1()%>-<%=memberDTO.getMember_phone2()%>-<%=memberDTO.getMember_phone3()%></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">대여일</span></td>
  	  	  	  	  	<td id="cellRday"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">대여시</span></td>
  	  	  	  	  	<td id="cellRtime">
  	  	  	  	  	<table>
  	  	  	  	  	  <tr>
  	  	  	  	  	  	<td id="cellRtimeH"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	  	<td id="cellRtimeM"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	  </tr>
  	  	  	  	  	</table>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">반납일</span></td>
  	  	  	  	  	<td id="cellRetday"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">반납시</span></td>
  	  	  	  	  	<td id="cellRettime">
  	  	  	  	  	<table>
  	  	  	  	  	  <tr>
  	  	  	  	  	  	<td id="cellRettimeH"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	  	<td id="cellRettimeM"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	  </tr>
  	  	  	  	  	</table>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">대여지점</span></td>
  	  	  	  	  	<td id="cellRoffice"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">반납지점</span></td>
  	  	  	  	  	<td id="cellRetoffice"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">차종</span></td>
  	  	  	  	  	<td id="cellCarGrade"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">모델명</span></td>
  	  	  	  	  	<td id="cellCarName"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <!--  
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60">성별</td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_gender()%></td>
  	  	  	  	  	<td width="60">이메일</td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_email1()%>@<%=memberDTO.getMember_email2()%></td>
  	  	  	  	  </tr>
  	  	  	  	  -->
  	  	  	  	</table>
				<!-- 컨텐츠 끝 -->
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	</table>
  	  	<!-- 좌측 영역 끝 -->
  	  	
  	  	</td>
  	  	<td width="20"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	<td valign="top">
  	  	
  	  	<!-- 우측 영역 시작 -->
  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td height="32">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_left.gif"></td>
  	  	  	  	  	<td background="<%=root%>/images/reserve/bar_bg.gif"><img src="<%=root%>/images/reserve/title_01_04.gif"></td>
  	  	  	  	  	<td width="16"><img src="<%=root%>/images/reserve/bar_right.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr><td height="5"></td></tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			<!-- 컨텐츠 시작 -->
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td valign="top">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tbody id="carRentTable">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="25"><span class="txt_name">NO.</span></td>
  	  	  	  	  	<td width="30"><span class="txt_name">표지</span></td>
  	  	  	  	  	<td width="30"><span class="txt_name">차종</span></td>
  	  	  	  	  	<td><span class="txt_name">모델명</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">제조사</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">연료</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">배기량</span></td>
  	  	  	  	  	<td width="25"><span class="txt_name">인원</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">일가격</span></td>
  	  	  	  	  </tr>
  	  	  	  	  </tbody>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<!-- 하단 페이징 -->
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr><td colspan="3" height="15"></td></tr>
					<tr id="rowPage" />
				</table>
				<br>
				<!-- 하단 페이징 -->
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
			<!-- 컨텐츠 끝 -->
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			<!-- 컨텐츠 시작 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td width="70%">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">보험선택</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbInsurance"
  	  	  	  	  			onchange="javascript:onChangeInsurance(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>선택하세요</option>
<%
	for ( InsuranceDTO dto : CodeProperties.codeInsuranceList )
	{
%>
			         	<option value="<%=dto.getInsurance_seq()%>|<%=dto.getInsurance_price()%>"><%=dto.getInsurance_type()%>(<%=dto.getInsurance_price()%>원)</option>
<% 
	}
%>			         	
			         </select> 보험을 선택하세요.
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  	<td width="10"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="80"><span class="txt_name">네비게이션</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<input type="checkbox" id="ckNavi" 
  	  	  	  	  		   onClick="javascript:onClickNavi(this)"
  	  	  	  	  		   class="checkbox_trans"/>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
			<!-- 컨텐츠 끝 -->
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="10"><!-- 여백 --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- 단위 테이블 시작 -->
  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_top.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_top_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_top.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr>
			  	  	<td width="10" background="<%=root%>/images/reserve/box_left_bg.gif"></td>
			  	  	<td valign="top" bgcolor="#363636">
			  	  	
			  	<!-- 컨텐츠 시작 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">총이용기간</span></td>
  	  	  	  	  	<td><span id="infoTotalTime" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5"></td>
  	  	  	  	  	<td width="70"><span class="txt_name">정상요금</span></td>
  	  	  	  	  	<td><span id="infoRentPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">원</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">할인적용률</span></td>
  	  	  	  	  	<td><span id="infoDcRate" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">%</td>
  	  	  	  	  	<td width="70"><span class="txt_name">네비요금</span></td>
  	  	  	  	  	<td><span id="infoNaviPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">원</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">보험금액</span></td>
  	  	  	  	  	<td><span id="infoInsurancePrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">원</td>
  	  	  	  	  	<td width="70"><span class="txt_name">적용금액</span></td>
  	  	  	  	  	<td><span id="infoTotalPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">원</td>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <!--  
  	  	  	  	  <tr>
  	  	  	  	  	<td colspan="4" align="right">
  	  	  	  	  	<input type="button" value="예약하기" 
  	  	  	  	  		   onclick="javascript:onClickReserve()"> 
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  -->
  	  	  	  	</table>
				<!-- 컨텐츠 끝 -->
			  	  	
			  	  	</td>
					<td width="10" background="<%=root%>/images/reserve/box_right_bg.gif"></td>	  	  	
			  	  </tr>
  	  	  	  	  <tr>
			  		<td width="10"><img src="<%=root%>/images/reserve/box_left_bottom.gif"></td>
			  		<td width="100%" height="10" background="<%=root%>/images/reserve/box_bottom_bg.gif"></td>
			  	  	<td><img src="<%=root%>/images/reserve/box_right_bottom.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
  	  	  	<!-- 단위 테이블 끝 -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	</table>
  	  	<!-- 우측 영역 끝 -->
  	  	
  	  	</td>
  	  </tr>
  	</table>
  	<!-- 컨텐츠 영역 테이블 끝 -->
	  	  	
	  	  	</td>
	  	  	<td width="20" background="<%=root%>/images/reserve/side_right.gif"></td>
	  	  </tr>
	  	  <tr>
	  		<td><img src="<%=root%>/images/reserve/side_left_bottom_dark.gif"></td>
	  		<td height="40" background="<%=root%>/images/reserve/side_bottom_dark.gif"
	  			align="center" valign="middle">
	  		
	  		<img src="<%=root%>/images/reserve/btn_close.gif" style="cursor:hand" onclick="self.close()">
	  		<img src="<%=root%>/images/reserve/btn_reserve.gif" style="cursor:hand" onclick="javascript:onClickReserve()">
	  		
	  		</td>
	  	  	<td><img src="<%=root%>/images/reserve/side_right_bottom_dark.gif"></td>
	  	  </tr>
	  	</table>
  		
  		</td>
  	  </tr>
  	</table>
  	
  	</td>
  </tr>
</table>
</body>
</html>
<%
	}
%>