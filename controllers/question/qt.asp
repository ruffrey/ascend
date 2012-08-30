<%@language=javascript%>
<!--#include file="../../asp/main.asp"-->
<!--#include file="../../models/question.asp"-->
<%
	/* Goes and gets a report of the question trends and returns an array for
	 * jqPlot	*/

	if( $Q.accesstime_start && $Q.accesstime_end )
	{
		var tm = question.getSql(
			"SELECT count(c_date) as access_count, c_date FROM (SELECT *, CONVERT(VARCHAR(10),submittime,110) as 'c_date' FROM tblcasefaqQ WHERE submittime between '"+$Q.accesstime_start+"' and '"+$Q.accesstime_end+"') as tbl GROUP BY c_date"
		);
	}
	else{
		//var tm = question.getSql(
		//	 "SELECT count(accesstime) as t, dos as f FROM tblcasefaqQ "
		//	+"GROUP BY dos"
		//);
		var tm = question.getSql(
			 "SELECT count(c_date) as access_count, c_date FROM (SELECT *, CONVERT(VARCHAR(10),submittime,110) as 'c_date' FROM tblcasefaqQ ) as tbl GROUP BY c_date"
		);
		
		
	}
	//echo(JSON.stringify(tm));
	if(tm.length==0)
	{
		echo("no data");
	}
	else{
		echo("[[");
		var gn="";
		var tlen = tm.length-1;

		for( var i=0; i<tlen; i++ )
		{
			echo( "['"+ tm[i].c_date + "',"+tm[i].access_count +"]," );
		}
		
		echo( "['"+ tm[tlen].c_date + "',"+tm[tlen].access_count +"]" );
		echo("]]");
	}

%>
	
