$(document).ready(function(){
	$('#login').click(function(){
		$('#windowLogin').fadeIn();
		$('#window').fadeIn();
	});
	$('#window').click(function(){
		$('#window').fadeOut();
		$('#windowLogin').fadeOut();
	});
	$('#x').click(function(){
		$('#window').fadeOut();
		$('#windowLogin').fadeOut();
	});
	$('input[type=text], input[type=password]').focus(function(){
		$(this).val('');
	});
})