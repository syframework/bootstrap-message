<?php
namespace Sy\Bootstrap\Component\Message\Reply;

class DeleteForm extends \Sy\Bootstrap\Component\Form\Crud\Delete {

	/**
	 * @var int
	 */
	private $messageId;

	/**
	 * @param int $messageId
	 */
	public function __construct($messageId) {
		parent::__construct('messageReply', ['id' => $messageId]);
	}

	public function init() {
		$this->addClass('d-inline-block');

		$this->setOptions([
			'button-attributes' => ['class' => 'btn-sm'],
			'confirm' => 'Are you sure to delete this message?',
			'flash-message' => 'Message deleted successfully',
			'selector' => '#reply-' . $this->post('id', $this->messageId),
		]);
	}

}