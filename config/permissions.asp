<%
/* Permissions related configs, used to create the permissions table 
 * access model.
 */

	$config.permissions = {
		// the database table 
		table: $config.settings.perm_dbtable,
		// primary key
		pk: $config.settings.perm_pk,
		// connection string to the database
		dbstring: $config.db.dbcss,
		// name of the field/column in the permissions table where user ID is stored
		userField: $config.settings.perm_userField,
		// name of the field/column in the permissions table where the role is stored
		roleField: $config.settings.perm_roleField
	};
	
%>