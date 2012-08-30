<!--#include file="views/header.asp"-->

<link rel="stylesheet" type="text/css" href="css/datepicker.css">
<link rel="stylesheet" type="text/css" href="css/jqplot.css">
<link rel="stylesheet" type="text/css" href="css/jq-ui-slider.css">
<link rel="stylesheet" type="text/css" href="css/timepicker-addon.css">

<script src="js/jq-ui-all.js"></script>

<script src="js/jqplot.js"></script>
<script src="js/wt.js"></script>
<script src="js/jqplot/jqplot.dateAxisRenderer.min.js"></script>
<script src="js/jqplot/jqplot.canvasTextRenderer.min.js"></script>
<script src="js/jqplot/jqplot.canvasAxisTickRenderer.min.js"></script>
<script src="js/jqplot/jqplot.categoryAxisRenderer.min.js"></script>
<script src="js/jqplot/jqplot.pointLabels.min.js"></script>
<script src="js/jqplot/jqplot.barRenderer.min.js"></script>
<!--[if lt IE 9]>
	<script src="js/jqplot/excanvas.js"></script>
<![endif]-->
	
<h1>Access Trends</h1>
<p>&nbsp;</p>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span10">
			<div class="row-fluid">
				<div class="span12">
					<form id="rpt">
						<div class="row-fluid">
							<!-- dates -->
							<div class="span4 well">
								<h3>Date</h3>
								<label for="accesstime_start">From</label>
								<input class="datepicker" id="accesstime_start" 
									name="accesstime_start" />
								
								<label for="accesstime_end">To</label>
								<input class="datepicker" id="accesstime_end" 
									name="accesstime_end" />
								
							</div>
							
							<div class="span4 well">
								<label>
									<input type="checkbox" value="x"
										name="adminusers" id="adminusers" />
									Include Administrators
								</label>
								
								<br />
								<button type="submit" class="btn btn-primary btn-large">
									Generate Report
									<i class="icon-chevron-right icon-white"></i>
								</button>
							</div>
							<div id="ajaxmsg" class="span4">
								
							</div>
						</div>
					</form>
				</div>
			</div>
						
		</div>
	</div>
	<!-- report is inserted here -->
	<div class="row-fluid report">
		<br />
		<br />
		<div id="rptOutput"></div>	
	</div>
</div>
<br />
<br />
<br />
<br />
<!--#include file="views/footer.asp"-->