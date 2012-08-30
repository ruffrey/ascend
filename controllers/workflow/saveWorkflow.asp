<!--#include file="../../asp/ascend.asp"-->
<%
	var wfobj = $jsonLoad('../../config/workflows.json');
	
	// json object was encoded as text on 'result' form element
	var sentData = JSON.parse($F.result);
	
	// set all the workflow variables
	wfobj.workflows = sentData.workflows;
		
	$jsonSave(wfobj, '../../config/workflows.json');
	//echo(JSON.stringify($F));
%>

{"success":"ok"}
