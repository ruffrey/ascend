$(function(){
	$('table#tblGlossary').dataTable({ 
		"bPaginate": true,
        "bLengthChange": true,
		"bInfo": true,
		"bAutoWidth": false,
		"bStateSave": true
	}).addClass('datatable');
	
	/* Edit */
	$('.bedit').click(function(e){
		e.preventDefault();
		var _index = $(this).attr('data-ix');
		$.getJSON("data/glossary.txt",function(data){
			var _grdata = data.aaData[_index];
			$('#term').val( _grdata.term );
			$('#def').text( _grdata.def );
			$('#ix').val( _index );
			
			$('div#formGloss').fadeIn(200);
		});
	});
	
	/* Delete */
	$('.bkill').click(function(e){
		e.preventDefault();
		var _c = confirm("Really delete '"+$(this).parent().parent().parent().parent().prev('td').prev('td').text()+"'?");
		if(_c)
		{
			var _index = $(this).attr('data-ix');
			$.get("controllers/glossary/delete.asp?ix="+_index,function(data){
				if(data=='ok'){
					var _newloc=window.location.toString().split('#');
					_newloc=_newloc[0];
					window.location.replace(
						 _newloc.replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-trash'></i>&nbsp;Glossary entry was trashed.")
					);	
				}
				else{
					alert("Error:\n"+data);
				}
			});
		}
	});
	
	
	/* form submission */
	$('form#editGloss').submit(function(e){
		e.preventDefault();
		var _sdata = $(this).serialize();
		$.get("controllers/glossary/edit.asp?"+_sdata,function(data){
			if(data=='ok'){
				var _newloc=window.location.toString().split('#');
				_newloc=_newloc[0];
				window.location.replace(
					 _newloc.replace(window.location.search,'')
					+ "?notification=" + encodeURIComponent("<i class='icon-ok'></i>&nbsp;Success!")
				);	
			}
			else{
				alert("Error:\n"+data);
			}
		});
	});
	
	/* Cancel button */
	$('button#btnGlossCancel').click(function(e){
		e.preventDefault();
		$('#term,#ix').val('');
		$('#def').text('');
		$('div#formGloss').fadeOut(200);
	});
	
	/* Add new button */
	$('button#btnGlossNew').click(function(e){
		e.preventDefault();
		$('#ix,#term').val('');
		$('#def').text('');
		$('div#formGloss').fadeIn(200);
		$('#term').focus();
	});
	
});