<%
	/* Load a JSON file into a JS object */
	function $jsonLoad(file){
		// create file system object
		var _fso = Server.createObject("Scripting.FileSystemObject");
		
		// open the file
		var _f = _fso.openTextFile( Server.mapPath(file) );
		
		// read the text into a string variable
		var _ftxt = _f.readAll();

		// eval the text into a JS object
		var _obj = JSON.parse( _ftxt );
		
		return _obj;
	}
	
	/* Write a JS Object into a JSON file */
	function $jsonSave(obj, file){
		var _openForWriting=2;
		
			// create file system object
		var   _fso = Server.createObject("Scripting.FileSystemObject")
			// open the file
			, _f = _fso.openTextFile( Server.mapPath(file),_openForWriting )
			// create the text to be written
			, _ftxt = JSON.stringify(obj);
		// write the text
		_f.writeLine( _ftxt );
		// no return
	}
	
%>