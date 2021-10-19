<?php
namespace Sy\Bootstrap\Component\Message\Received;

class Item extends \Sy\Component\WebComponent {

	/**
	 * @var array
	 */
	private $message;

	/**
	 * @var bool
	 */
	private $opened;

	/**
	 * @var bool
	 */
	private $picture;

	/**
	 * @var bool
	 */
	private $share;

	public function __construct($message) {
		parent::__construct();
		$this->message = $message;
		$this->opened  = false;
		$this->picture = true;
		$this->share   = true;
	}

	public function __toString() {
		$this->init();
		return parent::__toString();
	}

	public function open() {
		$this->opened = true;
	}

	public function noPicture() {
		$this->picture = false;
	}

	public function noShare() {
		$this->share = false;
	}

	private function init() {
		$this->addTranslator(LANG_DIR . '/bootstrap-message');
		$this->setTemplateFile(__DIR__ . '/Item.html');
		$this->addJsCode(__DIR__ . '/Item.js');

		$message = $this->message;
		$date = new \Sy\Bootstrap\Lib\Date($message['created_at']);
		$author = $this->_(\Sy\Bootstrap\Lib\Str::convertName($message['user_firstname'] . ' ' . $message['user_lastname']));
		$this->setVars([
			'ID'             => $message['id'],
			'PROFILE_IMG_SRC'=> \Sy\Bootstrap\Lib\Url::avatar($message['user_id']),
			'USER_ID'        => $message['user_id'],
			'AUTHOR'         => $author,
			'MESSAGE'        => \Sy\Bootstrap\Lib\Str::convert($message['message']),
			'MESSAGE_RAW'    => htmlentities($message['message'], ENT_COMPAT),
			'DATE'           => $date->humanTimeDiff(),
			'DATETIME'       => $date->timestamp(),
			'NB_REPLY'       => $message['nb_reply'],
			'NEW'            => ($message['nb_reply'] > 0 ? '' : 'new'),
			'CMT_BTN_HIDDEN' => $this->opened ? 'd-none' : '',
			'CMT_DIV_HIDDEN' => $this->opened ? '' : 'style="display:none"',
		]);
		$feed = new \Sy\Bootstrap\Component\Message\Reply\Feed($message['id']);
		$feed->setLast(null); // Force to not load the first page
		$this->setComponent('REPLY_FEED', $feed);

		// Reply form for connected user only
		$service = \Project\Service\Container::getInstance();
		$user = $service->user->getCurrentUser();
		if ($user->isConnected() and !$user->hasRole('blacklisted')) {
			$this->setComponent('REPLY_FORM', new \Sy\Bootstrap\Component\Message\Reply\AddForm($message['id'], $this->picture));
		} elseif (!$user->isConnected()) {
			$this->setVar('CONNECT_URL', \Sy\Bootstrap\Lib\Url::build('page', 'user-connection'));
			$this->setBlock('CONNECT_BTN_BLOCK');
		}

		// Edit message button
		if ($user->id === $message['user_id'] and (int) $message['nb_reply'] === 0) {
			$this->setBlock('EDIT_BTN_BLOCK');
		}

		// Delete button for administrator
		if ($user->hasPermission('message-delete') or $user->id === $message['user_id']) {
			$this->setComponent('DEL_BTN_FORM', new \Sy\Bootstrap\Component\Message\Received\DeleteForm($message['id']));
		}

		// Share message button
		if ($this->share) {
			$shareBtn = new \Sy\Bootstrap\Component\Share\Button(
				url: PROJECT_URL . WEB_ROOT . \Sy\Bootstrap\Lib\Url::build('page', 'message', ['id' => $message['id']]),
				size: 'sm',
				title: 'Share this message',
				width: 'auto'
			);
			$this->setComponent('SHARE_BTN', $shareBtn);
		}
	}

}
