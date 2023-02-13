$(document).ready(function() {
    console.log('ready');
    init();
});

function init(){

   onshowresumen();
}


function onshowresumen(){
	$('#modalresumen').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) 
          var partido = button.data('person')
          
	  var modal = $(this)
	
          // Ajax
          $.ajax({
            type: "GET",
            url: "Controller?op=resumen&person="+partido,
            success : function(info) {
                    $("#resumen").html(info);
                }
            });
          })
}
