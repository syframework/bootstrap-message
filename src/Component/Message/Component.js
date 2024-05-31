(function() {

	<!-- BEGIN NEW_BLOCK -->
	document.body.addEventListener('submitted.syform', e => {
		const form = e.target.closest('#new-msg-form');
		if (!form) return;

		const data = e.detail;
		if (!data.ok) return;

		// Reset form
		form.querySelector('.sy-picture-input-hidden').value = '';

		const feed = document.getElementById('message-feed');
		feed.innerHTML = '<div class="d-flex justify-content-center"><div class="spinner-border"></div></div>';
		const url = new URL('{FEED_URL}', window.location.origin);
		url.searchParams.set('ts', Date.now());
		fetch(url.href).then(response => response.text()).then(html => {
			feed.innerHTML = html;
		});
		feed.dispatchEvent(new CustomEvent('feed-loaded'));
	});
	<!-- END NEW_BLOCK -->

})();