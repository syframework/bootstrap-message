<?php
namespace Sy\Bootstrap\Component\Message\Reply;

class DeleteForm extends \Sy\Bootstrap\Component\Form\Crud\Delete {

	public function __construct($messageId) {
		parent::__construct(
			'messageReply',
			['id' => $messageId],
			[
				'button-attributes' => ['class' => 'btn-sm'],
				'confirm' => 'Are you sure to delete this message?',
				'flash-message' => 'Message deleted successfully',
				'selector' => '#reply-' . $this->post('id', $messageId),
			]
		);
		$this->addClass('d-inline-block');
	}

}