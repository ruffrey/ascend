<!--#include file="../../asp/ascend.asp"-->
<%
	var rls = $jsonLoad('../../config/roles.json');
	
	rls.splice($Q.ix, 1);
	
	$jsonSave(rls, '../../config/roles.json');
%>

{"success":"ok"}