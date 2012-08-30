<!--#include file="../../asp/ascend.asp"-->
<%
	var rls = $jsonLoad('../../config/roles.json');
	
	// if editing
	if( $Q.ix )
	{
		// set the updated role values
		rls[$Q.ix].code = $Q.code;
		rls[$Q.ix].desc = $Q.desc;
		rls[$Q.ix].classname = $Q.classname;
		
	}
	// if inserting new
	else{
		rls.push({
			code: $Q.code.toUpperCase()
		  , desc: $Q.desc
		  , classname: $Q.classname
		  , del: true
		});		
	}
	
	$jsonSave(rls, '../../config/roles.json');
%>

{"success":"ok"}