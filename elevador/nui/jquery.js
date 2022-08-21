$(function() {
  
	var actionContainer = $(".container");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		RequestElevador();
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
		  sendData("ButtonClick", "fechar");
		}
	  }
	};
});
  

$(document).on("click", ".andar", function () {
	if ($(this).attr("data-action")) {
		$(this).click(function() {
			var data = $(this).data("action");
			sendData("ButtonClick", data);
		});
	}
});

function sendData(name, data) {
	$.post("http://elevador/" + name, JSON.stringify(data), function(
		datab
	) {
		if (datab != "ok") {
		console.log(datab);
		}
	});
}

function RequestElevador () {
	$.post("http://elevador/QtdElev", JSON.stringify({}), (data) => {
		let i = 0;
		const nameList = data.elevadores.sort((a, b) => (a.nome > b.nome) ? 1 : -1);
		$('.elevador').html(`
		${nameList.map((item) => (`
		
			<div data-action="${item.slot}" class="andar">${item.title}</div>
		
		`)).join('')}
		</div>
		`);
	});
}
