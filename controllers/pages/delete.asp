<!--#include file="../../asp/ascend.asp"-->
<%
	var rls = $jsonLoad('../../config/security.json');
	
	rls.splice($Q.ix, 1);
	
	$jsonSave(rls, '../../config/security.json');
%>

{"success":"ok"}