<!--#include file="../../asp/ascend.asp"-->
<%
	var wfobj = $jsonLoad('../../config/workflows.json');
	
	// json object was encoded as text on 'result' form element
	var newWFobj = {
		"name": $Q.newname
	   ,"process":[]
	};
	
	// set all the workflow variables
	wfobj.workflows.push(newWFobj);
		
	$jsonSave(wfobj, '../../config/workflows.json');
	//echo(JSON.stringify($F));
%>

{"success":"ok"}
