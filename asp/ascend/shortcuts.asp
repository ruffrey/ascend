<% /* Re-maps the long-named Request.QueryString and Request.Form objects 
	* to JS objects with shorter names. Also remaps the entire Response objects
	* to $R and Response.write() to echo or $w.
	*/

//new Request.queryString() is $Q
	var $Q = {};
	for (x = 1; x <= Request.queryString.count(); x++) 
	{ 
		$Q[Request.queryString.key(x)+""] = Request.queryString.item(x)+"";
	}

//new Request.form() is $F
	var $F = {};
	for (x = 1; x <= Request.Form.count(); x++) 
    { 
       $F[Request.form.key(x)+""] = Request.form.item(x)+"";
    }

//new Response object is $R
	var $R = Response;

//new Response.Write() is echo or $w
	var echo = $w = function(t){
		// automagically stringify JSON objects
		if( typeof(t)=='object'
			&& !( t instanceof Function ) 
		)
		{
			$R.write( JSON.stringify(t) );
		}
		else{
			$R.write(t);
		}
	};

//returns number of immediate child objects for an object
	var countObjects = function(o){
		var c = 0;
		for(var co in o){
			c++
		}
		return c;
	};
%>