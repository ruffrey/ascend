<%
	/* Gets and sets session storage for this application.
	*  Session storage has a prefix ( $config.spre )
	*  so as not to conflict with other apps in the same pool.
	*/
	
	/* The session object */
	var $S = {};
	
	/* Returns the session data at the specified index/key */
	$S.get = function( _svar ){
		return Session( $config.spre + "_" + _svar );
	};
	
	/* Sets the session data at the specified index/key */
	$S.set = function( _svar, _newval){
		
		Session( $config.spre + "_" + _svar ) = _newval;
		
		// if there's a callback argument
		if( typeof(arguments[2]) != 'undefined' )
		{
			arguments[2];
		}
	};
	
%>