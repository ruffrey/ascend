<%	/* Contains app-specific configurations.
	*/

	var $config = {};
	
	$config.debug = false;
		
	/* Session Prefix
	 * no spaces allowed - used as a prefix 
	 * to data stored in the session object 
	 */
	$config.spre = "app";
	
	/* domain-relative, include trailing forward slash */
	$config.root = "/path/to/root/";
	
	/* If user does not have permissions to view a page, redirect here */
	$config.redirectPage = $config.root+"index.asp";
	
	/* -- Environment Variables -- 
	 * Do not include forward slashes on domain.
	 * db contains the connection strings, not connection objects.
	 */
	$config.env = {
		 dev: {
			domain: "devdomain",
			db:{
				"employee_db_name": conn_string,
				"dbcss": another_conn_string
			}
		 }	
		,prod: {
			domain: "proddomain",
			db:{
				"employee_db_name": conn_string,
				"dbcss": another_conn_string
			}
		}
	};
	
	/* Settings which can be more easily edited by admins */
	
	$config.settings = $jsonLoad( $config.root+'config/settings.json' );
	
	/* the local object with user properties */
	$config.localUserObject = user;
	
%>