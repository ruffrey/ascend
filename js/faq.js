$(function(){
	$('h1').click(function(){
		$(this).next('form').fadeToggle(200, function () {
			if ($.browser.msie) {
				this.style.removeAttribute('filter');
			}
		});
	});
	
	$('a#whylink').click(function(){
		$('div#morewhy').show(400, function () {
			if ($.browser.msie) {
				this.style.removeAttribute('filter');
			}
			$('h6#titlestuff').hide(200, function () {
			if ($.browser.msie) {
				this.style.removeAttribute('filter');
				}
			});
		});
	});
	$('a#closehuh').click(function(){
		$('div#morewhy').hide(500);
		$('h6#titlestuff').show();
	});
});