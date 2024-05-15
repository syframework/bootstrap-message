<?php
namespace Sy\Bootstrap\Component\Message\Reply;

class DeleteForm extends \Sy\Bootstrap\Component\Form {

	/**
	 * @var int
	 */
	private $messageId;

	public function __construct($messageId) {
		parent::__construct();
		$this->messageId = $messageId;
	}

	public function init() {
		$this->setAttributes([
			'class'            => 'reply-delete-form',
			'data-message-id'  => $this->messageId,
			'data-message-del' => $this->_('Are you sure to delete?'),
			'action'           => \Sy\Bootstrap\Lib\Url::build('api', 'message/deleteReply'),
		]);

		$this->addHidden(['name' => 'action', 'value' => 'delete']); // to catch action in Api
		$this->addHidden(['name' => 'message_id', 'value' => $this->messageId, 'required' => 'required']);

		// Crsf check
		$this->addCsrfField();

		$this->addButton(
			'',
			['type' => 'submit', 'title' => $this->_('Delete'), 'data-bs-title' => $this->_('Delete'), 'data-bs-container' => 'body'],
			['color' => 'danger', 'size' => 'sm', 'icon' => 'trash']
		);
	}

	public function submitAction() {
		$service = \Project\Service\Container::getInstance();
		$user = $service->user->getCurrentUser();
		try {
			$this->validatePost();
			$message = $service->messageReply->retrieve(['id' => $this->post('message_id')]);
			if (!$user->hasPermission('message-delete') and $user->id !== $message['user_id']) {
				return json_encode(['status' => 'ko', 'message' => $this->_('Delete not permitted')]);
			}
			$service->messageReply->delete(['id' => $this->messageId]);
			return json_encode(['status' => 'ok', 'message' => $this->_('Deleted successfully')]);
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