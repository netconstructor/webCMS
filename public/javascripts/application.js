$(document).ready(function(){
	select_client();
});
select_client = function() {
	$('#client_id').change(function() {
		var id = '';
		$("#client_id option:selected").each(function () {
  		id = $(this).val();
		});
		window.location = "/clients/"+id+"/change"; 
	});
};
