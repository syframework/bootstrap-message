(function() {

	const element = document.getElementById('new-msg-modal');
	const modal = bootstrap.Modal.getOrCreateInstance(element);
	const alert = element.querySelector('div.alert:not(:empty)');
	const btn = document.getElementById('new-msg-send-btn');
	const div = document.getElementById('new-msg-div');

	if (alert) {
		const tab = bootstrap.Tab.getOrCreateInstance(document.querySelector('#tablist-ul a[href="#messages"]'));
		tab.show();
		modal.show();
	}

	<!-- BEGIN NEW_BLOCK -->
	document.body.addEventListener('submit', e => {
		const form = e.target.closest('#new-msg-form');
		if (!form) return;
		e.preventDefault();

		btn.setAttribute('disabled', 'disabled');
		div.style.display = 'none';

		fetch(form.getAttribute('action'), {
			method: 'POST',
			body: new FormData(form)
		})
		.then(response => response.json())
		.then(result => {
			if (result.status === 'ok') {
				// Reset form
				document.getElementById('new-msg-textarea').value = '';
				form.querySelectorAll('.sy-picture-input-hidden').forEach(el => el.value = '');
				modal.hide();
				const feed = document.getElementById('message-feed');
				feed.innerHTML = '<div class="d-flex justify-content-center"><div class="spinner-border"></div></div>';
				const url = new URL('{FEED_URL}', window.location.origin);
				url.searchParams.set('ts', Date.now());
				fetch(url.href).then(response => response.text()).then(html => {
					feed.innerHTML = html;
				});
				document.body.dispatchEvent(new CustomEvent('feed-loaded', {
					bubbles: true,
					cancelable: true,
				}));
			} else {
				div.innerHTML = result.message;
				div.style.display = '';
				if (result.csrf) {
					form.querySelector('input[name="__csrf"]').value = result.csrf;
				}
				btn.removeAttribute('disabled');
			}
		})
		.catch(error => console.error('Error:', error));
	});
	<!-- END NEW_BLOCK -->

})();