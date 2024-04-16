<?php
namespace Sy\Bootstrap\Component\Message\Reply;

class DeleteForm extends \Sy\Bootstrap\Component\Form {

	/**
	 * @var int
	 */
	private $messageId;

	public function __construct($messageId) {
		$this->messageId = $messageId;
		parent::__construct();
	}

	public function init() {
		parent::init();

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
		try {
			$this->validatePost();
			$service->messageReply->delete(['id' => $this->messageId]);
			return ['status' => 'ok', 'message' => $this->_('Deleted successfully')];
		} catch (\Sy\Bootstrap\Component\Form\CsrfException $e) {
			$this->logWarning($e);
			return ['status' => 'ko', 'message' => $e->getMessage(), 'csrf' => $service->user->getCsrfToken()];
		} catch (\Sy\Component\Html\Form\Exception $e) {
			$this->logWarning($e);
			return ['status' => 'ko', 'message' => is_null($this->getOption('error')) ? $this->_('Please fill the form correctly') : $this->getOption('error')];
		} catch (\Sy\Db\MySql\Exception $e) {
			$this->logWarning($e);
			return ['status' => 'ko', 'message' => $this->_('Error')];
		}
	}

}