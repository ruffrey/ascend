function addAQueue(queuename,ulId){
	var newli = '<li id="'+queuename+'" class="ui-state-default sortable">'
			+'<i class="icon-arrow-down"></i><strong>'+queuename+'</strong><a class="btn btnRemoveQueue"><i class="icon-remove"></i></a></li>';
	
	$('ul#'+ulId).append(newli);
}

$(function(){
	if( window.location.hash )
	{
		try{
			$('#mainTabLinks a[href="'+window.location.hash+'"]').tab('show');
		} catch(er){}
	}
	// add a new rule
	$('form#add').submit(function(e){
		e.preventDefault();
		$('form#add input#val').val( $.trim( $('form#add input#val').val() ).toLowerCase() );
		if( $('form#add input#val').val() == '' )
		{
			alert('User login cannot be blank.');
			return false;
		}
		var dt = $(this).serialize();
		$.ajax({
			url: 'controllers/perm/insert.asp',
			type: 'POST',
			data: dt,
			success: function(data){
				window.location.reload(true);
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
		
	// remove rule button
	$('a.rmv').click(function(){
		var c = confirm("Are you sure?\n\nHopefully it\'s ok with them.");
		if(c)
		{
			var id = $(this).attr('id').replace('_','');
			$.ajax({
				url: 'controllers/perm/del.asp?id='+id,
				type: 'GET',
				dataType: 'json',
				success: function(data){
					if(data.success=='ok'){
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-user'></i>Rule has been deleted.")
						);	
					}
					else{
						alert(data);
						return false;
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert(
						errorThrown
						+ "\n"
						+ jqXHR.responseText
					);
					return false;
				}
				
			});
		}
	});
	
	$('#btnaddrule').click(function(){
		$('div#formadd').fadeIn(200);
		$('input#val').focus();
		// set esc to close
		$(document).keyup(function(e){
			if(e.which=='27')
			{
				$('div#formadd').fadeOut(200);
			}
		});
		return false;
	});
	
	
	$('#btncancel').click(function(){
		$('div#formadd').fadeOut(200);
		return false;
	});
	
	
	/* Roles */
	// add role button
	$('#btnaddrole').click(function(){
		$('div#divRole').fadeIn(200);
		$('input#desc').focus();
		
		return false;
	});
	
	// insert - form submission
	$('form#fRole').submit(function(){
		var valid = true;
		$('form#fRole input[type="text"]').each(function(){
			if( $.trim($(this).val()) == '' )
			{
				valid = false;
			}
		});
		if( !valid )
		{
			alert('All fields must be filled out');
		} else {	
			var dt = $(this).serialize();
			$.ajax({
				url: 'controllers/roles/insert.asp',
				type: 'GET',
				data: dt,
				dataType: 'json',
				success: function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;Success!")
						);	
					}
					else{
						alert( 'Error\n'+data );
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
	
		// cancel
		$('#bcancel').click(function(){
			$('div#divRole').fadeOut(200);
			$('form#fRole input[type="text"]').val('');
			return false;
		});
	
	// edit
	$('a.roleedit').click(function(e){
		e.preventDefault();
		var roleRec = $.get('controllers/roles/getIndex.asp?ix='+$(this).attr('data-index'),
							function(data){
								for( var i in data )
								{
									$('input[name="'+i+'"]').val(data[i]);
								}
								$('div#divRole').fadeIn(200);
								$('input#desc').focus();
							},
							'json'
					  );
	});
	
	// delete role
	$('a.roledelete').click(function(e){
		e.preventDefault();
		var c = confirm('Really delete?');
		if(c){
			$.get(
				'controllers/roles/delete.asp?ix='+$(this).attr('data-index'), 
				function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;Role was deleted successfully.")
						);	
					}
					else{
						alert( 'Error\n'+data );
					}
				},
				'json'
			);
		}
	});
	
	/* Pages */
	// add page button
	$('#btnaddpage').click(function(){
		$('div#divPagePerm').fadeIn(200);
		$('input#page').focus();
		
		return false;
	});
	
	// insert - form submission
	$('form#fPagePerm').submit(function(){
		// test
		if( $('#page').val()=='')
		{ 
			alert('Page cannot be blank.');
		}
		else {	
			var dt = $(this).serialize();
			$.ajax({
				url: 'controllers/pages/insert.asp',
				type: 'GET',
				data: dt,
				dataType: 'json',
				success: function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;Success!")
						);	
					}
					else{
						alert( 'Error\n'+data );
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
	
		// cancel
		$('#bpagecancel').click(function(){
			$('div#divPagePerm').fadeOut(200);
			$('form#fPagePerm input[type="text"]').val('');
			return false;
		});
	
	// edit
	$('a.pageedit').click(function(e){
		e.preventDefault();
		var roleRec = $.get('controllers/pages/getIndex.asp?ix='+$(this).attr('data-index'),
							function(data){
								for( var i in data )
								{
									$('input[name="'+i+'"]').val(data[i]);
								}
								$('div#divPagePerm').fadeIn(200);
								$('input#page').focus();
							},
							'json'
					  );
	});
	
	// delete page restriction rule
	$('a.pagedelete').click(function(e){
		e.preventDefault();
		var c = confirm('Really delete?');
		if(c){
			$.get(
				'controllers/pages/delete.asp?ix='+$(this).attr('data-index'), 
				function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;Page restriction rule was deleted successfully.")
						);	
					}
					else{
						alert( 'Error\n'+data );
					}
				},
				'json'
			);
		}
	});
	
	
	/* saving settings */
	$('button#submitSettings').click(function(){
		$('form#settings').submit();
	});
	
	$('form#settings').submit(function(){
		var __d = $(this).serialize();
		
		$.ajax({
			type: 'POST',
			url: 'controllers/saveSettings.asp',
			data: __d,
			dataType: 'json',
			success: function(data){
				if( data.success=='ok' )
				{
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;App settings were saved successfully.")
					);	
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('div#settingsError').empty().html( jqXHR.responseText );
				return false;
			}
		});
		return false;
	});
	
	/* Creating a new setting form */
	$('a#createSetting').click(function(e){
		e.preventDefault();
		$('div#divCreateSetting').fadeIn(200);
		
	});
	
	// cancel new setting form
	$('#bCancelSetting').click(function(){
		$('div#divCreateSetting').fadeOut(200);
		$('form#fCreateSetting input[type="text"]').val('');
		return false;
	});
	
	// on form submission - create new setting
	$('form#fCreateSetting').submit(function(){
		var __d = $(this).serialize();
		
		$.ajax({
			type: 'GET',
			url: 'controllers/createSetting.asp',
			data: __d,
			dataType: 'json',
			success: function(data){
				if( data.success=='ok' )
				{
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;New setting created successfully.")
					);	
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('div#settingsError').empty().html( jqXHR.responseText );
				return false;
			}
		});
		
		return false;
		
	});
	
	// delete a setting
	$('a.bDelSetting').click(function(e){
		e.preventDefault();
		var stg = $(this).attr('data-sid')
		   ,c = confirm('Really delete "'+stg+'"?\n\nThis can break the application.');
		
		if(c)
		{
			$.ajax({
				type: 'GET',
				url: 'controllers/deleteSetting.asp?id='+stg,
				dataType: 'json',
				success: function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-cog'></i>&nbsp;Setting <strong>"+stg+"</strong> has been deleted.")
						);	
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					$('div#settingsError').empty().html( JSON.stringify(jqXHR.responseText) );
					return false;
				}
			});			
		}
	});
	
	// clear all form indexes
	$('input[name="ix"]').val('');
	
	/* Workflows */
	$('ul.sortElements').sortable({
		placeholder: "ui-state-highlight"
	});
	
	// delete an item from a workflow queue list
	$('a.btnRemoveQueue').click(function(e){
		e.preventDefault();
		$(this).parent('li').remove();
		return false;
	});
	
	// save workflow modifications
	$('button#saveWorkflow').click(function(){
		/* get data object ready */
		var sendData = {};
		sendData.workflows = [];
		var dataString='';
		
		$('ul.sortElements').each(function(){
			var process = $(this).sortable('toArray');

			sendData.workflows.push({
				name: $(this).prev().prev('input.wfname').val()
			   ,process: process
			});
			
		});
		
		// send the object as a JSON string so the server doesn't 
		// turn it into a multidimensional array
		dataString = {"result": JSON.stringify(sendData) };
		
		$.ajax({
			type: 'POST',
			url: 'controllers/workflow/saveWorkflow.asp',
			data: dataString,
			dataType: 'json',
			success: function(data){
				if( data.success=='ok' )
				{
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-retweet'></i>&nbsp;Workflows were saved successfully.")
					);	
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('div#workflowFeedback').empty().html( jqXHR.responseText );
				return false;
			}
		});
		
	});
	
	// add a new workflow
	$('button#btnNewWorkflow').click(function(){
		if( $.trim( $('#newname').val() ).length==0 )
		{
			alert('Workflow name cannot be blank.');
			return false;
		}
		else{
			var newname = encodeURIComponent( $('#newname').val() );
			
			$.ajax({
				type: 'GET',
				url: 'controllers/workflow/newWorkflow.asp?newname='+newname,
				dataType: 'json',
				success: function(data){
					if( data.success=='ok' )
					{
						window.location.replace(
							  window.location.toString().replace(window.location.search,'')
							+ "?notification=" + encodeURIComponent("<i class='icon-retweet'></i>&nbsp;Workflow <strong>"+$('#newname').val()+"</strong> has been created.")
						);	
					}
				},
				error: function(jqXHR, textStatus, errorThrown){
					$('div#workflowFeedback').empty().html( jqXHR.responseText );
					return false;
				}
			});
		}
	});
	
	// add a queue to a workflow
	$('button.btnNewQueue').click(function(){
		addAQueue(
			$(this).parent().find('select.newqueue').find('option:selected').val()
		   ,$(this).parent().parent().find('ul.sortElements').attr('id')
		);
	});
	
	/* Manage queues */
	$('button#saveQueueMods').click(function(e){
		e.preventDefault();
		var qArray = [];
		
		// rebuilding the queues array
		$('table#tblAllQueues tbody tr').each(function(){
			qArray.push({
				email: $(this).find('input.queues-email').val(),
				id: $(this).attr('data-id'),
				notify: $(this).find('select.queues-notify option:selected').val()
			});
		});
		
		var encodedArray = {result: JSON.stringify(qArray) };
		
		$.ajax({
			type: 'POST',
			url: 'controllers/workflow/saveQueues.asp',
			dataType: 'json',
			data: encodedArray,
			success: function(data){
				if( data.success=='ok' )
				{
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-tasks'></i>&nbsp;Queues have been saved successfully.")
					);	
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('div#queueFeedback').empty().html( jqXHR.responseText );
				return false;
			}
		});
	});
	
	// create a new queue
	$('button#btnCreateNewQueue').click(function(e){
		e.preventDefault();
		var newQueue = {
			"id": $('#queueid').val()
		   ,"email": $('#queueemail').val()
		   ,"notify": $('#queuenotify option:selected').val()
		};
		
		$.ajax({
			type: 'GET',
			url: 'controllers/workflow/newQueue.asp',
			dataType: 'json',
			data: newQueue,
			success: function(data){
				if( data.success=='ok' )
				{
					window.location.replace(
						  window.location.toString().replace(window.location.search,'')
						+ "?notification=" + encodeURIComponent("<i class='icon-tasks'></i>&nbsp;New queue was created successfully.")
					);	
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				$('div#queueFeedback').empty().html( jqXHR.responseText );
				return false;
			}
		});
		return false;
	});
	
});