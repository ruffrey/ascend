$(function(){
	// click checkout button
	$('a.cko').click(function(){
		var recid = $(this).attr('id').replace('_','');
		$.ajax({
			url: 'controllers/tin/checkout.asp?recid='+recid,
			type: 'GET',
			dataType: 'json',
			success: function(data){
				if(data.success=='ok'){
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-list-alt'></i>Checkout successful.")
					);	
				}
				else{
					alert(data);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert(
					errorThrown
					+ "\n"
					+ jqXHR.responseText
				);
			}
			
		});
	});
	
	// terminate an issue
	$('.bkill').click(function(){
		var c = confirm("Delete this issue?");
		if(c)
		{
			var recid = $(this).attr('id').replace('_','');
			$.ajax({
				url: 'controllers/tin/terminate.asp?recid='+recid,
				type: 'GET',
				dataType: 'json',
				success: function(data){
					if(data.success=='ok'){
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-trash'></i>&nbsp;Request was trashed.")
						);	
					}
					else{
						alert(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert(
						errorThrown
						+ "\n"
						+ jqXHR.responseText
					);
				}
				
			});
		}
		return false;
	});
	
	// unhide an issue
	$('.bunhide').click(function(){
		var c = confirm("Unhide this issue?");
		if(c)
		{
			var recid = $(this).attr('id').replace('_','');
			$.ajax({
				url: 'controllers/tin/unhide.asp?recid='+recid,
				type: 'GET',
				dataType: 'json',
				success: function(data){
					if(data.success=='ok'){
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-eye-open'></i>&nbsp;Request has been unhidden.")
						);	
					}
					else{
						alert(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert(
						errorThrown
						+ "\n"
						+ jqXHR.responseText
					);
				}
				
			});
		}
		return false;
	});
	
	// hide an issue
	$('.bhide').click(function(){
		var c = confirm("Hide this issue?");
		if(c)
		{
			var recid = $(this).attr('id').replace('_','');
			$.ajax({
				url: 'controllers/tin/hide.asp?recid='+recid,
				type: 'GET',
				dataType: 'json',
				success: function(data){
					if(data.success=='ok'){
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-eye-close'></i>&nbsp;Request has been hidden.")
						);	
					}
					else{
						alert(data);
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert(
						errorThrown
						+ "\n"
						+ jqXHR.responseText
					);
				}
				
			});
		}
		return false;
	});
	
	
	
});