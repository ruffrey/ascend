<%

	function pad(number, length) {
   
		var str = '' + number;
		while (str.length < length) {
			str = '0' + str;
		}
	   
		return str;

	}
	
	function sqldate(){
		var dt;
		if(arguments.length>0)
		{
			dt = arguments[0];
		}
		else{
			dt = new Date();
		}
		
		var dtstring = dt.getFullYear()
			+ '-' + pad(dt.getMonth()+1,2)
			+ '-' + pad(dt.getDate(),2)
			+ ' ' + pad(dt.getHours(),2)
			+ ':' + pad(dt.getMinutes(),2)
			+ ':' + pad(dt.getSeconds(),2);
			
		return dtstring;
	}
%>