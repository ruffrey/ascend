<%
 /*
 * This file is used for generating pseudo UUIDs - Universally Unique IDentifiers	
 */
var $uuid = {};
	//default function; used by functions below.
	$uuid.fn_default = function(m){
		var s = '',
			r = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		for (var i=0; i < m; i++) {
			s += r.charAt(Math.floor(Math.random()*r.length));
		}
		return s;
	};
	
	//primary method of uuid
	$uuid.get = function(){
		//default with no params is length 9
		if(arguments.length==0)
		{
			return $uuid.fn_default(9);
		}
		//if there's only 1 param, return 1 uuid of specified length
		else if(arguments.length==1)
		{
			var a = parseFloat(arguments[0]);
			return $uuid.fn_default(a);
		}
		//if there are multiple params, return a magical array of UUIDs
		else{
			var y = [];
			for(var a=0; a<arguments.length; a++){
				y.push( $uuid.fn_default( parseFloat(arguments[a]) ) );
			}
			return y;
		}
	};
%>