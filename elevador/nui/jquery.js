$(function() {
	init();
  
	var actionContainer = $(".actionmenu");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		ResetMenu();
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
  
function ResetMenu() {
	$("div").each(function(i, obj) {
		var element = $(this);

		if (element.attr("data-parent")) {
		element.hide();
		} else {
		element.show();
		}
	});
}

function init() {
	$(".menuoption").each(function(i, obj) {
		// console.log('cheguei')
		// if ($(this).attr("data-action")) {
		// $(this).click(function() {
		// 	var data = $(this).data("action");
		// 	sendData("ButtonClick", data);
		// });
		// }

		if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);

		$(this).click(function() {
			element.show();
			$("#mainmenu").hide();
		});

		$(".subtop button, .back").click(function() {
			element.hide();
			$("#mainmenu").show();
		});
		}
	});
}

$(document).on("click", ".menuoption", function () {
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
		const nameList = data.agendados.sort((a, b) => (a.nome > b.nome) ? 1 : -1);

		// ============= MEUS SEGUROS =============//
		$('.mainContainer').html(`
		<div class="titleContainer">
			<h1>ELEVADOR</h1>
		</div>
		
		<div class="buttonsContainer">
		${nameList.map((item) => (`
		
			<span class="buttonStyle${item.slot}">
				<button class="menuoption" data-action="${item.slot}">${item.slot}°</button>
			</span>
		
		`)).join('')}
		</div>
		`);
	});
}

$('.category_item').click(function() {
let pegArma = $(this).attr('category');
$('.item-item').css('transform', 'scale(0)');

function hideArma() {
	$('.item-item').hide();
}
setTimeout(hideArma, 100);

function showArma() {
	$('.item-item[category="' + pegArma + '"]').show();
	$('.item-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
}
setTimeout(showArma, 100);
});

$('.category_item[category="all"]').click(function() {
function showAll() {
	$('.item-item').show();
	$('.item-item').css('transform', 'scale(1)');
}
setTimeout(showAll, 100);
});
