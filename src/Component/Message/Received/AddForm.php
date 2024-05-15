<?php
namespace Sy\Bootstrap\Component\Message\Received;

class AddForm extends \Sy\Bootstrap\Component\Form {

	/**
	 * @var int
	 */
	private $itemId;

	/**
	 * @var string
	 */
	private $itemType;

	public function __construct($itemId, $itemType) {
		parent::__construct();
		$this->itemId = $itemId;
		$this->itemType = $itemType;
	}

	public function init() {
		$this->setAttributes([
			'id' => 'new-msg-form',
		]);
		$this->addHidden(['name' => 'item_id', 'value' => $this->itemId]);
		$this->addHidden(['name' => 'item_type', 'value' => $this->itemType]);

		// Anti spam check
		$this->addAntiSpamField();

		// Crsf check
		$this->addCsrfField();

		$this->addTextarea([
			'name'        => 'message',
			'id'          => 'new-msg-textarea',
			'required'    => 'required',
			'maxlength'   => 2048,
			'placeholder' => 'Your message',
		]);

		$div = $this->addDiv(['class' => 'clearfix']);

		$this->addButton(
			'Send',
			[
				'id'    => 'new-msg-send-btn',
				'type'  => 'submit',
				'class' => 'float-end',
			],
			[
				'size'  => 'sm',
				'color' => 'primary',
				'icon'  => 'paper-plane',
			],
			$div
		);

		$div->addElement(new \Sy\Bootstrap\Component\Form\Picture([
			'name'  => 'picture',
			'size'  => 'sm',
			'title' => 'Choose picture',
		]));
	}

	public function submitAction() {
		$service = \Project\Service\Container::getInstance();
		try {
			$this->validatePost();

			$user = $service->user->getCurrentUser();

			if (!$user->isConnected()) throw new \Sy\Db\MySql\Exception();

			// Create message
			$userId = $user->id;
			$message = $this->post('message');
			$id = $service->messageReceived->create([
				'user_id'   => $userId,
				'item_id'   => $this->itemId,
				'item_type' => $this->itemType,
				'message'   => $message,
				'ip'        => sprintf("%u", ip2long($_SERVER['REMOTE_ADDR'])),
			]);

			// Save pictures
			$picture = $this->post('picture');
			if (!empty($picture)) {
				$dir = "/photo/message/$id";
				$ldir = "/photo/user/$userId/message/$id";

				if (!file_exists(UPLOAD_DIR . $dir)) {
					mkdir(UPLOAD_DIR . $dir, 0777, true);
				}
				if (!file_exists(UPLOAD_DIR . $ldir)) {
					mkdir(UPLOAD_DIR . $ldir, 0777, true);
				}

				$picture = json_decode($picture, true);
				foreach ($picture as $p) {
					$img = imagecreatefromstring(base64_decode($p['image']));
					$file = uniqid() . '.webp';
					if (imagewebp($img, UPLOAD_DIR . "$dir/$file", 100)) {
						@symlink(UPLOAD_DIR . "$dir/$file", UPLOAD_DIR . "$ldir/$file");
						$message .= "\n" . PROJECT_URL . UPLOAD_ROOT . "$dir/$file" . (empty($p['caption']) ? '' : ' [' . str_replace(']', '', $p['caption']) . ']');
					}
				}
			}
			$service->messageReceived->update(['id' => $id], ['message' => $message]);

			return json_encode(['status' => 'ok']);
		} catch (\Sy\Bootstrap\Component\Form\CsrfException $e) {
			$this->logWarning($e);
			return json_encode(['status' => 'ko', 'message' => $e->getMessage(), 'csrf' => $service->user->getCsrfToken()]);
		} catch (\Sy\Component\Html\Form\Exception $e) {
			$this->logWarning($e);
			return json_encode(['status' => 'ko', 'message' => is_null($this->getOption('error')) ? $this->_('Please fill the form correctly') : $this->getOption('error')]);
		} catch (\Sy\Db\MySql\Exception $e) {
			$this->logWarning($e);
			return json_encode(['status' => 'ko', 'message' => $this->_('Error')]);
		}
	}

}