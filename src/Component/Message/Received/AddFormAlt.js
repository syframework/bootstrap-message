(function () {
	document.body.addEventListener('change', function (e) {
		if (!e.target.classList.contains('account-checkbox')) return;
		console.log('catch change event');
		var form = e.target.form;
		form.querySelectorAll('.account-ok').forEach(function (accountOk) {
			accountOk.style.display = accountOk.style.display === 'none' ? '' : 'none';
		});
		e.stopImmediatePropagation();
	});

	document.addEventListener('DOMContentLoaded', function () {
		document.querySelectorAll('.account-checkbox').forEach(function (checkbox) {
			if (!checkbox.checked) return;
			checkbox.form.querySelectorAll('.account-ok').forEach(function (accountOk) {
				accountOk.style.display = accountOk.style.display === 'none' ? '' : 'none';
			});
		});
	});
})();