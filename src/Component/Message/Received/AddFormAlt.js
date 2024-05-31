(function () {

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target.closest('#new-msg-form-alt');
		if (!form) return;

		const data = e.detail;
		if (!data.account) return;

		const checkbox = form.querySelector('.account-checkbox');
		if (!checkbox) return;

		checkbox.checked = true;
		checkbox.dispatchEvent(new Event('change'));
	});

	document.querySelector('#new-msg-form-alt .account-checkbox').addEventListener('change', e => {
		e.target.form.querySelectorAll('.account-ok').forEach(function (accountOk) {
			accountOk.style.display = accountOk.style.display === 'none' ? '' : 'none';
		});
	});

	document.addEventListener('DOMContentLoaded', () => {
		document.querySelectorAll('#new-msg-form-alt .account-checkbox').forEach(checkbox => {
			if (!checkbox.checked) return;
			checkbox.form.querySelectorAll('.account-ok').forEach(function (accountOk) {
				accountOk.style.display = accountOk.style.display === 'none' ? '' : 'none';
			});
		});
	});

})();