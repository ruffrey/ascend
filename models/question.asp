<%	/* This model logs questions to tblCaseFaqQ */
	
var question = {};
	
question.add = function(newob){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			//sql will return no records
			obsql = "SELECT * FROM tblCaseFaqQ WHERE login=''";
		ob.cursorType = 2;
		ob.lockType = 3;
		
		ob.open(obsql, ObjConn);
		ob.addNew();
		
			//set all the fields to the new values
			for(var k in newob)
			{
				ob(k) = newob[k];
			}
			
		ob.update();
		returnOb.success = "ok";
		
		ob.close();
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};

question.get = function(id){
	try{
		//create these objects no matter what
		var ob = Server.createObject("ADODB.Recordset"),
			obsql = "";
		
		/* Begin options, to handle various use-cases for this method */
		
		//if just one id is passed as a string, return that record
		if(typeof(id)=="string")
		{
			//returnOb is an object
			var returnOb = {};
			
			obsql = "SELECT * FROM tblCaseFaqQ WHERE login='" + id + "'";
				
			ob.open(obsql, ObjConn);
			if(ob.eof!=true){
				ob.moveFirst();
				//build a simpler JS object to return
				for(var i=0; i< (ob.Fields.Count - 1); i++)
				{
					//Create key/value variables to hack them into a lowercase string
					//that will persist after the object is closed.
					var key = (ob.Fields(i).name+"").toLowerCase(),
						val = ob.Fields(i)+"";
					returnOb[ key ] = val;
				}			
			}
			//else leave returnOb empty
			returnOb.success = "ok";
			ob.close();
		}
		
		//or if an object is passed, execute with embedded WHERE clause
		else if( typeof(id)=="object" )
		{
			obsql= 		  "SELECT * FROM tblCaseFaqQ "
			obsql=obsql + "WHERE " + id.where;
			
			ob.open(obsql, ObjConn);
			
			//returnOb is an array
			var returnOb = [];
			if(ob.eof!=true){
				ob.moveFirst();
				
				// build an object for each record in the recordset, and 
				// put it into a return array
				
				while(ob.eof!=true){
						// Create a temporary object.
						var tempobj = {};
						for(var i=0; i< (ob.Fields.Count - 1); i++)
						{
							// Create key/value variables, hack them into 
							// a string that will persist after the recordset
							// is closed. Make key lowercase.
							var key = (ob.Fields(i).name+"").toLowerCase(),
								val = ob.Fields(i)+"";
							
							tempobj[ key ] = val;
						}
						
						//append this temporary object to the return array.
						returnOb.push(tempobj);
						//delete the temp object
						delete tempobj;
					ob.moveNext();
				}
				
			}
			
			//else leave returnOb empty
			returnOb.success = "ok";
			ob.close();
		}
	}
	catch(er){
		if(typeof(returnOb=="object"))
		{
			returnOb.errors = er.message
			returnOb.success = "no";
		}
		else if(typeof(returnOb=="array"))
		{
			returnOb.push("errors: " + er.message);
			returnOb.push("success: " + "no");
		}
	}
	return returnOb;
};

question.getAll = function(){
	try{
		//create these objects no matter what
		var ob = Server.createObject("ADODB.Recordset"),
			obsql = "";
		
		obsql= "SELECT * FROM tblCaseFaqQ";
		
		ob.open(obsql, ObjConn);
		
		//returnOb is an array
		var returnOb = [];
		if(ob.eof!=true){
			ob.moveFirst();
			
			// build an object for each record in the recordset, and 
			// put it into a return array
			
			while(ob.eof!=true){
					// Create a temporary object.
					var tempobj = {};
					for(var i=0; i<ob.Fields.Count; i++)
					{
						// Create key/value variables, hack them into 
						// a string that will persist after the recordset
						// is closed. Make key lowercase.
						var key = (ob.Fields(i).name+"").toLowerCase(),
							val = ob.Fields(i)+"";
						
						tempobj[ key ] = val;
					}
					
					//append this temporary object to the return array.
					returnOb.push(tempobj);
					//delete the temp object
					delete tempobj;
				ob.moveNext();
			}
			
		}
		
		//else leave returnOb empty
		returnOb.success = "ok";
		ob.close();
	
	}
	catch(er){
		if(typeof(returnOb=="object"))
		{
			returnOb.errors = er.message
			returnOb.success = "no";
		}
		else if(typeof(returnOb=="array"))
		{
			returnOb.push("errors: " + er.message);
			returnOb.push("success: " + "no");
		}
	}
	return returnOb;
};


question.getSql = function(sqlstring){
	var ob = Server.createObject("ADODB.Recordset");
	var returnOb = [];
	try{
		ob.open(sqlstring, ObjConn);
		
		//returnOb is an array
		if(ob.eof!=true){
			ob.moveFirst();
			
			// build an object for each record in the recordset, and 
			// put it into a return array
			
			while(ob.eof!=true){
					// Create a temporary object.
					var tempobj = {};
					for(var i=0; i< ob.Fields.Count; i++)
					{
						// Create key/value variables, hack them into 
						// a string that will persist after the recordset
						// is closed. Make key lowercase.
						var key = (ob.Fields(i).name+"").toLowerCase(),
							val = ob.Fields(i)+"";
						
						tempobj[ key ] = val;
					}
					
					//append this temporary object to the return array.
					returnOb.push(tempobj);
					//delete the temp object
					delete tempobj;
				ob.moveNext();
			}
			
		}
			
		ob.close();
	}
	catch(er){
		returnOb.push({"errors": + er.message,"success":"no"});
	}
	
	return returnOb;
};

%>