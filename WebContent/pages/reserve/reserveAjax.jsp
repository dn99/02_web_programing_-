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
	//���� ��� ���� ���� üũ
	String reserveOK = request.getParameter( "reserveOK" );
	System.out.println( "reserveOK : " + reserveOK );
	if ( !StringUtil.hasNull( reserveOK ) )
	{	
		out.println("<script language=javascript>");
		out.println("alert( '���������� ������ ��� �Ǿ����ϴ�.' );");
		out.println("self.close();");
		out.println("opener.location.reload();");
		out.println("</script>");
	}

	//MemberDTO memberDTO = new MemberDTO();
	//memberDTO.setMember_id("hansik");
	//memberDTO.setMember_name("���ѽ�");
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
		out.println("alert( '�α����ϼž� ������ �����մϴ�.' );");
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
	var carGradeCodes = [];		// ���� ��� ������ŭ�� ���� ��� �ڵ� �迭
	var carMakerCodes = [];		// ���� ��� ������ŭ�� ������ �ڵ� �迭
	var carFuelTypeCodes = [];	// ���� ��� ������ŭ�� ����Ÿ�� �ڵ� �迭

	var isCarGrade = false;		// ���� ��� �̸� ���� �Ϸ� ����
	var isCarMaker = false;		// ������ �̸� ���� �Ϸ� ����
	var isCarFuelType = false;	// ����Ÿ�� �̸� ���� �Ϸ� ����
	
	var totalTime = 0;			// ���� ��Ż �̿�ð�
	var rentPrice = 0;			// �ϴ� ��Ʈ����
	var insurancePrice = 0;		// ���谡��
	var naviPrice = 0;			// �׺񰡰�
	var dcRate = 0;				// ���η�
	var totalPrice = 0;			// ���� ��Ʈ ��Ż ����
	
	var totalTimeInfo = "";
	var pg = 1;
	
	// ���� ��� �̸� ȣ��
	function callCarGradeName( codeValues )
	{
		var codeType = CAR_GRADE;
		callCodeName( codeType, codeValues, receiveCarGradeName );
	}
	
	// ������ �̸� ȣ��
	function callCarMakerName( codeValues )
	{
		var codeType = MAKER;
		callCodeName( codeType, codeValues, receiveCarMakerName );
	}
	
	// ����Ÿ�� �̸� ȣ��
	function callCarFuelTypeName( codeValues )
	{
		var codeType = FUEL_TYPE;
		callCodeName( codeType, codeValues, receiveCarFuelTypeName );
	}
	
	// �뿩���� �̸� ȣ��
	function callCarROfficeName( codeValues )
	{
		//alert("1===> " + codeValues);
		var codeType = CAR_OFFICE;
		callCodeName( codeType, codeValues, receiveRCarOfficeName );
	}
	
	// �ݳ����� �̸� ȣ��
	function callCarRetOfficeName( codeValues )
	{
		var codeType = CAR_OFFICE;
		callCodeName( codeType, codeValues, receiveRetCarOfficeName );
	}
	
	// httpRequest - �ڵ忡 ���� �̸� ȣ��
	function callCodeName( codeType, codeValues, callBackFun )
	{
		alert("2===> " + codeValues);
		var param = "act=getCodeName&codeType=" + codeType + "&codeValues=" + codeValues;
		sendRequest( "<%=root%>/reserve", param, callBackFun, "GET" );
	}
	
	// ��� �ڵ� ���� �ʱ�ȭ
	function initCodes()
	{
		carGradeCodes = [];
		carMakerCodes = [];
		carFuelTypeCodes = [];
		
		isCarGrade = false;
		isCarMaker = false;
		isCarFuelType = false;
	}
	
	// httpRequest - ���� ��� �׺����� ȣ��
	function callCarPageNavi( pg )
	{
		initCodes();
		var values = getSplitValues( document.getElementById( "cbRoffice" ).value, "|" );
		var rlocation = values[0];
		var roffice = values[1];
		var param = "act=carPageNavi&pg=" + pg + "&roffice=" + roffice;
		sendRequest( "<%=root%>/reserve", param, receiveCarPageNavi, "GET" );
	}
	
	// httpRequest - ���� ��� ȣ��
	function callCarList( pg )
	{
		var values = getSplitValues( document.getElementById( "cbRoffice" ).value, "|" );
		var rlocation = values[0];
		var roffice = values[1];
		var param = "act=carList&pg=" + pg + "&roffice=" + roffice;
		sendRequest( "<%=root%>/reserve", param, receiveRentCarList, "GET" );
	}
	
	// �ݹ� �Լ� - ���� ��� �̸�
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
	
	// �ݹ� �Լ� - ������ �̸�
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
	
	// �ݹ� �Լ� - ����Ÿ�� �̸�
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
	
	// �ݹ� �Լ� - �뿩���� �̸�
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
	
	// �ݹ� �Լ� - �ݳ����� �̸�
	function receiveRetCarOfficeName()
	{
		if ( hasResult() )
		{
			var carOfficeNameValues = httpRequest.responseText;
			var carOfficeNames = getSplitValues( carOfficeNameValues, "|" );
			setCellInfo( carOfficeNames[0], "cellRetoffice", "" );
		}
	}
	
	// �ݹ� �Լ� - ���� ��� ������ �׺� 
	function receiveCarPageNavi()
	{
		if ( hasResult() ) 
		{
			var pageNaviJsonData = eval('(' + httpRequest.responseText +')');
			createPageNavi( pageNaviJsonData );
			callCarList( pg );
		}	
	}
	
	// �ݹ� �Լ� - ���� ��� 
	function receiveRentCarList()
	{
		if ( hasResult() ) setData( httpRequest.responseXML );
	}
	
	// httpRequest ȣ�� ���� ���� ��ȯ
	function hasResult()
	{
		var isResult = false;
		if ( httpRequest.readyState == 4 )
			if ( httpRequest.status == 200 ) isResult = true;
		
		return isResult;
	}
	
	// ����¡ ���� ��� ���� �� ����
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
	
	// í�� ��� ���� ��ŭ ���� �� ����Ÿ ����
	function setData( rentCarXMLData )
	{
		removeData();
		
		var rowTop = createRowTop();
		carRentTable.appendChild( rowTop );
		
		// ���� ��� XML �Ľ� ���� ȭ�� ���
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
	
	// ���� ��� ����Ÿ �ʱ�ȭ
	function removeData()
	{
		var len = carRentTable.childNodes.length - 1;
		for ( var i=len; i>=1; i-- )
		{
			carRentTable.removeChild( carRentTable.childNodes[i] );
		}
	}
	
	// ���� ��� ��� �ٹٲ� ó��
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
	
	// ���� ��� �ٹٲ� ���� ���� ó��
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
	
	// ���� ��� �Ѱ� ROW ����
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
				
				// row ������ŭ�� ������� �ڵ带 ��� �д�.
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
				
				// row ������ŭ�� ������� �ڵ带 ��� �д�.
				carMakerCodes[ carMakerCodes.length ] = data[i].firstChild.nodeValue;
			}
			if ( nodeName == "car_fueltype" ) 
			{
				cellFueltype = document.createElement( "td" );
				cellFueltype.id = nodeName;
				
				// row ������ŭ�� ������� �ڵ带 ��� �д�.
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
	
	// ���� �����  �ڵ带 �ش� �̸����� ȣ��
	function getRowCodeName()
	{
		// ���� ���ε�
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
	
	// ��ü �ڵ带 '|'���� ������ ���ڿ� ��ȯ 
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
	
	// ���� ��Ͽ��� �ڵ�� �� �κ��� �ش� �̸����� ����
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
	
	// �ش� ���� ���̵�� ���� ����
	function changeCellInfo( elementId, cellId, del )
	{
		var value = getCellValue( elementId );
		setCellInfo( value, cellId, del );
	}
	
	// �ش� ���� ������ ���� ����
	function setCellInfo( value, cellId, del )
	{
		var txtNode = document.createTextNode( value + del );
		var cell = document.getElementById( cellId );
		removeAllChild( cell );
		cell.appendChild( txtNode );
	}
	
	// �ش� ���� �� ��ȯ
	function getCellValue( elementId )
	{
		return document.getElementById( elementId ).value;
	}
	
	// ��� �ڽ� ��ü ����
	function removeAllChild( element )
	{
		var len = element.childNodes.length - 1;
		for ( var i=len; i>=0; i-- )
		{
			element.removeChild( element.childNodes[i] );
		}
	}
	
	// ���� ������ ���� �Է�
	function setValue( elementId, value )
	{
		var form = document.reserveForm;
		form[elementId].value = value;
	}
	
	// ���� �Էµ� ���� ��ȯ
	function getValue( elementId )
	{
		var form = document.reserveForm;
		return form[elementId].value;
	}
	
	// �Էµ� ���� ��ȿ�� üũ �� ��ȿ���� ��ȯ
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
	
	// ���� ���� ��� �� �Է°��� ��ȿ�� üũ
	function validateValue()
	{
		if ( !hasValidateValue( 'hdRday', false ) ) 
		{
			alert( "�뿩���� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdRtime', false ) ) 
		{
			alert( "�뿩�ð��� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdRetday', false ) ) 
		{
			alert( "�ݳ����� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdRettime', false ) ) 
		{
			alert( "�뿩�ð��� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdRlocation', true ) || !hasValidateValue( 'hdRoffice', true ) ) 
		{
			alert( "�뿩���� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdRetlocation', true ) || !hasValidateValue( 'hdRetoffice', true ) ) 
		{
			alert( "�ݳ����� �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdCarSeq', true ) ) 
		{
			alert( "������ �������ּ���." );
			return false;
		}
		if ( !hasValidateValue( 'hdInsuranceSeq', true ) ) 
		{
			alert( "������ �������ּ���." );
			return false;
		}
		
		return true;
	}
	
	// ������ ��¥�� ��ȿ�� üũ
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
				document.getElementById( "retdatepicker" ).value = "����";
				alert( "���� ��¥ ���ķ� �����ϼž� �մϴ�." );
				return false;
			}	
		}
		
		var dateCurrentGap = selectedDate.getTime() - currentDate.getTime();
		if ( dateCurrentGap <= 0 ) 
		{
			document.getElementById( "rdatepicker" ).value = "����";
			alert( "���� ��¥ ���ķ� �����ϼž� �մϴ�." );
			return false;
		}
		else
		{
			return true;
		}	
	}
	
	// ���� ���� ���� ���� ����
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
	
	// ���� ���� ���� ���� ���� ����
	function setReservePriceValue( elementId, value )
	{
		var cellInfo = document.getElementById( elementId );
		
		// ���� ������ �����Ͽ� ���� �ְ� �ִٸ� �� ����
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
	
	// ���� ���� ���� ���� ��� ����
	function removeReservePriceInfo()
	{
		removeReservePriceValue( "infoTotalTime" );
		removeReservePriceValue( "infoRentPrice" );
		removeReservePriceValue( "infoDcRate" );
		removeReservePriceValue( "infoNaviPrice" );
		removeReservePriceValue( "infoInsurancePrice" );
		removeReservePriceValue( "infoTotalPrice" );
	}
	
	// ���� ���� ���� ���� ���� ����
	function removeReservePriceValue( elementId )
	{
		var cellInfo = document.getElementById( elementId );
		cellInfo.removeChild( cellInfo.firstChild );
	}
	
	// ���� ���� ����Ͽ� ��ȯ
	function getTotalPrice()
	{
		var timePerPrice = rentPrice / 24;
		var sumPrice = totalTime * timePerPrice + insurancePrice + naviPrice;
		
		// 100�� ���� ���� �ݿø�
		//var totalPrice = ( Math.round( parseInt( sumPrice ) * 100 ) ) / 100;
		var totalPrice = ( Math.round( sumPrice / 100 ) ) * 100;
		
		return totalPrice;
	}
	
	// �뿩/�ݳ� �ð� ������ �����Ͽ� ��ȯ
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
	
	// ���̿�ð�, ���̿� �ϼ� ����
	function setDatePeriod()
	{
		// ��� ��¥/�ð� ������ ��� ���õǾ��ٸ� ����
		if ( !hasValidateValue( 'hdRday', false ) ) return;
		if ( !hasValidateValue( 'hdRtime', false ) ) return;
		if ( !hasValidateValue( 'hdRetday', false ) ) return;
		if ( !hasValidateValue( 'hdRettime', false ) ) return;
		
		var startDate = getFullDate( 'hdRday', 'hdRtime' );
		var endDate = getFullDate( 'hdRetday', 'hdRettime' );
		
		// �� ����(startTime, endTime) ������ ���̸� ���Ѵ�.
		var dateGap = endDate.getTime() - startDate.getTime();
		var timeGap = new Date( 0, 0, 0, 0, 0, 0, endDate - startDate ); 
		
		// �� ����(startTime, endTime) ������ ������ "��-�ð�-��"���� ǥ���Ѵ�.
		var diffDay  = Math.floor( dateGap / ( 1000 * 60 * 60 * 24 ) );		// �ϼ�       
		var diffHour = timeGap.getHours();       							// �ð� 
		var diffMin  = timeGap.getMinutes();      							// ��
		var diffSec  = timeGap.getSeconds();      							// ��
		
		// 30�� �̻��̸� 1�ð��� ���ϴ°ɷ� ���� - ex) 2�� 2�ð� 40���� ��� �̿�ð��� ���� ����� 2�� 3�ð����� ���
		if ( diffMin >= 30 ) diffHour += 1;
		
		//alert( "diffDay : " + diffDay + "    diffHour : " + diffHour + "    diffMin : " + diffMin + "    diffSec : " + diffSec );
		
		totalTimeInfo = diffDay + " ��  " + diffHour + " �ð�";
		totalTime = diffDay * 24 + diffHour;
		
		setValue( 'hdTotalDay', diffDay );
		setValue( 'hdTotalTime', diffHour );
	}
	
	// ��¥+�ð� ������ ���� Date ��ü ��ȯ
	function getFullDate( dayId, timeId )
	{
		var form = document.reserveForm;
		
		//alert( form[dayId].value + "   " + form[timeId].value );
		
		var days = getSplitValues( form[dayId].value, "." );
		var times = getSplitValues( form[timeId].value, ":" );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ), parseInt( times[0] ), parseInt( times[1] ), parseInt( times[2] ) );
	
		return date;
	}
	
	// ��¥ ������ ���� Date ��ü ��ȯ
	function getDate( dayId )
	{
		var form = document.reserveForm;
		
		var days = getSplitValues( form[dayId].value, "." );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ) );
	
		return date;
	}
	
	// ��¥ ���ڿ�(2011.10.24)�� Date ��ü�� ��ȯ
	function getStrToDate( dayStr )
	{
		var days = getSplitValues( dayStr, "." );
		var date = new Date(  parseInt( days[0] ), parseInt( days[1] )-1, parseInt( days[2] ) );
		
		return date;
	}
	
	// ���� '|'�� ����� ���ڿ��� �и��Ͽ� �迭�� ��� ��ȯ
	function getSplitValues( valueStr, del )
	{
		var values = valueStr.split( del );
		
		return values;
	}
	
	// ��Ÿ�� - ���� ��� ������ �÷�
	function onRentCarOverColor( row ) 
	{
		row.style.background = "#DDDDDD";
	}
	
	// ��Ÿ�� - ���� ��� �ƿ��� �÷�
	function onRentCarOutColor( row ) 
	{
		row.style.background = "#FFFFFF";
	}
	
	// �̺�Ʈ�ڵ鷯 - ���� ��Ͽ��� ���� Ŭ��
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
	
	// �̺�Ʈ�ڵ鷯 - �뿩�� ����
	function onChangeRday( element )
	{
		var value = getCellValue( element.id );
		
		if ( !checkDateValidate( value, "" ) ) return;
		
		setCellInfo( value, "cellRday", "" );
		setValue( 'hdRday', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �뿩�ð� ����
	function onChangeRtimeH( element )
	{
		var value = getTimeValue( true );
		changeCellInfo( element.id, "cellRtimeH", "��" );
		setValue( 'hdRtime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �뿩�� ����
	function onChangeRtimeM( element )
	{
		var value = getTimeValue( true );
		changeCellInfo( element.id, "cellRtimeM", "��" );
		setValue( 'hdRtime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �ݳ��� ����
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
	
	// �̺�Ʈ�ڵ鷯 - �ݳ��ð� ����
	function onChangeRettimeH( element )
	{
		var value = getTimeValue( false );
		changeCellInfo( element.id, "cellRettimeH", "��" );
		setValue( 'hdRettime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �ݳ��� ����
	function onChangeRettimeM( element )
	{
		var value = getTimeValue( false );
		changeCellInfo( element.id, "cellRettimeM", "��" );
		setValue( 'hdRettime', value );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �뿩���� ����
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
	
	// �̺�Ʈ�ڵ鷯 - �ݳ����� ����
	function onChangeRetoffice( element )
	{
		if ( isNull( element.value ) ) return;
		
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		callCarRetOfficeName( values[1] );
		setValue( 'hdRetlocation', values[0] );
		setValue( 'hdRetoffice', values[1] );
	}
	
	// �̺�Ʈ�ڵ鷯 - ���� ����
	function onChangeInsurance( element )
	{
		var value = getCellValue( element.id );
		var values = getSplitValues( value, "|" );
		setValue( 'hdInsuranceSeq', values[0] );
		insurancePrice = parseInt( values[1] );
		
		setReservePriceInfo();
	}
	
	var timeout = null;
	
	// �̺�Ʈ�ڵ鷯 - ���ο��� �����ϰ� �� ���
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
		setCellInfo( '<%=hdRtimeH%>', "cellRtimeH", "��" );
		setCellInfo( '<%=hdRtimeM%>', "cellRtimeM", "��" );
		setCellInfo( '<%=hdRetday%>', "cellRetday", "" );
		setCellInfo( '<%=hdRettimeH%>', "cellRettimeH", "��" );
		setCellInfo( '<%=hdRettimeM%>', "cellRettimeM", "��" );
		
		setDatePeriod();
		setReservePriceInfo();
	}
	
	// �̺�Ʈ�ڵ鷯 - �׺� ����
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
	
	// �̺�Ʈ�ڵ鷯 - �����ϱ� Ŭ��
	function onClickReserve()
	{
		if ( !validateValue() ) return;
		
		var cf = confirm( "�����Ͻ� ������ �����Ͻðڽ��ϱ�?" );
		if ( cf )
		{
			var form = document.reserveForm;
			form.action = "<%=root%>/reserve";
			form.submit();
		}	
	}
	
	// �̺�Ʈ �ڵ鷯 - ������ Ŭ��
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
	  	  	
	<!-- ������ ���� ���̺� ���� -->
  	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  <tr>
  	  	<td width="300" valign="top">
  	  	
  	  	<!-- ���� ���� ���� -->
  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
  	  	  	  	  	<td width="60"><span class="txt_name">�뿩</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<input type="text" id="rdatepicker" size="12" value="<%=hdRday%>"
  	  	  	  	  		   onchange="javascript:onChangeRday(this)"
  	  	  	  	  		   class="input_dark">&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRtimeH" 
  	  	  	  	  			onchange="javascript:onChangeRtimeH(this)"
  	  	  	  	  			class="select">
  	  	  	  	  		<option>����</option>
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
			        </select>��&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRtimeM" 
  	  	  	  	  			onchange="javascript:onChangeRtimeM(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>����</option>
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
			         </select>��
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
  	  	  	  	  	<td width="60"><span class="txt_name">�ݳ�</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<input type="text" id="retdatepicker" size="12" value="<%=hdRetday%>"
  	  	  	  	  		   onchange="javascript:onChangeRetday(this)"
  	  	  	  	  		   class="input_dark">&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRettimeH" 
  	  	  	  	  			onchange="javascript:onChangeRettimeH(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>����</option>
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
			        </select>��&nbsp;&nbsp;
  	  	  	  	  	<select id="cbRettimeM" 
  	  	  	  	  			onchange="javascript:onChangeRettimeM(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>����</option>
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
			         </select>��
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
			  	  	
			  	<!-- ������ ���� -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">�뿩��</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbRoffice"
  	  	  	  	  			value="<%=hdRlocation%>|<%=hdRoffice%>"
  	  	  	  	  			onchange="javascript:onChangeRoffice(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>�����ϼ���</option>
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
  	  	  	  	  	<td width="60"><span class="txt_name">�ݳ���</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbRetoffice"
  	  	  	  	  			value="<%=hdRetlocation%>|<%=hdRetoffice%>"
  	  	  	  	  			onchange="javascript:onChangeRetoffice(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>�����ϼ���</option>
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
				<!-- ������ �� -->
			  	  	
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
			  	  	
			  	<!-- ������ ���� -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">���̵�</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_id()%></td>
  	  	  	  	  	<td width="60"><span class="txt_name">���</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberGrade%></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">�̸�</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_name()%></td>
  	  	  	  	  	<td width="60"><span class="txt_name">����ó</span></td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_phone1()%>-<%=memberDTO.getMember_phone2()%>-<%=memberDTO.getMember_phone3()%></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">�뿩��</span></td>
  	  	  	  	  	<td id="cellRday"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">�뿩��</span></td>
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
  	  	  	  	  	<td width="60"><span class="txt_name">�ݳ���</span></td>
  	  	  	  	  	<td id="cellRetday"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">�ݳ���</span></td>
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
  	  	  	  	  	<td width="60"><span class="txt_name">�뿩����</span></td>
  	  	  	  	  	<td id="cellRoffice"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">�ݳ�����</span></td>
  	  	  	  	  	<td id="cellRetoffice"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">����</span></td>
  	  	  	  	  	<td id="cellCarGrade"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  	<td width="60"><span class="txt_name">�𵨸�</span></td>
  	  	  	  	  	<td id="cellCarName"><img src="<%=root%>/images/blank.gif"></td>
  	  	  	  	  </tr>
  	  	  	  	  <!--  
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60">����</td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_gender()%></td>
  	  	  	  	  	<td width="60">�̸���</td>
  	  	  	  	  	<td><img src="<%=root%>/images/blank.gif"><%=memberDTO.getMember_email1()%>@<%=memberDTO.getMember_email2()%></td>
  	  	  	  	  </tr>
  	  	  	  	  -->
  	  	  	  	</table>
				<!-- ������ �� -->
			  	  	
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	</table>
  	  	<!-- ���� ���� �� -->
  	  	
  	  	</td>
  	  	<td width="20"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	<td valign="top">
  	  	
  	  	<!-- ���� ���� ���� -->
  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
			  	  	
			<!-- ������ ���� -->
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td valign="top">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tbody id="carRentTable">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="25"><span class="txt_name">NO.</span></td>
  	  	  	  	  	<td width="30"><span class="txt_name">ǥ��</span></td>
  	  	  	  	  	<td width="30"><span class="txt_name">����</span></td>
  	  	  	  	  	<td><span class="txt_name">�𵨸�</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">������</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">����</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">��ⷮ</span></td>
  	  	  	  	  	<td width="25"><span class="txt_name">�ο�</span></td>
  	  	  	  	  	<td width="40"><span class="txt_name">�ϰ���</span></td>
  	  	  	  	  </tr>
  	  	  	  	  </tbody>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	  <tr>
  	  	  	  	<td>
  	  	  	  	<!-- �ϴ� ����¡ -->
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr><td colspan="3" height="15"></td></tr>
					<tr id="rowPage" />
				</table>
				<br>
				<!-- �ϴ� ����¡ -->
  	  	  	  	</td>
  	  	  	  </tr>
  	  	  	</table>
			<!-- ������ �� -->
			  	  	
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="20"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
			  	  	
			<!-- ������ ���� -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  <tr>
  	  	  	  	<td width="70%">
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="60"><span class="txt_name">���輱��</span></td>
  	  	  	  	  	<td>
  	  	  	  	  	<select width="100%" id="cbInsurance"
  	  	  	  	  			onchange="javascript:onChangeInsurance(this)"
  	  	  	  	  			class="select_dark">
  	  	  	  	  		<option>�����ϼ���</option>
<%
	for ( InsuranceDTO dto : CodeProperties.codeInsuranceList )
	{
%>
			         	<option value="<%=dto.getInsurance_seq()%>|<%=dto.getInsurance_price()%>"><%=dto.getInsurance_type()%>(<%=dto.getInsurance_price()%>��)</option>
<% 
	}
%>			         	
			         </select> ������ �����ϼ���.
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	</table>
  	  	  	  	</td>
  	  	  	  	<td width="10"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  	  	<td>
  	  	  	  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="80"><span class="txt_name">�׺���̼�</span></td>
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
			<!-- ������ �� -->
			  	  	
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	  <td width="10"><!-- ���� --><img src="<%=root%>/images/blank.gif" width="100%"></td>
  	  	  <tr>
  	  	  	<td valign="top">
  	  	  	
  	  	  	<!-- ���� ���̺� ���� -->
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
			  	  	
			  	<!-- ������ ���� -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">���̿�Ⱓ</span></td>
  	  	  	  	  	<td><span id="infoTotalTime" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5"></td>
  	  	  	  	  	<td width="70"><span class="txt_name">������</span></td>
  	  	  	  	  	<td><span id="infoRentPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">��</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">���������</span></td>
  	  	  	  	  	<td><span id="infoDcRate" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">%</td>
  	  	  	  	  	<td width="70"><span class="txt_name">�׺���</span></td>
  	  	  	  	  	<td><span id="infoNaviPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">��</td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td height="1" background="<%=root%>/images/reserve/line_dot_01.gif" colspan="4"></td>
  	  	  	  	  </tr>
  	  	  	  	  <tr><td height="3"></td></tr>
  	  	  	  	  <tr>
  	  	  	  	  	<td width="70"><span class="txt_name">����ݾ�</span></td>
  	  	  	  	  	<td><span id="infoInsurancePrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">��</td>
  	  	  	  	  	<td width="70"><span class="txt_name">����ݾ�</span></td>
  	  	  	  	  	<td><span id="infoTotalPrice" class="txt_point"></span><img src="<%=root%>/images/blank.gif" width="5">��</td>
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  <!--  
  	  	  	  	  <tr>
  	  	  	  	  	<td colspan="4" align="right">
  	  	  	  	  	<input type="button" value="�����ϱ�" 
  	  	  	  	  		   onclick="javascript:onClickReserve()"> 
  	  	  	  	  	</td>
  	  	  	  	  </tr>
  	  	  	  	  -->
  	  	  	  	</table>
				<!-- ������ �� -->
			  	  	
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
  	  	  	<!-- ���� ���̺� �� -->
  	  	  	
  	  	  	</td>
  	  	  </tr>
  	  	</table>
  	  	<!-- ���� ���� �� -->
  	  	
  	  	</td>
  	  </tr>
  	</table>
  	<!-- ������ ���� ���̺� �� -->
	  	  	
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