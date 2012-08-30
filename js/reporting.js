var repurl = "controllers/tin/report.asp?",
	reportContainerId = "rptOutput",
	reportParams = '';
$(function(){
	$('input#submittime_start').datepicker({
		'onSelect': function(dateText, inst){
			$('input#submittime_end').datepicker( 'option','minDate',dateText );
		},
		showAnim: ''
	});
	$('input#submittime_end').datepicker({
		'onSelect': function(dateText, inst){
			$('input#submittime_start').datepicker( 'option','maxDate',dateText );
		},
		showAnim: ''
	});
	
	$('form#rpt').submit(function(e){
		e.preventDefault();
		reportParams = $('form#rpt').serialize();
		$.get(repurl+reportParams,function(data){
			$('#'+reportContainerId).empty();
			$('#'+reportContainerId).append(data);
			$('table#tblReport').dataTable({ 
				"bPaginate": false,
				"bLengthChange": false,
				"bFilter": true,
				"bInfo": false,
				"bAutoWidth": false 
			}); 
		});
	});
	
	$('div#ajaxmsg').ajaxError(function(e, jqXHR, ajaxSettings, thrownError){
		$(this).append("<pre>"+jqXHR.responseText+"</pre><br />");
	});
	
	$('select#status').css('width','100%');
});