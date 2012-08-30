<!--#include file="../asp/ascend.asp"-->
<%
	var settings = $jsonLoad('../config/settings.json');
	
	// delete this setting
	if( settings[$Q.id].del == "1" )
	{	
		delete settings[$Q.id];
		$jsonSave(settings, '../config/settings.json');
		echo( '{"success":"ok"}' );
	}
	else{
		echo('{"success":"no","error":"This setting is part of the application cannot be deleted."}');
	}
		
%>