<?php
namespace Sy\Bootstrap\Component\Message\Received;

class DeleteForm extends \Sy\Bootstrap\Component\Form\Crud\Delete {

	/**
	 * @var int
	 */
	private $messageId;

	/**
	 * @param int $messageId
	 */
	public function __construct($messageId) {
		parent::__construct('messageReceived', ['id' => $messageId]);
	}

	public function init() {
		$this->addClass('d-inline-block');

		$this->setOptions([
			'button-attributes' => ['class' => 'btn-sm'],
			'confirm' => 'Are you sure to delete this message?',
			'flash-message' => 'Message deleted successfully',
			'selector' => '#message-' . $this->post('id', $this->messageId),
		]);
	}

}