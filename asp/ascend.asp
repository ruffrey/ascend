<%@language="javascript"%>

<% /* This file loads application or environment specific dependencies, as well
	* as the Ascend Framework.
	*/

	
	/* PRE-LOAD DEPENDENCIES
	 * Anything which must be loaded before Ascend should go here.
	 * Examples:
	 * 		- a global user object
	 * 		- connection strings
	 *
	 *
	 *	<!--#include virtual="somefile.asp"-->
	 */
%>

<%
	/* Next, the Ascend Framework is loaded. */
%>
		<!--#include file="ascend/main.asp"-->

<%
	/* POST-LOAD DEPENDENCIES 
	 * Anything which must be loaded after Ascend should go here.
	 * Examples:
	 * 		- models or controllers that are used on every web page
	 * 		- extensions to the Ascend Framework
	 * 		- website header / client-side resources 
	 */
%>
