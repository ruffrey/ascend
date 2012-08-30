var dtcols;
$(function(){
	$.ajaxSetup({
		cache: false
	});
	
	$('div.container ul.nav li a').each(function(){
		if(
			window.location.toString().toLowerCase().indexOf(
				$(this).attr('href').toLowerCase()
			) >-1
		)
		{
			$(this).parent('li').addClass('active');
			$(this).children('i').addClass('icon-white');
		}
	});
	
	// initialize dataTable plugin
	$('table.datatable').each(function(){
		dtcols=$(this).find('tr')[0].cells.length-1;
		//alert(dtcols);
		$(this).dataTable({
			"bPaginate": false,
			"bLengthChange": false,
			"bFilter": true,
			"bInfo": false,
			"bAutoWidth": false,
			// always sort by last column
			"aaSorting": [[ dtcols, "desc" ]]
		});
	}); 
	
	$('table.datatable th').not('.nosort').attr('title','Click to sort');
	
	$('table.datatable td a.btn').parent('td').css('text-align','center');
	
	// navbar search - placeholder interaction for non-html5 browsers
	$('form.navbar-search input.search-query').each(function(){
		$(this).val( $(this).attr('placeholder') );
	}).blur(function(){
		if( $(this).val() == "")
		{
			$(this).val( $(this).attr('placeholder') );
		}
	}).focus(function(){
		if( $(this).val() == $(this).attr('placeholder') )
		{
			$(this).val('');
		}
	});
	
	// don't submit if input is blank or is the placeholder value
	$('form#search').submit(function(e){
		var s = $('input#query').val(),
			p = $('input#query').attr('placeholder');
		if(!s || s==p)
		{
			e.preventDefault();
		}
	});
	
	// query icon submits search
	$('i#iq').click(function(){
		$('form#search').submit();
	}).hover(function(){
		$(this).removeClass('icon-white');
	}, function(){
		$(this).addClass('icon-white');
	});
	
	// after closing notification, remove the notification from the URL
	$('.close').click(function(){
		window.location.replace(
			window.location.toString().replace(window.location.search,'')
		);
	});
	
	// ajax 'Loading' indicator screen
	$('div.ajaxscreen').ajaxStart(function(){
		$(this).show();
	}).ajaxStop(function(){
		$(this).hide();
	});
	
	// Impersonate dialog closes on escape
	$('#btnImp').click(function(e){
		e.preventDefault();
		$('div#formImp').fadeIn(200);
		$('input#impersonate').focus();
		// set esc to close
		$(document).keyup(function(e){
			if(e.which=='27')
			{
				$('div#formImp').fadeOut(200);
			}
		});
	});
	
	// impersonate dialog cancel button
	$('#btnImpCancel').click(function(e){
		e.preventDefault();
		$('div#formImp').fadeOut(200);
	});

});