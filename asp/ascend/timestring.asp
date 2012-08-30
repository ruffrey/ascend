<%	
	/* Platform: Classic ASP
	 * Language: JavaScript
	 * Dependencies: none
	 * Author: jeffpa2
	 *
	 * The get method returns a time stamp in the form of a string:
	 *		YYYY-MM-DD[hh:mm:ss]
	 *
	 *		May 5th, 2012 at 2:17 PM (and 1 second) becomes:
	 *		2012-05-10[14:17:01]
	 * 
	 * The getstrict method returns it in this format:
	 * 		20120510141701
	 */

	var $timestring = {};

	$timestring.get = function(){
		var tm = new Date(), 
			h = tm.getHours(),
			n = tm.getMinutes(),
			s = tm.getSeconds(),
			y = tm.getFullYear(),
			d = tm.getDate(),
			m = tm.getMonth()+1,
			tmstr;

		//if it's a single digit, prepend with a zero
		if(h<10){h = "0" + h.toString();}
		if(n<10){n = "0" + n.toString();}
		if(s<10){s = "0" + s.toString();}
		if(d<10){d = "0" + d.toString();}
		if(m<10){m = "0" + m.toString();}

		//create time
		t = h + ":" + n + ":" + s;
		
		//create full date time string
		tmstr = y.toString() +'-'+ m.toString() +'-'+ d.toString() + '['+t+']';
		
		return tmstr;
	};
	
	$timestring.getstrict = function(){
		var tm = new Date(), 
			h = tm.getHours(),
			n = tm.getMinutes(),
			s = tm.getSeconds(),
			y = tm.getFullYear(),
			d = tm.getDate(),
			m = tm.getMonth()+1,
			tmstr;

		//if it's a single digit, prepend with a zero
		if(h<10){h = "0" + h.toString();}
		if(n<10){n = "0" + n.toString();}
		if(s<10){s = "0" + s.toString();}
		if(d<10){d = "0" + d.toString();}
		if(m<10){m = "0" + m.toString();}

		//create time
		t = h.toString() + n.toString() + s.toString();
		
		//create full date time string
		tmstr = y.toString() + m.toString() + d.toString() + t;
		
		return tmstr;
	};

%>