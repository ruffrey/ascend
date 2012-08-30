<%
	/* Used for prototyping new objects */
	if (typeof Object.create !== 'function') 
	{
		Object.create = function (o) {
			function F() {}
			F.prototype = o;
			return new F();
		};
	}

	
%>