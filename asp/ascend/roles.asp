<%

var $roles = {};
	
	/* The different user roles.
	 * Roles are stored in config/roles.json and can be managed in application
	 * 
	 * code = two digit role code, stored in tblCasePer
	 * classname = when this gets mapped to the global user object, 
	 * 			   this name is used
	 * desc = a simple description of the role group for UI purposes
	 * inherit = array of roles which this role inherits.
	 * 
	 */
	
	$roles.data = $jsonLoad( "../../config/roles.json" );
	
	/* Methods */
	
	// Returns the roles.data object. 
	// If args are specified, it returns only the listed indexes
	$roles.get = function(){
		if(arguments.length>0)
		{
			var ar = [];
			for(var x = 0; x < arguments.length; x++){
				ar.push( status.data[arguments[x]] );
			}
			return JSON.stringify(ar);
		}
		else{
			for(var x = 0; x < status.data.length; x++){
				return JSON.stringify(status.data);
			}
		}
	};
	
	$roles.getCodeByClassname = function(cn){
		var code;
		cn = cn.toLowerCase();
		for(var x=0; x<$roles.data.length; x++){
			if( $roles.data[x].classname == cn )
			{
				code = $roles.data[x].code;
				break;
			}
		}
		return code;
	};
	
	$roles.getDescriptionByClassname = function(cn){
		var description;
		cn = cn.toLowerCase();
		for(var x=0; x<$roles.data.length; x++){
			if( $roles.data[x].classname == cn )
			{
				description = $roles.data[x].desc;
				break;
			}
		}
		return description;
	};
	
	$roles.getDescriptionByCode = function(cd){
		var description;
		cd = cd.toUpperCase();
		for(var x=0; x<$roles.data.length; x++){
			if( $roles.data[x].code == cd )
			{
				description = $roles.data[x].desc;
				break;
			}
		}
		return description;
	};
	
	$roles.getClassnameByCode = function(cd){
		var classname;
		cd = cd.toUpperCase();
		for(var x=0; x<$roles.data.length; x++){
			if( $roles.data[x].code == cd )
			{
				classname = $roles.data[x].classname;
				break;
			}
		}
		return classname;
	};
	
	
%>