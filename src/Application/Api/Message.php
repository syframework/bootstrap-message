<?php
namespace Sy\Bootstrap\Application\Api;

class Message extends \Sy\Bootstrap\Component\Api {

	public function security() {
		$service = \Project\Service\Container::getInstance();
		$user = $service->user->getCurrentUser();
		if ($user->isConnected()) return;
		throw new \Sy\Bootstrap\Component\Api\ForbiddenException($this->_('Session expired'));
	}

	public function create() {
		$form = new \Sy\Bootstrap\Component\Message\Received\AddForm($this->post('item_id'), $this->post('item_type'));
		$form->initialize();
		return $this->ok($form->submitAction());
	}

	public function update() {
		$form = new \Sy\Bootstrap\Component\Message\Received\EditForm();
		$form->initialize();
		return $this->ok($form->submitAction());
	}

	public function delete() {
		$service = \Project\Service\Container::getInstance();
		$user = $service->user->getCurrentUser();
		$message = $service->messageReceived->retrieve(['id' => $this->post('message_id')]);
		if (!$user->hasPermission('message-delete') and $user->id !== $message['user_id']) {
			return $this->forbidden('Delete not permitted');
		}
		$form = new \Sy\Bootstrap\Component\Message\Received\DeleteForm($this->post('message_id'));
		$form->initialize();
		return $this->ok($form->submitAction());
	}

	public function createReply() {
		$form = new \Sy\Bootstrap\Component\Message\Reply\AddForm($this->post('message_id'));
		$form->initialize();
		return $this->ok($form->submitAction());
	}

	public function deleteReply() {
		$service = \Project\Service\Container::getInstance();
		$user = $service->user->getCurrentUser();
		$message = $service->messageReply->retrieve(['id' => $this->post('message_id')]);
		if (!$user->hasPermission('message-delete') and $user->id !== $message['user_id']) {
			return $this->forbidden('Delete not permitted');
		}
		$form = new \Sy\Bootstrap\Component\Message\Reply\DeleteForm($this->post('message_id'));
		$form->initialize();
		return $this->ok($form->submitAction());
	}

}