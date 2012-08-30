<!--#include file="../../asp/ascend.asp"-->
<%
	var sec = $jsonLoad('../../config/security.json');
	
	// if editing
	if( $Q.ix )
	{
		// set the updated role values
		sec[$Q.ix].page = $Q.page;
		sec[$Q.ix].allow = eval( toarray($Q.allow) );
	}
	// if inserting new
	else{
		sec.push({
			page: $Q.page,
			allow: eval( toarray($Q.allow) )
		});		
	}
	
	$jsonSave(sec, '../../config/security.json');
%>

{"success":"ok"}