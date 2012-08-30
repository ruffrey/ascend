<%@language=javascript%>
<!--#include file="../../asp/main.asp"-->
<!--#include file="../../models/wt.asp"-->
<!--#include file="../../models/perm.asp"-->
<%
	var tmsql="", fullsqlstring="";
	if( !$Q.adminusers )
	{
		var admins = perm.getAll(),
			sqluarr = "(''";
			
		// build an array of all admin users in sql syntax
		for(var i=0; i<admins.length; i++)
		{
			sqluarr=sqluarr+ ",'"+admins[i].val+"'";
		}
		sqluarr = sqluarr+")";
		tmsql = " AND accesslogin NOT IN " + sqluarr;
		//echo(tmsql);
	}
	
	if( $Q.accesstime_start && $Q.accesstime_end )
	{
		fullsqlstring = "SELECT count(accesstime) as access_count, accessfile FROM (SELECT * FROM tblCaseFaqWT WHERE accesstime between '"+$Q.accesstime_start+"' and '"+$Q.accesstime_end+"' " + tmsql +" ) as tbl GROUP BY accessfile";
		//echo(fullsqlstring);
	}
	else{
		fullsqlstring = "SELECT accessfile, count(accessfile) as access_count FROM ( SELECT * FROM tblcasefaqwt WHERE 1=1 "+ tmsql +" ) as tbl GROUP BY accessfile";
		//echo(fullsqlstring);
	}
	
	var tm = wt.getSql(fullsqlstring);
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
			echo( "['"+ tm[i].accessfile + "',"+tm[i].access_count +"]," );
		}
		
		echo( "['"+ tm[tlen].accessfile + "',"+tm[tlen].access_count +"]" );
		echo("]]");
	}

%>
	
