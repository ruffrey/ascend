$(function(){
	$('table#tblGlossary').dataTable({ 
		"bPaginate": true,
        "bLengthChange": true,
        "bStateSave": true,
		"bFilter": true,
		"bInfo": true,
		"bAutoWidth": false,
		"sAjaxSource": "data/glossary.txt",
		"aoColumns": [
			{ "mDataProp": "term" },
			{ "mDataProp": "def" }
		]
	}).addClass('datatable');
	$('div#tblGlossary_paginate a').addClass('btn');
});