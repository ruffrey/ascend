<!--#include file="../asp/ascend.asp"-->
<%
	var settings = $jsonLoad('../config/settings.json');
	
	// set all the settings
	for( var s in $F )
	{
		settings[s].v = $F[s];
	}
	
	$jsonSave(settings, '../config/settings.json');
%>

{"success":"ok"}