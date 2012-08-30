<!--#include file="views/header.asp"-->
<!--#include file="data/status.asp"-->
<script src="js/reporting.js"></script>
<link rel="stylesheet" type="text/css" href="css/datepicker.css">
<script src="js/datepicker.js"></script>
<%
	
%>
<h1>Reporting</h1>
<p>&nbsp;</p>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span10">
			<div class="row-fluid">
				<div class="span12">
					<form id="rpt">
						<div class="row-fluid">
							<!-- dates -->
							<div class="span4 well">
								<h3>Submit Date</h3>
								<label for="submittime_start">From</label>
								<input class="datepicker" id="submittime_start" 
									name="submittime_start" />
								
								<label for="submittime_end">To</label>
								<input class="datepicker" id="submittime_end" 
									name="submittime_end" />
								
							</div>
							<!-- status -->
							<div class="span6 well">
								<label for="status"><h3>Status</h3></label>
								<select name="status" id="status" multiple="multiple">
									<option value="" selected="selected">
										-- ALL --
									</option>
									<%	
										for(var s=0; s<(status.data.length-1); s++){ 
									%>		<option value="<%=status.data[s].code%>">
												<%=status.data[s].desc%>
											</option>	
									<% 	} %>
								</select>
							</div>
							
						</div>
						<div class="row-fluid">
							<!-- user -->
							<div class="span4 well">
								<label for="submitlogin"><h3>Submitted By</h3></label>
								<input name="submitlogin" id="submitlogin" />
								<span class="help-block">Separate multiple users with a comma</span>
							</div>
							<div class="span4 well">
								<button type="submit" class="btn btn-primary btn-large">
									Generate Report
									<i class="icon-chevron-right icon-white"></i>
								</button>
							</div>
							<div id="ajaxmsg" class="span4">
								
							</div>
						</div>
					</form>
				</div>
			</div>
						
		</div>
		<!-- side bar -->
		<div class="span2">
			<table class="table-condensed table">
				<tr><th colspan="2"><h4>Status Codes</h4></th></tr>
			<%	
				for(var s=0; s<(status.data.length-1); s++){ 
			%>		<tr>
						<td>
							<h6><strong><%=status.data[s].code%></strong></h6>
						</td> 
						<td>
							<h6><%=status.data[s].desc%></h6>
						</td>
					</li>
			<% 	} %>
			</table>
		</div>
	</div>
	<!-- report is inserted here -->
	<div class="row-fluid report">
		<h2>Report</h2>
		<div id="rptOutput" class="well span11"></div>	
	</div>
</div>
<br />
<br />
<br />
<br />
<!--#include file="views/footer.asp"-->