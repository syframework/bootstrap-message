(function() {

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target;
		if (!form.classList.contains('sy-edit-msg-form')) return;

		const data = e.detail;
		if (!data.ok) return;

		const id = form.querySelector('input[name=message_id]').value;
		form.querySelector('.sy-picture-input-hidden').value = '';
		document.querySelector('#message-' + id + ' blockquote.blockquote').innerHTML = data.custom.message;
		form.querySelector('textarea[name=message]').innerText = data.custom.message_raw;
	});

	document.body.addEventListener('shown.bs.modal', e => {
		const form = e.target.querySelector('.sy-edit-msg-form');
		if (!form) return;
		form.querySelector('textarea[name=message]').focus();
	});

	document.body.addEventListener('submitted.syform', e => {
		const form = e.target.closest('.message-reply-form');
		if (!form) return;

		const data = e.detail;
		if (!data.ok) return;

		const id = form.dataset.messageId;
		form.querySelector('.sy-picture-input-hidden').value = '';
		document.getElementById('message-' + id).classList.remove('new');
		document.querySelector('#reply-feed-div-' + id + ' .feed-next-page-button').click();
		document.getElementById('reply-nb-' + id).innerHTML = data.custom.nb_reply;
	});

	document.body.addEventListener('click', e => {
		const btn = e.target.closest('.message-toggle');
		if (!btn) return;
		e.preventDefault();

		btn.classList.remove('btn-success');

		const id = btn.dataset.id;
		const container = document.getElementById('message-' + id);
		container.classList.toggle('opened');
		localStorage.setItem('reply-nb-' + id, document.getElementById('reply-nb-' + id).innerText);
	});

	document.body.addEventListener('transitionend', e => {
		const element = e.target;
		if (!element.classList.contains('comment-form')) return;

		const container = element.closest('.message-item');

		let offset = 60;
		const parent = container.closest('[data-message-offset]');
		if (parent) {
			offset = parent.dataset.messageOffset;
		}

		if (container.classList.contains('opened')) {
			let h = window.innerHeight - container.clientHeight;
			if (h > 0) {
				h = offset;
			}
			window.scroll({top: container.offsetTop - h, left: 0, behavior: 'smooth'});
		} else {
			window.scroll({top: container.offsetTop - offset, left: 0, behavior: 'smooth'});
		}
		window.dispatchEvent(new Event('scroll'));
	});

	document.body.addEventListener('feed-loaded', e => {
		document.querySelectorAll('.comment-form').forEach(element => {
			const id = element.parentElement.dataset.id;
			const feed = element.querySelector('.comment');
			const count = feed.querySelectorAll('.sms-container').length;
			if (count === 0) {
				if (localStorage.getItem('comment-' + id) === null) return;
				feed.prepend(localStorage.getItem('comment-' + id));
				if (feed.querySelectorAll('.sms-container').length > localStorage.getItem('reply-nb-' + id)) {
					feed.querySelectorAll('.sms-container').forEach(el => el.remove());
				}
			} else {
				const copy = feed.cloneNode(true);
				copy.querySelectorAll('.sms-container').forEach(el => el.removeAttribute('style'));
				copy.querySelectorAll('.feed-next-page-button').forEach(el => el.remove());
				copy.querySelectorAll('.reply-delete-form').forEach(el => el.remove());
				try {
					localStorage.setItem('comment-' + id, copy.innerHTML);
				} catch(e) {
					localStorage.clear();
				}
			}
		});

		document.querySelectorAll('.btn.message-toggle').forEach(button => {
			const id = button.dataset.id;
			if (localStorage.getItem('reply-nb-' + id) === null) return;
			if (document.getElementById('message-' + id).classList.contains('opened')) {
				localStorage.setItem('reply-nb-' + id, document.getElementById('reply-nb-' + id).textContent);
			} else if (document.getElementById('reply-nb-' + id).textContent > localStorage.getItem('reply-nb-' + id)) {
				button.classList.add('btn-success');
			}
		});
	});

	document.body.dispatchEvent(new CustomEvent('feed-loaded'));

})();