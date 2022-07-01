(function() {
	$('body').on('change', '.account-checkbox', function(e) {
		$(this.form).find('.account-ok').toggle();
		e.stopImmediatePropagation();
	});
})();