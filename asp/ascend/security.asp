<%
	/* Creates a user object and works with session storage, and adds the 
	 * user's roles to it */
	
	// inherit from a local user object
	// and later add more user properties
	var $user = $config.localUserObject;
	
	// reset session if desired
	if( $Q.resetSession == "yes" )
	{
		$S.set("roles",'', function(){
			// then refresh
			$R.redirect($config.root+"faq.asp?notification=" 
				+ encodeURIComponent("Roles reloaded successfully.") );
		});
		
	}
	
	/* Used at the end to determine if a user can view the present page */
	function $isAuthorized(objRoles, arrAllow){
		var rtn=true;
		
		/* only check if there actually allowed groups */
		if( arrAllow.length>0 )
		{
			for( var i in objRoles )
			{
				if( arrAllow.indexOf(i)>-1 )
				{
					rtn=true;
					break;
				}
				else{
					rtn=false;
				}
			}
		}
		
		return rtn;
	}
		
	
	
	/* (local scope) */
	(function(){
		
		/* Only crawl the permissions db if the roles session var 
		 * is undefined, empty, etc.
		 */
		if( !$S.get("roles") )
		{
			/* use the config/permissions.asp settings to connect
			 * to permissions database
			*/
			var perm = $model.create($config.permissions);
			//echo(JSON.stringify(perm));
			perm.connect();
			
			// temporary array with all rules pertaining to this user
			var rules = perm.get({
				"where": $config.permissions.userField + "='" + $user.login + "'"
			});
			//echo(JSON.stringify(rules));
			if( rules.errors )
			{
				echo( rules.errors );
			}
			else{
				/* Put only the user's roles from the permissions rules
				 * in an array (not any other fields)
				 */
				var roles = [];
				for( var i=0; i<rules.length; i++ )
				{
					roles.push( rules[i][ $config.permissions.roleField ] );
				}
				
				$S.set("roles", roles);
			}
			
		}
		
	})();

	/* Create a roles object on a (app) global user object.
	 * The roles array in the session(roles) will be used 
	 * to populate $user.roles.
	 */
	$user.roles = {};
	
	// (local scope)
	(function(){
		/* For each of the permission rules, map it to a class based on the 
		*  data in roles object in config/roles.json.
		*/
		var roledata = $jsonLoad( $config.root+"config/roles.json" );
		var sessroles = $S.get("roles");

		for(var p=0; p < sessroles.length; p++)
		{
			
			for(var i=0; i<roledata.length; i++)
			{
				if( roledata[i].code == sessroles[p] )
				{
					$user.roles[ roledata[i].classname ] = true;
					// when found, end the loop
					break;
				}
			}
		}
		
		/* For each of the user's role classes, add the inherited roles
		 * defined for that role (in config/roles.json)
		 */
		var inh_roles = [];
		
		// for all of the user's currently assigned roles
		for(var c in $user.roles)
		{
			// go through the global role data and where the user's role matches
			// the global role data class name, grab the inheritance codes.
			for(var r=0; r<roledata.length; r++)
			{
				if( roledata[r].classname == c )
				{
					inh_roles = inh_roles.concat(roledata[r].inherit);
				}
			}
		}
			
		/* Then go back through and apply permissions for all of the inherited 
		 * roles.
		 */
		for( var h=0; h<inh_roles.length; h++ )
		{
			// find this role in roles.data
			for(var i=0; i<roledata.length; i++)
			{
				if( roledata[i].code == inh_roles[h] )
				{
					$user.roles[ roledata[i].classname ] = true;
				}
			}
		}
				
		/* done defining user's roles */
		
		/* Check security on this page */
		
		var sn = (Request.ServerVariables("script_name")+'').toLowerCase()
			pagesec = $jsonLoad( $config.root+"config/security.json" );
			
		/* set the current page security permissions object, if there is one */
		var currpagesec=0;
		for( var r=0; r<pagesec.length; r++ )
		{
			if( sn== pagesec[r].page )
			{
				currpagesec = pagesec[r];
				break;
			}
		}
		
		/* if there was a current page security object, do the auth test */
		var pageAuthTest=true;
		if( currpagesec != 0 )
		{
			$w( JSON.stringify( currpagesec ));
			pageAuthTest = $isAuthorized($user.roles, currpagesec.allow);
		}
		
		if( !pageAuthTest ) {
					
			$R.redirect( $config.root + $config.redirectPage );
			
			////////////////////////////
			$w('<br />----<br />-- ending -- ');
			$R.end();
			////////////////////////////
		}
		
	})();
	
	
	
	
%>