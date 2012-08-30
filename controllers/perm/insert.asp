<%@language=javascript%>
<!--#include virtual="/custrelat/includes/jsconn.asp"-->
<!--#include file="../../asp/main.asp"-->
<!--#include file="../../models/perm.asp"-->
<%
	var r = perm.add($F);
	echo(JSON.stringify(r));
%>