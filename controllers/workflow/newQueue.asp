<!--#include file="../../asp/ascend.asp"-->
<%
	var wfobj = $jsonLoad('../../config/workflows.json');
	
	// json object was encoded as text on 'result' form element
	var newQobj = {
		"id": $Q.id
	   ,"email": $Q.email
	   ,"notify": $Q.notify
	};
	
	// set all the workflow variables
	wfobj.queues.push(newQobj);
		
	$jsonSave(wfobj, '../../config/workflows.json');
	//echo(JSON.stringify(newQobj));
%>

{"success":"ok"}
