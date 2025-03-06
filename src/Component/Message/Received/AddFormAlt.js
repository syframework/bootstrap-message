(function () {

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target;
		if (!form.classList.contains('sy-new-msg-form-alt')) return;

		const data = e.detail;
		if (data.ok) return;
		if (!data.custom.account) return;

		const checkbox = form.querySelector('.account-checkbox');
		if (!checkbox) return;

		checkbox.checked = true;
		checkbox.dispatchEvent(new Event('change', { bubbles: true }));
	});

	document.body.addEventListener('change', e => {
		if (!e.target.classList.contains('account-checkbox')) return;
		const form = e.target.form;
		if (!form) return;
		if (!form.classList.contains('sy-new-msg-form-alt')) return;

		const accountOkElements = form.querySelectorAll('.account-ok');
		accountOkElements.forEach(element => {
			element.style.display = element.style.display === 'none' ? '' : 'none';
		});
	});

})();