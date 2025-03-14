<?php
namespace Sy\Bootstrap\Component\Message\Reply;

class AddForm extends \Sy\Bootstrap\Component\Form {

	/**
	 * @var int
	 */
	private $messageId;

	private $picture;

	public function __construct($messageId, $picture = true) {
		parent::__construct();
		$this->messageId = $messageId;
		$this->picture   = $picture;
	}

	public function init() {
		$this->setAttributes([
			'class'           => 'message-reply-form',
			'data-message-id' => $this->messageId,
		]);
		$this->addHidden(['name' => 'message_id', 'value' => $this->messageId, 'required' => 'required']);

		// Anti spam check
		$this->addAntiSpamField();

		// Crsf check
		$this->addCsrfField();

		$this->addTextarea([
			'name'        => 'message',
			'id'          => 'reply-form-textarea-' . $this->messageId,
			'required'    => 'required',
			'maxlength'   => 2048,
			'placeholder' => $this->_('Add an answer'),
		]);

		$div = $this->addDiv(['class' => 'clearfix']);

		$this->addButton(
			'Answer',
			[
				'id'   => 'reply-form-btn-' . $this->messageId,
				'type' => 'submit',
				'class' => 'btn-reply float-end',
			],
			[
				'size'  => 'sm',
				'color' => 'primary',
				'icon'  => 'send',
			],
			$div
		);

		if ($this->picture) {
			$div->addElement(new \Sy\Bootstrap\Component\Form\Picture([
				'name'  => 'picture',
				'size'  => 'sm',
				'title' => 'Choose picture',
			]));
		}
	}

	public function submitAction() {
		$service = \Project\Service\Container::getInstance();
		try {
			$this->validatePost();

			$user = $service->user->getCurrentUser();

			// Create message
			$userId = $user->id;
			$messageId = $this->messageId;
			$message = $this->post('message');
			$id = $service->messageReply->create([
				'user_id'    => $userId,
				'message_id' => $messageId,
				'message'    => $message,
				'ip'         => sprintf("%u", ip2long($_SERVER['REMOTE_ADDR'])),
			]);

			// Save pictures
			$picture = $this->post('picture');
			if (!empty($picture)) {
				$dir = "/photo/message/$messageId/reply/$id/user/$userId";
				$ldir = "/photo/user/$userId/message/$messageId/reply/$id";

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
					if (imagewebp($img, UPLOAD_DIR . "$dir/$file", 90)) {
						@symlink(UPLOAD_DIR . "$dir/$file", UPLOAD_DIR . "$ldir/$file");
						$message .= "\n" . PROJECT_URL . UPLOAD_ROOT . "$dir/$file" . (empty($p['caption']) ? '' : ' [' . str_replace(']', '', $p['caption']) . ']');
					}
				}
			}
			$service->messageReply->update(['id' => $id], ['message' => $message]);

			return $this->jsonSuccess('Message sent', custom: [
				'nb_reply' => $service->messageReply->count(['message_id' => $messageId]),
			]);
		} catch (\Sy\Bootstrap\Component\Form\CsrfException $e) {
			$this->logWarning($e);
			return $this->jsonError($e->getMessage());
		} catch (\Sy\Component\Html\Form\Exception $e) {
			$this->logWarning($e);
			return $this->jsonError($this->getOption('error') ?? $this->_('Please fill the form correctly'));
		} catch (\Sy\Db\MySql\Exception $e) {
			$this->logWarning($e);
			return $this->jsonError('Database error');
		}
	}

}