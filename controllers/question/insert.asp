<%@language=javascript%>
<!--#include file="../../asp/main.asp"-->
<!--#include file="../../models/question.asp"-->
<%
	/* Creates a new Question record in tblCaseFaqQ */
	
	/* A little house cleaning */
	$F.submittime = sqldate();
	$F.login = user.login;
	
	/* Test print form post */
		//echo(JSON.stringify($F));	
	
	/* do not allow an empty string for DOS 
	 * because it gets converted to 1900-01-01
	 */
	if( $F.dos =='' )
	{
		delete $F.dos;
	}
	
	/* Insert the record */
	var rtn = question.add( $F );
	
	/* print response text */
	if(rtn.success!="ok")
	{
		echo( JSON.stringify(rtn) );
	}
	else{
		echo( JSON.stringify(rtn) );
	}
%>