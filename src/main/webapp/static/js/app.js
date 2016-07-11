(function(){

	var modules = {};
	var contexts = {};


	contexts.common = function() {

        var $flipIcons = $("img.icon.flip");

		$flipIcons.each(function () {
			this.dataset.src = this.src;
		});
		$flipIcons.on("mouseover", function() {
			this.src = this.dataset.srcHover;
		});
		$flipIcons.on("mouseout", function() {
			this.src = this.dataset.src;
		});

		var $menus = $(".menu");
		$menus.find(".menu-title").on("click", function(e) {
			$(this).parent().toggleClass("active");
		});

		$("html").on("click", function(e){
			var $target = $(e.target);
			var isStayOpen = $target.closest(".stay-open").length !== 0;
			var isFromMenuBody = $target.closest(".menu-body").length !== 0;
			var	$menu = $target.closest(".menu");
			if (isStayOpen || ($menu.length !== 0 && !isFromMenuBody)) {
				$menus.not($menu[0]).removeClass("active");
			} else {
				$menu.removeClass("active");
			}
		});
	};

	/**
	 * Index page context
	 */
	contexts.index = function createIndex() {
		parentContext("common");
	};

	contexts.adminPanel = function createAdminPanel() {
		parentContext("common");
		var adminCommands = require("adminCommands");

		adminCommands.initialize();
	};

	contexts.userPage = function createAdminPanel() {
		parentContext("common");
		var adminCommands = require("adminCommands");

		adminCommands.initialize();
	};

	modules.adminCommands = function() {

		return {
			initialize: function() {
				$("form.ajax-command").on("submit", function (e) {
					e.preventDefault();
					var $form = $(this);
					var $message = $form.find(".message");
					$message.html(Msg.adminCommandWorking);
					$.ajax({
						type: $form.attr("method"),
						url: $form.attr("action"),
						data: $form.serialize(),
						success: function(text) {
							try {
								var data = JSON.parse(text);
								if (data.status == "OK") {
									if ($form.hasClass("reload")) {
										window.location.reload(true);
									} else {
										$message.html(Msg.adminCommandDone);
										if ($form.hasClass("permission")) {
											var $button = $form.find("input[type=submit]");
											if ($form.attr("action") === URLs.addPermission) {
												$button.val(Msg.permissionRemove);
												$form.attr("action", URLs.removePermission);
											} else {
												$button.val(Msg.permissionAssign);
												$form.attr("action", URLs.addPermission);
											}
										}
									}
								} else {
									$message.html(Msg.adminCommandError + ": " + data.message);
								}
							} catch (error) {
								$message.html("An unknown error occurred");
							}
						},
						error: function (jqXHR, error, message) {
							if (message = "Not Found")
								$message.html("You don't have permissions, or your session expired");
						}
					});
				});
			}
		};
	};


	/**
	 * Initialization of module system
	 */

	function require(moduleName) {
		var module = modules[moduleName];
		if (typeof module === "function") {
			module = module();
			modules[moduleName] = module;
		}
		return module;
	}

	function parentContext(contextName) {
		var context = contexts[contextName];
		if (context != null) {
			context();
			contexts[contextName] = null;
		}
	}

	var appContext = window.appContext;
	var typeOfContext = typeof appContext;
	if (typeOfContext === "string") {
		var initFunc = contexts[appContext];
		if (typeof initFunc === "function") initFunc();
	}

})();
