<%	

	
	
	
%>
	<div class="push"></div>
</div>

<% 	if($config.settings.show_footer) {	%>

	<div class="footer">
		<hr />
		<p>
			<a href="<%=$config.settings.footer_link_href%>">
			<%=$config.settings.footer_link_text%></a>
		</p>
	</div>

<%	}	%>

</body>
</html>