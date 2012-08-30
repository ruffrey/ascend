<%	/*	Recompiles the settings object into an easier format for 
	 *	use in the application.
	 */
	
	(function(){
		var tmp;
		for( var ___s in $config.settings )
		{
			tmp = $config.settings[___s].v;
			
			// test to convert number to boolean
			if( isNumber(tmp) )
			{  
				// parse string to boolean
				tmp = Boolean( parseFloat(tmp) );
			}
			
			// remove the object
			delete $config.settings[___s];
			
			// recompile settings objects to allow direct access to 'v' property
			$config.settings[___s] = tmp;
		}
		
	})();

%>