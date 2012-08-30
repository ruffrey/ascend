<%
	/* This file contains utility functions for transforming data
	 */
	
	/* Turn comma-separated form checkbox data into array text */
	function toarray(clist){
		var _return;
		
		// Trimming
		clist = clist.replace(', ',',');
		clist = clist.replace(' ,',',');
		
		_return = clist.split(',');
		_return = JSON.stringify(_return);
		return _return;
	}
	
	/* slightly different format for SQL */
	function toSQLarray(cslist){
		var _return;
		
		// Trimming
		cslist = cslist.replace(', ',',');
		cslist = cslist.replace(' ,',',');
		
		_return =  cslist.split(',');
		_return = JSON.stringify(_return);
		
		_return = _return.replace('[','(');
		_return = _return.replace(']',')');
		_return = _return.replace(/\"/g,"'");
		
		return _return;
	}
	
	/* Turn array text into comma-separated checkbox data */
	function tocomma(artxt){
		var _return = toarray(artxt);
		
		// removing & transforming to just comma separated
		_return =   artxt.replace( /\[\]\(\)\"\'/g ,'');
		
		return _return;
	}
	
	
	/* indexOf method for arrays  */
	if (!Array.prototype.indexOf) {   
		Array.prototype.indexOf = function (searchElement /*, fromIndex */ ) {   
			"use strict";   
			if (this == null) {   
				throw new TypeError();   
			}   
			var t = Object(this);   
			var len = t.length >>> 0;   
			if (len === 0) {   
				return -1;   
			}   
			var n = 0;   
			if (arguments.length > 0) {   
				n = Number(arguments[1]);   
				if (n != n) { // shortcut for verifying if it's NaN   
					n = 0;   
				} else if (n != 0 && n != Infinity && n != -Infinity) {   
					n = (n > 0 || -1) * Math.floor(Math.abs(n));   
				}   
			}   
			if (n >= len) {   
				return -1;   
			}   
			var k = n >= 0 ? n : Math.max(len - Math.abs(n), 0);   
			for (; k < len; k++) {   
				if (k in t && t[k] === searchElement) {   
					return k;   
				}   
			}   
			return -1;   
		}   
	}  

%>