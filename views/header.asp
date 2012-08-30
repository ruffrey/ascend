<!--#include file="../asp/ascend.asp"-->
<!DOCTYPE HTML>
<html>
<head>
	<title><%=$config.settings.app_title%></title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<META NAME="ROBOTS" 
		CONTENT="<%=$config.settings.meta_robots_index%>, <%=$config.settings.meta_robots_follow%>" />

	<meta name="description" content="<%=$config.settings.meta_description%>" />
	<meta name="keywords" content="<%=$config.settings.meta_keywords%>" />
	
	<link rel="SHORTCUT ICON" href="<%=$config.root%>favicon.ico" />
	<link rel="stylesheet" href="<%=$config.root%>css/styles.css" />
	<script src="<%=$config.root%>js/client-resources.js"></script>
	<script src="<%=$config.root%>js/application.js"></script>
	
</head>
<body>
<!-- Navigation -->
<div class="navbar">
	<div class="navbar-inner">
		<div class="container">
			
			<a class="brand" href="<%=$config.root%>"><%=$config.settings.app_name%></a>
			
			<%	if($config.settings.showHomeIcon){	%>
			<ul class="nav">  
			
				<li>
					<a href="<%=$config.root%>index.asp">
						<i class="icon-home icon-white"></i>
						Home
					</a>
				</li>
			</ul>
			<%	}	%>
			
			<ul class="nav">
				<%
					if($S.get("impersonate"))
					{
				%>	<li title="Click to stop impersonating <%=$S.get("impersonate")%>">
						<a href="?stopImpersonate=true" id="impersonate">
							<i class="icon-eye-open icon-white"></i>
							<%=$S.get("impersonate")%>
						</a>
					</li>
				<%	} %>
			</ul>
			<form id="search" method="GET" 
				action="<%=$config.root%>search.asp" 
				class="navbar-search pull-right">  
				<input name="query" id="query" type="text" class="search-query" placeholder="Search" title="Press enter to search">
					<i id="iq" class="icon-search icon-white"></i>
					
				</input>
			</form>
			
					
			
		<% 	if($user.roles.admin){ %>
				
			<ul class="nav pull-right">			
				<li class="dropdown"> 
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-wrench icon-white"></i><b class="caret"></b>&nbsp;
					</a>
					<ul class="dropdown-menu">

						<li>
							<a href="<%=$config.root%>wtrends.asp">
								<i class="icon-signal"></i>
								Access Trends
							</a>
						</li>
						
						<li>
							<a href="<%=$config.root%>s.asp">
								<i class="icon-cog"></i>
								Settings
							</a>
						</li>
						
						
						<li class="hidden"><a href="<%=$config.root%>reporting.asp"><i class="icon-file"></i>Reporting</a></li>
						
							<%
								if($S.get("impersonate"))
								{
							%>	&nbsp;&nbsp;&nbsp;
								<li><i class="icon-eye-open"></i>Impersonating 
								<%=$S.get("impersonate")%></li>
							<%	}
								else if( $config.settings.impersonateOn ){
							%>	<li><a href="#" id="btnImp">
									<i class="icon-eye-open"></i>
									Impersonate User
								</a></li>
							<%	}
							%>
						
					</ul>
				</li>
			
			</ul>
		<% 	} %>	
		
		<%  if( $config.settings.showUserInfo ) { %>
			
			<!-- roles/user info -->
			<ul class="nav pull-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-user icon-white"></i><b class="caret"></b>&nbsp;
					</a>
					<ul class="dropdown-menu">
						<li>
							&nbsp;&nbsp;&nbsp;
							<%=user.login%>
						</li>
					<%	for(var l in user.roles)
						{
					%>
						<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<%=l.toUpperCase()%>
						</li>
					<%	}
					%>
						<li>
							<a href="?resetSession=yes">
								<i class="icon-repeat"></i>Reload Roles
							</a>
						</li>
					</ul>
				</li>
			</ul>
		<%	} %>
		</div>

	</div>
	<%	// Notifications
		if($Q.notification)
		{
	%>		<div class="alert alert-success">
				<a class="close" data-dismiss="alert" href="#">&times;</a>
				<% echo($Q.notification) %>
			</div>
	<%	}
	%>
</div>

<%	if(user.roles.admin && $config.settings.impersonateOn){ %>
<!-- Impersonate a user -->
	<div id="formImp" class="transparent">
		<form id="addImp" class="no-transparent" method="GET" action="">
			<div class="row-fluid">
				<div class="span12">
					<label for="impersonate">User Login to Impersonate</label>
					<input name="impersonate" id="impersonate" />
				</div>
			</div>
			<div class="row-fluid">
				<div class="span12">
					<input type="submit" class="btn btn-large btn-primary pull-right" 
						value="Submit" />
						
					<button id="btnImpCancel" 
						class="btn btn-large btn-danger pull-left">
						Cancel
					</button>
					
				</div>
			</div>		
		</form>
	</div>
<% } %>

<div class="ajaxscreen transparent"><div>Loading</div></div>

<div id="container">
