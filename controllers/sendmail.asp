<%

	var send_mail_test_mode = false;
	
	function sendmail(to, subj, bod){
		
		var mobj = Server.CreateObject("CDONTS.NewMail")
		  , mwrap1 = "<!doctype html><html><head><style type='text/css'>body{font-family: tahoma;}</style></head><body>"
		  , mwrap2 = "<p><a href='http://"+config.domain.prod+config.root+"'>Case Help Site</a></p></body></html>";
		
		// for html format
		mobj.BodyFormat = 0;
		mobj.MailFormat = 0; 

		mobj.from = user.empemail;
		mobj.to = to;
		mobj.subject = "CASE QUESTION "+subj;
		
		mobj.body = mwrap1 + bod + mwrap2;
		
		if(!send_mail_test_mode)
		{
			mobj.send();
		}
		
		return true;
	}

%>