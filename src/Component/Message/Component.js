(function() {

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target;
		if (!form.classList.contains('sy-new-msg-form')) return;

		const data = e.detail;
		if (!data.ok) return;

		// Reset form
		form.querySelector('.sy-picture-input-hidden').value = '';

		const feed = document.getElementById('message-feed');
		feed.innerHTML = '<div class="d-flex justify-content-center"><div class="spinner-border"></div></div>';
		const url = new URL('{FEED_URL}', window.location.origin);
		url.searchParams.set('ts', Date.now());
		fetch(url.href)
			.then(response => response.text())
			.then(html => {
				feed.innerHTML = html;
				feed.dispatchEvent(new CustomEvent('feed-loaded', { bubbles: true }));
			});
	});

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target;
		if (!form.classList.contains('sy-edit-msg-form')) return;

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