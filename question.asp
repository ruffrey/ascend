<!--#include file="views/header.asp"-->
<!--#include file="data/portal.asp"-->
<link rel="stylesheet" type="text/css" href="css/datepicker.css">
<script src="js/q.js"></script>
<script src="js/datepicker.js"></script>
<input type="hidden" id="hid_dcnp" value="<%=user.login%>" />
<input type="hidden" id="hid_roles" value="<%=countObjects(user.roles)%>" />

<div class="row-fluid">
	<div class="span12">
		<h1>Ask a question</h1>
		<p>&nbsp;</p>
	</div>
</div>

<div class="row-fluid">
	<div class="span12">
		<form id="tinreq" method="POST" action="" class="well">
			
			<p>Please include as much information as possible.</p>
			
			<label>Task Type(s) *</label>
			
			<div class="subset">
				
			<%
				var ttc = 0;
			%> <div class="row-fluid">
			<%	
				for( var tt in portal.tasks )
				{
			%>		<div class="span4" title="<%=portal.tasks[tt].desc%>"
						style="cursor:help;">
					<label>
						<input type="checkbox" class="tasktypes" name="tasktypes" 
						value="<%=portal.tasks[tt].name%>" />
						<%=portal.tasks[tt].name%>
					</label>
					</div>
			<%		
					ttc++;
					if(ttc==3)
					{
			%>		</div>
					<div class="row-fluid">
			<%		}
					ttc = ttc==3?0:ttc;
				}
			%>
					</div>
			</div>
			
			<div class="subset">
				<div class="row-fluid">
					<div class="span4">
						<label>
							<input type="checkbox" class="tasktypes" name="tasktypes"
							value="Unsure" />
							<strong>I don't know which task type</strong>
						</label>
					</div>
				</div>
			</div>
			
			<br />
			
			<label>Case #</label>
			<input id="casenum" name="casenum" />
			
			<label>Claim #</label>
			<input id="claim" name="claim" />
			
			<label>Member ID</label>
			<input id="member" name="member" />
		
			<label>DOS</label>
			<input id="dos" name="dos" />
			
			<label>Question / Issue *</label>
			<textarea id="question" name="question"></textarea>
			
			<!-- feedback -->
			<div class="pull-right">
				<div id="feedback"></div>
				<div id="output"></div>
			</div>
			<br />
			<button type="submit" class="btn btn-large btn-primary">
				Submit
				<i class="icon-chevron-right icon-white"></i>
			</button>
			
			<input type="reset" id="reset" class="hidden" />
			
		</form>
	</div>
</div>

<!--#include file="views/footer.asp"-->