<%	/* This file maps the logged-in user's roles onto the global user object */
%>
<!--#include file="../../models/perm.asp"-->
<!--#include file="../../data/roles.asp"-->
<%
	// reset session
	if( $Q.resetSession == "yes" )
	{
		Session("roles") = '';
		// then refresh
		$R.redirect(config.root+"faq.asp?notification=" 
			+ encodeURIComponent("Roles reloaded successfully.") );
	}
	
	// only crawl the database if the roles session var is undefined, empty, etc
	if( !Session("roles") )
	{
		// temporary array with all rules pertaining to this user
		var parr = perm.get({
			"where":"val='" + user.login + "'"
		});
			// Test array 
				/*var parr = [
					{
						"id": "34327x",
						"type": "AD",
						"val": "jeffpa2"
					}
				];*/
			
		Session("roles") = parr;
	}
		// create a roles object on global user object
		user.roles = {};
		
		/* For each of the permission rules, map it to a class based on the 
		*  data in roles object in data/roles.asp.
		*/
		for(var p=0; p<Session("roles").length; p++)
		{
			for(var i=0; i<roles.data.length; i++)
			{
				if( roles.data[i].code == Session("roles")[p].type )
				{
					user.roles[ roles.data[i].classname ] = true;
				}
			}
		}
		
		/* For each of the user's role classes, apply the inheritance rules defined 
		 * in data/roles.asp.
		 */
		var inh_roles = [];
		
		// for all of the user's currently assigned roles
		for(var c in user.roles)
		{
			// go through the global role data and where the user's role matches
			// the global role data class name, grab the inheritance codes.
			for(var r=0; r<roles.data.length; r++)
			{
				if( roles.data[r].classname == c )
				{
					inh_roles = inh_roles.concat(roles.data[r].inherit);
				}
			}
		}
			
		/* Then go back through and apply permissions for all of the inherited 
		 * roles.
		 */
		for( var h=0; h<inh_roles.length; h++ )
		{
			// find this role in roles.data
			for(var i=0; i<roles.data.length; i++)
			{
				if( roles.data[i].code == inh_roles[h] )
				{
					user.roles[ roles.data[i].classname ] = true;
				}
			}
		}
		
		/* write out all roles on the user object */
		
		//for( var w in user.roles )
		//{
		//	echo( w + " : " + user.roles[w] + "<br />");
		//}
	
%>