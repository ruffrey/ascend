<%
	/* Sets the current environment */
	
	(function(){
		
		var svnm = (Request.ServerVariables("server_name")+"").toLowerCase();
		
		/* find the current environment in $config.env */
		for( var e in $config.env )
		{
			if( svnm == $config.env[e].domain.toLowerCase() )
			{ 
				/* When found, set the environment variables
				 * directly on the $config object.
				 */
				for( var c in $config.env[e] )
				{
					$config[c] = $config.env[e][c];
				}
				break;
			}
		}
		
	})();
%>