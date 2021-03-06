﻿<%	/* This file contains defines variables and model methods for 
	 * a Case FAQ record
	 */
		
var tin = {};

tin.add = function(newob){

	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			//sql will return no records
			obsql = "SELECT * FROM tblCaseFaq WHERE recid=''";
		ob.cursorType = 2;
		ob.lockType = 3;
		
		ob.open(obsql, ObjConn);
		
		ob.addNew();
			//set all the fields to the new values
			for(var k in newob)
			{
				ob(k) = newob[k];
				//echo(k + "=" + ob(k) + "<br />");
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

tin.exist = function(id){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			obsql = "SELECT recid FROM tblCaseFaq WHERE recid='" + id + "'";
		
		//use static cursor or recordCount will always be -1
		ob.cursorType = 3;
		ob.open(obsql, ObjConn);
		
		// if the recordset is not empty, return exist as Y. else return N
		returnOb.count = ob.recordCount;
		if(ob.recordCount==1)
		{
			returnOb.exist = "Y";
		}
		else{
			returnOb.exist = "N";
		}
		
		returnOb.success = "ok";
		ob.close();
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};


tin.del = function(id){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			obsql = "DELETE FROM tblCaseFaq WHERE recid='" + id + "'";
		
		//check if it exists first
		var etest = tin.exist(id);
		if( etest.exist == "Y" )
		{
			ObjConn.execute(obsql);
		
			returnOb.success = "ok";
			//ob.close();
		}
		else{
			throw new Error("Unable to delete because the record does not exist: " +id);
		}
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};

tin.get = function(id){
	try{
		//create these objects no matter what
		var ob = Server.createObject("ADODB.Recordset"),
			obsql = "";
		
		/* Begin options, to handle various use-cases for this method */
		
		//if just one recid is passed as a string, return that record
		if(typeof(id)=="string" && arguments.length==1)
		{
			//returnOb is an object
			var returnOb = {};
			
			obsql = "SELECT * FROM tblCaseFaq WHERE recid='" + id + "'";
				
			ob.open(obsql, ObjConn);
			if(ob.eof!=true){
				ob.moveFirst();
				//build a simpler JS object to return
				for(var i=0; i<ob.Fields.Count; i++)
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
			//returnOb is an array
			var returnOb = [];
			obsql= 		  "SELECT * FROM tblCaseFaq "
			obsql=obsql + "WHERE " + id.where;
			
			ob.open(obsql, ObjConn);
			
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

tin.set = function(newob){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			obsql = "SELECT * FROM tblCaseFaq WHERE recid='" + newob.recid + "'";
		ob.locktype = 3;
		ob.open(obsql, ObjConn);
		if(ob.eof!=true){
			ob.moveFirst();
			
			//set all the fields to the new values
			for(var k in newob)
			{
				ob(k) = newob[k];
			}
			
			// then update the record
			ob.update();
			returnOb.success = "ok";
		}
		else{
			returnOb.errors = "Record not found.";
			returnOb.success = "no";
		}
		
		ob.close();
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};


/* Just pass custom sql */
tin.getSql = function(sqlstring){
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