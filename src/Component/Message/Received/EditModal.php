<?php
namespace Sy\Bootstrap\Component\Message\Received;

class EditModal extends \Sy\Component\WebComponent {

	public function __construct() {
		$this->mount(function () {
			$this->init();
		});
	}

	private function init() {
		$this->addTranslator(LANG_DIR . '/bootstrap-message');
		$this->setTemplateFile(__DIR__ . '/EditModal.html');
		$this->addJsCode(__DIR__ . '/EditModal.js');
		$this->setComponent('EDIT_FORM', new EditForm());
	}

}