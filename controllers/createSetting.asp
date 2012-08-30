<!--#include file="../asp/ascend.asp"-->
<%
	var settings = $jsonLoad('../config/settings.json');
	
	// add new setting
	settings[ $Q.s_id ] = {};
	settings[ $Q.s_id ].v = $Q.s_v;
	settings[ $Q.s_id ].ex = $Q.s_ex;
	
	// users can delete this one since it's not built-in
	settings[ $Q.s_id ].del = "1";
	
	$jsonSave(settings, '../config/settings.json');
%>

{"success":"ok"}