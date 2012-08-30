<!--#include file="../../models/tin.asp"-->
<%
	
	$Q.query = $Q.query.toLowerCase();
	
	// build where statement
	var terms = $Q.query.split(" ")
		// only those that are open, not hidden or deleted
	  , _wtxt = " status='OPN' AND (" 
				// match the whole query
				+ " issue LIKE '\%" + $Q.query + "\%' "
				+ " OR headline LIKE '\%" + $Q.query + "\%' ";
				+ " OR workflow LIKE '\%" + $Q.query + "\%' ";
		
		/* match each query term */
		for(var t=0; t<terms.length; t++)
		{
			_wtxt = _wtxt + " OR issue like '%" + terms[t] + "%' ";
			_wtxt = _wtxt + " OR headline like '%" + terms[t] + "%' ";
			_wtxt = _wtxt + " OR workflow like '%" + terms[t] + "%' ";
			_wtxt = _wtxt + " OR mdata like '%" + terms[t] + "%' ";
		}

	_wtxt = _wtxt + ")  ";
	
	var s = { "where": _wtxt }
	  , rq = tin.get(s);
	  
%>

<table class="table table-condensed datatable">
	<thead>
		<tr>
			<th>Issue</th>
			<th>Workflow</th>
			<th>Actions</th>
			<th>Resolution</th>
			<th>Date</th>
		</tr>
	</thead>
	<tbody>
		<% 	for(var i=0; i<rq.length; i++)
			{
		%>
				<tr>
					<!-- Priority -->
					<td>
						<strong><%=rq[i].headline%></strong>
						<br />
						<%=rq[i].issue%>
					</td>
					<td><%=rq[i].workflow%></td>
					<td>
						<strong>CSR:</strong>
						<%=rq[i].csr_action%>
						<br />
						<strong>Processor:</strong>
						<%=rq[i].pro_action%>
					</td>
					<td><%=rq[i].resolution%></td>
					<td class="tinydate"><%=rq[i].lastmodified%></td>
					
				</tr>
				
		<%	}
		%>
	</tbody>
</table>