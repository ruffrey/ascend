<%@language=javascript%>
<!--#include virtual="/custrelat/includes/jsconn.asp"-->
<!--#include file="../../asp/main.asp"-->
<!--#include file="../../models/perm.asp"-->
<%
	var d = perm.del($Q.id);
	echo(JSON.stringify(d));
%>