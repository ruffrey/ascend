$(function(){
	$('input#accesstime_start').datetimepicker({
		'onSelect': function(dateText, inst){
			$('input#accesstime_end').datetimepicker( 'option','minDate',dateText );
		},
		showAnim: ''
	});
	$('input#accesstime_end').datetimepicker({
		'onSelect': function(dateText, inst){
			$('input#accesstime_start').datetimepicker( 'option','maxDate',dateText );
		},
		showAnim: ''
	});
	
	$('form#rpt').submit(function(e){
		e.preventDefault();
		reportParams = $('form#rpt').serialize();
		$.get('controllers/wt/wt.asp?'+reportParams,function(data){
			if(data=="no data")
			{
				$('div#ajaxmsg').append('<pre>No records.</pre>');
			}
			else{
				$('#rptOutput,div#ajaxmsg').empty();
				try{
					var _vtt;
					if( $('#accesstime_start').val()!='' )
					{
						_vtt = "Views between "
							 + $('input#accesstime_start').val().toUpperCase()
							 + " and "+$('input#accesstime_end').val().toUpperCase();
					}
					else{
						_vtt = "Total Views per Page";
					}
					// Render plot
					var _edata = eval(data);
					var plot1 = $.jqplot('rptOutput', _edata,{
						title: _vtt,
						seriesDefaults:{
							pointLabels: {
								show: true
							},
							renderer: $.jqplot.BarRenderer
						},
						axesDefaults: {
							tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
							tickOptions: {
								angle: -45,
								fontSize: '10pt'
							}
						},
						axes: {
							xaxis: {
								renderer: $.jqplot.CategoryAxisRenderer
							}
						}
					});
				}
				catch(er){
					$('div#ajaxmsg').append('<pre>'+er.message+'</pre>');
				}
			}
		});
	});
	
	$('div#ajaxmsg').ajaxError(function(e, jqXHR, ajaxSettings, thrownError){
		$(this).append("<pre>"+jqXHR.responseText+"</pre><br />");
	});
});