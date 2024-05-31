<?php
namespace Sy\Bootstrap\Component\Message\Received;

class DeleteForm extends \Sy\Bootstrap\Component\Form\Crud\Delete {

	public function __construct($messageId) {
		parent::__construct(
			'messageReceived',
			['id' => $messageId],
			[
				'button-attributes' => ['class' => 'btn-sm'],
				'confirm' => 'Are you sure to delete this message?',
				'flash-message' => 'Message deleted successfully',
				'selector' => '#message-' . $this->post('id', $messageId),
			]
		);
		$this->addClass('d-inline-block');
	}

}