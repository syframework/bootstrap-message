(function() {

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target.closest('#edit-msg-form');
		if (!form) return;

		const data = e.detail;
		if (!data.ok) return;

		const id = form.querySelector('input[name=message_id]').value;
		form.querySelector('.sy-picture-input-hidden').value = '';
		document.querySelector('#message-' + id + ' blockquote.blockquote').innerHTML = data.custom.message;
		document.querySelector('#message-' + id + ' button[data-message]').dataset.message = data.custom.message_raw;
	});

	document.body.addEventListener('show.bs.modal', e => {
		const modal = e.target.closest('#edit-msg-modal');
		if (!modal) return;

		const button = e.relatedTarget;
		if (!button) return;

		modal.querySelector('input[name=message_id]').value = button.dataset.messageId;
		modal.querySelector('textarea[name=message]').value = button.dataset.message;
		modal.querySelector('.sy-picture-input-hidden').value = '';
	});

	document.body.addEventListener('shown.bs.modal', e => {
		const modal = e.target.closest('#edit-msg-modal');
		if (!modal) return;
		modal.querySelector('textarea[name=message]').focus();
	});

})();