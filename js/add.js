function validation(){
	$('div#feedback').empty();
	var vh = "", r = true,
		sps = "<div><i class='icon-warning-sign'></i>",
		spe = "</div>";
	
	// none can be blank
		var prevlabel;
		$('form#tinreq textarea:not("#mdata,#headline")').each(function(){
			prevlabel = $(this).prev().prev('label').text();
			if( !$(this).val() && $(this).attr('id')!="workflow" )
			{
				vh=vh+sps+ prevlabel+" cannot be blank."+spe;
			}
			if( !$(this).val() && $(this).attr('id')=="workflow" )
			{
				if( $('input#wfgen:checked').length==0 )
				{
					vh=vh+sps+ prevlabel+" cannot be blank."+spe;
				}
			}
			if( $(this).val().length>1000 )
			{
				vh=vh+sps+ prevlabel+" cannot be over 1000 characters."+spe;
			}
		});
		$('form#tinreq textarea#headline').each(function(){
			prevlabel = $(this).prev().prev('label').text();
			if( !$(this).val() )
			{
				vh=vh+sps+ prevlabel+" cannot be blank."+spe;
			}
			if( $(this).val().length>60 )
			{
				vh=vh+sps+ prevlabel+" cannot be over 60 characters."+spe;
			}
		});
		
		$('form#tinreq textarea#mdata').each(function(){
			prevlabel = $(this).prev().prev('label').text();
			if( $(this).val().length>250 )
			{
				vh=vh+sps+ prevlabel+" cannot be over 250 characters."+spe;
			}
		});
		
	$('div#feedback').html(vh);
	
	if(vh.length>0)
	{ r = false }
	
	return r;
}
// holds workflow text when user selects general question
var wftxt="";
$(function(){
	// hide the workflow stuff if #wfgen is checked on load
	if( $('input#wfgen:checked').length>0 )
	{
		$('.twf').hide();
	}
	
	// Ajax Success / Error message feedback
	$('div#output').ajaxSuccess(function(e, xhr, settings){
		// write out response
		$(this).prepend('<div>' + xhr.responseText + '</div>');
		$.each(xhr.responseText, function(k,v){
			$(this).prepend('<div>' + k + ": " + v + '</div>');
		});
		
		// if it was an update
		if( $.trim($('input#recid').val())!='' )
		{
			window.open(
				  "edit.asp?notification="
				+ encodeURIComponent( 
					'<i class="icon-pencil"></i>&nbsp;Update was successful.'
				)
				, "_self"
			);
		}
		// if it was an insert:
		// clear the form by clicking the hidden reset button
		else{
			$('input#reset').click();
			$('textarea#issue').focus();
		}
	}).ajaxError(function(e, xhr, settings){
		// write out errors and leave form data intact
		$.each(xhr.responseText, function(k,v){
			$(this).prepend('<div>' + k + ": " + v + '</div>');
		});
	});
	
	// Form submission
	$('form#tinreq').submit(function(e){
		e.preventDefault();
		
		var v = validation();
		if(v){
			var fdata = $(this).serialize();
			
			
			// if it's an edit/update
			if( $.trim($('input#recid').val())!='' )
			{
				$.ajax({
					url: "controllers/tin/update.asp",
					type: "POST",
					data: fdata
				});
			}
			
			// if it's a new record
			else{
				$.ajax({
					url: "controllers/tin/insert.asp",
					type: "POST",
					data: fdata
				});
			}
		}
	
		// bind validation to each keyup & event
		else{
			$('form#tinreq textarea, input#wfgen').bind('keyup click', function(){
				validation();
			});
		}
	});
	
	$('form#tinreq textarea').bind('keydown keyup',function(){
		var kkv = $(this).val().length;
			kkv=kkv>1000?"<span class='badge badge-important'>"+kkv+'</span>&nbsp;':kkv;
		$(this).prev('div.pull-right').children('span.dss').html( kkv );
	});
	
	$('input#wfgen').click(function(){
		if( $('textarea#workflow').is(':visible') )
		{			
			wftxt = $('textarea#workflow').val();
			$('textarea#workflow').val('');
			$('.twf').fadeOut(200, function () {
				if ($.browser.msie) {
					this.style.removeAttribute('filter');
				}
			});
		}
		else{
			$('textarea#workflow').val(wftxt);
			$('.twf').fadeIn(200, function () {
				if ($.browser.msie) {
					this.style.removeAttribute('filter');
				}
			});
		}
	});
});