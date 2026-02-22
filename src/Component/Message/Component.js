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

})();