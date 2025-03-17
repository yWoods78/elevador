$(function() {
  
	var actionContainer = $(".container");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		RequestElevador(item.floors);
		$('body').css('background-color', 'rgba(0, 0, 75, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }
	});
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		if (actionContainer.is(":visible")) {
			$.post(`http://${GetParentResourceName()}/close`, JSON.stringify({}));
		}
	  }
	};
});
  

$(document).on("click", ".andar", function () {
	$.post(`http://${GetParentResourceName()}/floorSelected`, JSON.stringify({
		floor: $(this).attr("data-action")
	}));
});


function RequestElevador (floors) {
	$('.elevador').html(``)
	for (const [index,floorData] of Object.entries(floors)) {
		$('.elevador').append(`
			<div data-action="${index}" class="andar">${floorData.name}</div>
		`);
	}
}
