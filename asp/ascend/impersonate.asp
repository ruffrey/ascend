<%
	/* This script allows an admin to impersonate any user */
	
	if(	$Q.impersonate 
		&& $config.settings.impersonateOn 
	)
	{
		$S.set("impersonate", $Q.impersonate);
		$S.set("roles",'');
		$R.redirect(Request.ServerVariables("SCRIPT_NAME")+'?resetSession=true');
	}
	
	if($Q.stopImpersonate)
	{
		$S.set("impersonate", '');
		$S.set("roles", '');
		
		$R.redirect(Request.ServerVariables("SCRIPT_NAME"));
	}
	
	if( !$S.get("impersonate") )
	{
		$S.set("impersonate", '');
	}
	
	if( $S.get("impersonate") )
	{
		user.login = $S.get("impersonate");
	}
%>