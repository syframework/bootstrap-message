(function() {

	document.body.addEventListener('submit', e => {
		const form = e.target.closest('#edit-msg-form');
		if (!form) return;
		e.preventDefault();

		const id = form.querySelector('input[name=message_id]').value;

		const btn = form.querySelector('button[type=submit]');
		btn.setAttribute('disabled', 'disabled');

		const div = document.getElementById('edit-msg-div');
		div.style.display = 'none';

		fetch(form.getAttribute('action'), {
			method: 'POST',
			body: new FormData(form)
		})
		.then(response => response.json())
		.then(result => {
			if (result.status === 'ok') {
				// Reset form
				form.querySelector('.sy-picture-input-hidden').value = '';

				const modal = bootstrap.Modal.getOrCreateInstance(document.getElementById('edit-msg-modal'));
				modal.hide();

				document.querySelector('#message-' + id + ' blockquote.blockquote').innerHTML = result.message;
				document.querySelector('#message-' + id + ' button[data-message]').dataset.message = result.message_raw;
			} else {
				div.innerHTML = result.message;
				div.style.display = '';
				if (result.csrf) {
					form.querySelector('input[name="__csrf"]').value = result.csrf;
				}
			}
			btn.removeAttribute('disabled');
		})
		.catch(error => console.error('Error:', error));
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