<?php
namespace Sy\Bootstrap\Component\Message;

use Sy\Bootstrap\Component\Icon;
use Sy\Bootstrap\Component\Modal\Button;
use Sy\Bootstrap\Component\Modal\Dialog;

class Component extends \Sy\Component\WebComponent {

	private $itemId;

	private $itemType;

	public function __construct($itemId, $itemType) {
		parent::__construct();
		$this->itemId = $itemId;
		$this->itemType = $itemType;

		$this->setTemplateFile(__DIR__ . '/Component.html');
		$this->mount(function () {
			$this->init();
		});
	}

	private function init() {
		$this->addTranslator(LANG_DIR . '/bootstrap-message');

		// Add new message modal button
		$addNewMsgBtn = new Button(id: 'new-msg-modal', label: 'Add a new message', icon: 'pencil', color: 'primary', size: 'lg');

		$this->setVars([
			'FEED'            => new Received\Feed($this->itemId, $this->itemType),
			'ADD_NEW_MSG_BTN' => $addNewMsgBtn
		]);

		$service = \Project\Service\Container::getInstance();
		if ($service->user->getCurrentUser()->isConnected()) {
			$js = new \Sy\Component();
			$js->setTemplateFile(__DIR__ . '/Component.js');
			$js->setVar('FEED_URL', \Sy\Bootstrap\Lib\Url::build('api', 'feed', [
				'message_item_id'   => $this->itemId,
				'message_item_type' => $this->itemType,
				'last'        => 0,
				'class'       => '\Sy\Bootstrap\Component\Message\Received\Feed',
				'language'    => $service->lang->getLang(),
			]));
			$this->addJsCode($js);

			// Add form into the modal dialog
			$addNewMsgBtn->getDialog()->setBody(new Received\AddForm($this->itemId, $this->itemType));

			// Edit message modal
			$editMsgDialog = new Dialog(
				id: 'edit-msg-modal',
				title: strval(new Icon('pencil')) . ' ' . $this->_('Edit message'),
				body: new Received\EditForm()
			);
			$this->setVar('EDIT_MSG_MODAL', $editMsgDialog);
		} else {
			$addNewMsgBtn->getDialog()->setBody(new Received\AddFormAlt($this->itemId, $this->itemType));
		}

		// Hack for the first message creation
		$this->setComponent('SHARE_BTN', new \Sy\Bootstrap\Component\Share\Button('Share'));
	}

}