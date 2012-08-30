<%	/* This is the base model object using closure inheritance */
	
var $model = function(){};
	
/* these gets defined by the user after instantiating the object */

/* the connection string to use for this object */
$model.dbstring = "";

/* A collection of functions which return true if validated,
 * or a string with information if not
 */
$model.validations = [];
$model.errors = [];
$model.isValid = false;

/* the database table to do CRUD operations on 
 * (only supports a single database table per model)
 */
$model.table = "";

/* the primary key field
 * (only supports a single primary key as a unique identifier)
 */
$model.pk = "";

/* Returns a new model with the settings defined in an object */
$model.create = function(settings){
	
	var newmodel = new Object($model);
	
	for( var s in settings )
	{
		newmodel[s] = settings[s];
	}
	
	return newmodel;
};

$model.connection=false;

$model.connect = function(){
	$model.connection = Server.CreateObject("ADODB.Connection");
	$model.connection.open( $model.dbstring );	
};

$model.disconnect = function(){
	$model.connection.close();
	$model.connection = false;
};

$model.validate = function(){
	delete $model.errors;
	$model.errors=[];
	var result;
	for( var v=0; v<$model.validation.length; v++ )
	{
		result=$model.validation[v];
		// result must return true if passed, or an error message string
		if( result != true )
		{
			$model.errors.push( result );
		}
	}
	return errors.length>0?false:true;
};

/* CRUD Methods
 * All assume an open connection
 */
$model.insert = function(newob){
	var returnOb = {};
	try{
		var ob = Server.createObject("ADODB.Recordset"),
			_fields=[],
			_values=[];

		ob.cursorType = 2;
		ob.lockType = 3;
		
		//separate the fields & values for insertion
		for(var k in newob)
		{
			_fields.push(k);
			_values.push(newob[k]);
		}
		
		// open the recordset
		ob.open( $model.table, $model.connection )
		
		// add & update the records
		ob.addNew( _fields, _values );
		ob.update();
		
		// close the recordset & connection
		ob.close();
		
		// success message
		returnOb.success = "ok";
		
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};

$model.del = function(pkval){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			obsql =  "DELETE FROM "
					+$model.table
					+" WHERE " + $model.pk + "='" + pkval + "'";
		
			$model.connection.execute(obsql);
			returnOb.success = "ok";
	}
	catch(er){
		returnOb.errors = er.message
		returnOb.success = "no";
	}
	return returnOb;
};

$model.get = function(id){
	//returnOb is an object initially
	var returnOb = {};
	try{
		//create these objects no matter what
		var ob = Server.createObject("ADODB.Recordset"),
			obsql = "";
		
		/* Begin options, to handle various use-cases for this method */
		
		//if just one id is passed as a string, return that record
		if(typeof(id)=="string" && arguments.length==1)
		{
				
			obsql = "SELECT * FROM "+$model.table +" WHERE id='" + id + "'";
				
			ob.open(obsql, $model.connection);
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
			
			obsql= 	"SELECT * FROM " + $model.table;
			obsql+= " WHERE " + id.where;
			echo(obsql);
			ob.open(obsql, $model.connection);
			
			//returnOb is an array
			returnOb = [];
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
		if(returnOb instanceof Array)
		{
			var tempOb = {};
			tempOb.rows = returnOb;
			tempOb.errors = er.message || er;
			tempOb.success = "no";
			returnOb = tempOb;
		}
		else
		{
			returnOb.errors = er.message || er;
			returnOb.success = "no";
		}
	}
	//echo( JSON.stringify(returnOb) );
	return returnOb;
};

$model.getAll = function(){
	var returnOb = [];
	try{
		//create these objects no matter what
		var ob = Server.createObject("ADODB.Recordset"),
			obsql = "";
		
		obsql= "SELECT * FROM " + $model.table;
		
		ob.open(obsql, $model.connection);
		
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
		ob.close();
	
	}
	catch(er){
		returnOb = {};
		returnOb.errors = er.message;
		returnOb.success = "no";
	}
	return returnOb;
};

$model.update = function(newob){
	try{
		var returnOb = {},
			ob = Server.createObject("ADODB.Recordset"),
			obsql = "SELECT * FROM " + $model.table + " WHERE "
					+$model.pk +"='" + newob[$model.pk] + "'";
		
		ob.locktype = 3;
		ob.open(obsql, $model.connection);
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
		returnOb.errors = er.message;
		returnOb.success = "no";
	}
	return returnOb;
};

%>