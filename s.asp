<!--#include file="views/header.asp"-->

<%
	var rls = $jsonLoad("config/roles.json")
	  , pgs = $jsonLoad("config/security.json")
	  , sts = $jsonLoad("config/settings.json")
	  , wfl = $jsonLoad("config/workflows.json");
%>

<!--#include file="views/s-forms.asp"-->
<script src="js/s.js"></script>

<h1>Settings</h1>
<p>&nbsp;</p>


<div class="row-fluid">
<div class="span12">
<div class="tabbable tabs-left">
    <ul class="nav nav-tabs" id="mainTabLinks">
		<li class="active"><a href="#tab1" data-toggle="tab">
			<i class="icon-user"></i> Users
		</a></li>
		<li><a href="#tab3" data-toggle="tab">
			<i class="icon-ban-circle"></i> Pages
		</a></li>
		<li><a href="#tab2" data-toggle="tab">
			<i class="icon-ok-circle"></i> Roles
		</a></li>
		
		<%	if($config.settings.enableWorkflow) {		%>
		
			<li><a href="#tab4" data-toggle="tab">
				<i class="icon-retweet"></i> Workflows
			</a></li>
			<li><a href="#tab5" data-toggle="tab">
				<i class="icon-tasks"></i> Queues
			</a></li>
		
		<%	}											%>
		
		
		<li><a href="#tab6" data-toggle="tab">
			<i class="icon-cog"></i> App Settings
		</a></li>
		
    </ul>
    <div class="tab-content">
		
		<!-- users -->
		<div class="tab-pane active well" id="tab1">
			<a href="#" class="btn btn-primary pull-right" id="btnaddrule">Add a user</a>
			<table class="datatable table-condensed">
				<thead>
					<tr>
						<th>User</th>
						<th>Role</th>
						<th class="nosort">Delete</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
		
			</table>
		</div>
		
		<!-- roles -->
		<div class="tab-pane well" id="tab2">
			<a href="#" class="btn btn-primary pull-right" id="btnaddrole">Add a role</a>
			<table class="datatable table-condensed">
				<thead>
					<tr>
						<th>Role Code</th>
						<th>Class Name</th>
						<th>Description</th>
						<th class="nosort">Edit</th>
						<th class="nosort">Delete</th>
					</tr>
				</thead>
				<tbody>
					<% 	for( r=0; r<rls.length; r++ )
						{
					%>
							<tr>
								<td><%=rls[r].code%></td>
								<td><%=rls[r].classname%></td>
								<td><%=rls[r].desc%></td>
								<td>
									<%
										if( rls[r].del==true )
										{
									%>									
											<a class="btn btn-info roleedit" data-index="<%=r%>">
												<i class="icon-pencil icon-white"></i>
											</a>
									<%
										} else {
									%>		<span class="help-block"><em>Cannot edit</em></span>
									<%	}
									%>
								</td>
								<td>
									<%
										if( rls[r].del==true )
										{
									%>									
											<a class="btn btn-danger roledelete" data-index="<%=r%>">
												<i class="icon-remove icon-white"></i>
											</a>
									<%
										} else {
									%>		<span class="help-block"><em>Cannot remove</em></span>
									<%	}
									%>
								</td>
							</tr>
					<%
						}
					%>
				
				
				</tbody>
		
			</table>
			
		</div>
		
		<!-- pages -->
		<div class="tab-pane well" id="tab3">
			<a href="#" class="btn btn-primary pull-right" id="btnaddpage">Add page restriction</a>
			
			<p><em>All pages not listed or empty will be allowed by default.</em></p>
			
			<table class="datatable table-condensed">
				<thead>
					<tr>
						<th>Page</th>
						<th>Allowed Groups</th>
						<th class="nosort">Edit</th>
						<th class="nosort">Delete</th>
					</tr>
				</thead>
				<tbody>
					<% 	for( var p=0; p<pgs.length; p++ )
						{
					%>
							<tr>
								<td><%=pgs[p].page%></td>
								<td><%=pgs[p].allow%></td>
								<td>
									<a class="btn btn-info pageedit" 
										data-index="<%=p%>">
										<i class="icon-pencil icon-white"></i>
									</a>
								</td>
								<td>
									<a class="btn btn-danger pagedelete" data-index="<%=p%>">
										<i class="icon-remove icon-white"></i>
									</a>
								</td>
							</tr>
					<%
						}
					%>
				
				
				</tbody>
		
			</table>
			
		</div>
		
	<%	/* Only show if enabled in settings */
		if($config.settings.enableWorkflow)
		{
	%>
		<!-- begin workflows - main tab -->
		<div class="tab-pane well" id="tab4">
			
			<div class="tabbable">
				
				<!-- begin tab links for each workflow -->
				<ul class="nav nav-tabs">
					
			<%	// Make a link for each workflow
				var n=0;
				for( n=0;n< wfl.workflows.length; n++ )
				{
			%>
					<li><a href="#wf<%=n%>" data-toggle="tab">
						<i class="icon-arrow-right"></i> <%=wfl.workflows[n].name%>
					</a></li>
			<%
				}
			%>
				
					<!-- new workflow tab link -->
					<li>
						<a href="#wf-new" data-toggle="tab">
							<i class="icon-plus"></i> New
						</a>
					</li>
				</ul>
				<div class="tab-content">
					<!-- default visible tab -->
					<div class="tab-pane active">Select a workflow</div>
					
			<!-- begin tabs for each workflow -->
			<%	// Make a tab pane for each workflow
				var q,process;
				for( n=0;n< wfl.workflows.length; n++ )
				{
					process = wfl.workflows[n].process;
			%>
					<div class="tab-pane" id="wf<%=n%>">

						<!-- title of the workflow -->
						<input class="wfname" title="Edit workflow name" 
							value="<%=wfl.workflows[n].name%>" />
						
						<!-- the workflow order -->
						<div class="alert alert-success bold">
							Beginning
						</div>
						<ul class="sortElements well" id="ulSortWF-<%=n%>" data-ix="<%=n%>">
					<%
						for( q=0; q<process.length; q++ )
						{
					%>
							<li id="<%=process[q]%>" class="ui-state-default sortable">
								<i class="icon-arrow-down"></i>
								<strong>
									<%=process[q]%>
								</strong>
								<a class="btn btnRemoveQueue"><i class="icon-remove"></i></a>
							</li>
					<%	
						}
					%>
						</ul>
						<div class="alert alert-danger bold">
							End
						</div>
						
						<!-- add a queue to the workflow -->
						<div class="alert alert-info">
							<h3>Add a queue</h3>
							<br />
							<select class="newqueue">
							<%	for( var qu=0; qu<wfl.queues.length; qu++ ) {	%>
									<option value="<%=wfl.queues[qu].id%>"><%=wfl.queues[qu].id%></option>
							<%	}	%>
							</select>
							<br />
							<br />
							<button class="btnNewQueue btn btn-info">
								Add this queue
								<i class="icon-arrow-right icon-white"></i>
							</button>
						</div>
						
					</div>
			<%
				}
			%>	
					<div class="tab-pane" id="wf-new">
						
						<div class="alert alert-info">
							<h3>Create a new workflow</h3>
							<br />
							<label for="newname">Workflow Name</label>
							<input name="newname" id="newname" />
							<br />
							<br />
							<button class="btn btn-info" id="btnNewWorkflow">
								Create this workflow
								<i class="icon-arrow-right icon-white"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
			<br />
			<br />
			<br />
			<button class="btn btn-primary" id="saveWorkflow">
				Save All Workflow Modifications <i class="icon-hdd icon-white"></i>
			</button>
			<div id="workflowFeedback"></div>
		</div>
		<!-- end workflows tab -->
			
		<!-- begin Queues tab -->
		<div class="tab-pane well" id="tab5">
			<div class="tabbable">
				<!-- queues links -->
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#queuetab" data-toggle="tab">
							<i class="icon-tasks"></i> 
							Queue List
						</a>
					</li>
					<li>
						<a href="#createQueueTab" data-toggle="tab">
							<i class="icon-plus"></i> New Queue
						</a>
					</li>
				</ul>
				
				<div class="tab-content">
					<!-- queues tab -->
					<div class="tab-pane active" id="queuetab">
						<table id="tblAllQueues" class="table table-condensed datatable">
							<thead>
								<tr>
									<th>Queue ID</th>
									<th class="nosort">Email</th>
									<th class="nosort">Email Notify</th>
								</tr>
							</thead>
							<tbody>
								<%	var queues = wfl.queues;
									for( var s=0; s< queues.length; s++ )
									{
								%>		
										<tr data-ix="<%=s%>" data-id="<%=queues[s].id%>">
											<td title="Cannot modify queue id">
												<%=queues[s].id%>
											</td>
											<td>
												<input class="queues-email"
													value="<%=queues[s].email%>" />
											</td>
											<td>
												<select class="queues-notify">
													<option 
														<% if( queues[s].notify=="0" ) {  %>
															selected="selected" 
														<%	}	%>
														value="0">
														No
													</option>
													<option 
														<% if( queues[s].notify=="1" ) {  %>
															selected="selected" 
														<%	}	%>
														value="1">
														Yes
													</option>
												</select>
											</td>
										</tr>
										
								<%	}	%>
							</tbody>
						</table>
						
						
						
						<button class="btn btn-primary" id="saveQueueMods">
							Save All Queue Modifications <i class="icon-hdd icon-white"></i>
						</button>
					</div>
					<!-- create a new queue tab -->
					<div class="tab-pane" id="createQueueTab">
						<div class="alert alert-info">
							
							<form id="createNewQueue">
								<h3>Create a new queue</h3>
								<br />
								<label>Queue ID</label>
								<input name="queueid" id="queueid" />
								<span class="help-block">No spaces or special characters.</span>
								
								<label>Email</label>
								<input name="queueemail" id="queueemail" />
								<br />
								<br />
								<label>Notify via email when a request is placed in queue?</label>
								<select name="queuenotify" id="queuenotify">
									<option value="0">
										No
									</option>
									<option value="1">
										Yes
									</option>
								</select>
								
								<br />
								<br />
								<button class="btn btn-primary" id="btnCreateNewQueue">
									Create Queue
									<i class="icon-plus icon-white"></i>
								</button>
							</form>
							
						</div>
					</div>
				</div>
			</div>
			<br />
			<br />
			<div id="queueFeedback"></div>
		</div>
		
	<%	}
	%>
		<div class="tab-pane well" id="tab6">
			<div class="row-fluid">
				<div class="span4">
					<h5>Careful!</h5>
					<h5>Settings may be case sensitive.</h5>
					
				</div>
				<div class="span2">
					<h6>0 = false</h6>
					<h6>1 = true</h6>
				</div>
				<div class="span6">
					<a href="#" class="btn btn-primary pull-right" id="createSetting">Add new setting <i class="icon-plus icon-white"></i></a>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<hr />
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<form id="settings" name="settings" method="POST">
						<table id="settingsTable" class="datatable table-condensed">
							<thead>
								<tr>
									<th width="20%">Setting</th>
									<th width="30%" class="nosort">Value</th>
									<th width="40%" class="nosort">Description</th>
									<th width="10%">Delete</th>
								</tr>
							</thead>
							<tbody>
									
								<% 	for( var s in sts )
									{
								%>		<tr>
											<td><%=s%></td>
											<td>
												<input name="<%=s%>" value="<%=sts[s].v%>" />
											</td>
											<td width="40%"><em><%=sts[s].ex%></em></td>
											<td>
												<% if( sts[s].del=="1" ) {	%>
													<a href="#" 
													class="btn btn-danger btn-mini bDelSetting" 
													data-sid="<%=s%>">
													<i class="icon-remove icon-white"></i>
													</a>
												<% }	%>
											</td>
										</tr>
								<%
									}
								%>
							
							</tbody>
					
						</table>
						
						<br />
						<br />
						
						<button type="submit" class="btn btn-primary" id="submitSettings">
							Save Settings <i class="icon-hdd icon-white"></i>
						</button>
					</form>
					
				</div>
			</div>
			<h5 class="pull-right">Settings can be manually edited at /config/settings.json</h5>
			<div id="settingsError" class="error"></div>
			
		</div>
    </div>
</div>

</div>
</div>
<!--#include file="views/footer.asp"-->