<!--#include file="../../asp/ascend.asp"-->
<%
	var rls = $jsonLoad('../../config/security.json'),
		rObj = rls[$Q.ix];
	
	rObj.ix = $Q.ix;
	
	echo(JSON.stringify(rObj));
%>
