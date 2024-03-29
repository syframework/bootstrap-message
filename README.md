# sy/bootstrap-message

[sy/bootstrap](https://github.com/syframework/bootstrap) plugin for adding "Message" feature in your [sy/project](https://github.com/syframework/project) based application.

## Installation

From your sy/project based application directory, run this command:

```bash
composer install-plugin message
```
---
**NOTES**

The install-plugin command will do all these following steps:

```bash
composer require sy/bootstrap-message
```

## Database

Use the database installation script: ```sql/install.sql```

## Language files

Copy the language folder ```lang/bootstrap-message``` into your project language directory: ```protected/lang```

## CSS

Copy the scss file ```scss/_bootstrap-message.scss``` into your project scss directory: ```protected/scss```

Import it in your ```app.scss``` file and rebuild the css file.

---