// controller Ã³¸®
var CAR_GRADE 		= 0;
var CAR_LO 			= 1;
var CAR_OFFICE 		= 2;
var FUEL_TYPE 		= 3;
var GRADE 			= 4;
var LEVEL 			= 5;
var MAKER 			= 6;
var TOUR_LO 		= 7;
var NUM_OF_PEOPLE 	= 8;
var ROOM_SIZE 		= 9;
var ROOM_TYPE 		= 10;
var INSURANCE 		= 11;

function hs_openReserveAjax( root )
{
	window.open( root + "/pages/reserve/reserveAjax.jsp", 
				"reserve", 
				"menubar=no, " +
				"status=yes, " +
				"toolbar=no, " +
				"location=no, " +
				"scrollbars=no, " +
				"top=200, " +
				"left=300, " +
				"width=900, " +
				"height=570" );
}

$(document).ready(function(){
$('#rdatepicker').datepicker({dateFormat:'yy.mm.dd'});
});
$(document).ready(function(){
	$('#retdatepicker').datepicker({dateFormat:'yy.mm.dd'});
});