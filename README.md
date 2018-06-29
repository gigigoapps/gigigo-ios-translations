# GIGTranslations SDK

![Language](https://img.shields.io/badge/Language-Swift-orange.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Integration

For supporting translations from Gigigo in your app or library, you can integrate through the dependency manager Carthage as explained below.

### Using Carthage

Add the following line to your `Cartfile` to add GIGTranslations as a dependency for your project.

```
github "gigigoapps/gigigo-ios-translations" ~> 1.0
```

## Setup

The GIGTranslations SDK is based on `json` format way to translate the strings of your application. So, the first thing you have to do is configure your translations files. This files needs a flatted-json-format `key`: `value` in order to work properly. The name of file for each language have to be `[language-code].json`, i.e.
`en.json`. Then, add all your keys to this json file:

```json 
{
	"key_1": "value",
	"key_2": "other value"
}
```

Secondly, we have to create a configuration file indicating where is each language located. This configuration file should be uploaded to a server or any cloud service with public access (also the languages files, because the SDK is going to syncronize the information of all languages in each openinig in order to have the languages with the last changes). This configuration file needs the following format:

```json
{
	"default": "https://route/to/default.json",
	"en": "https://route/to/en.json"
}
```

**IMPORTANT:** Don't forget to add a `default` language file. This is going to be the language by default if the language set is not in the list of languages. 

### Optional

You can add now the language files (not the configuration) to your app bundle. This means that the SDK is going to retrieve the translations from there if there is no way to sync from network. If you don't add this files to your bundle, the SDK will request the translations to the usual way (`NSLocalizedString(...)`) if there isn't possibility to download the updated language files.

## SDK Usage

Once you have the language files configured and uploaded to any server, it's time to configure the SDK, the first thing is instantiate it, we have two ways to do it:

### Without knowing yet the configuration URL

```swift
Translations.setup(bundle: Bundle.main)
```

### Knowing the configuration URL

```swift
Translations.setup(
	configurationURL: URL(string: "https:/path/to/your/configuration.json")!, 
	bundle: Bundle.main
)
```

Secondly, and optionally, you can set the language that you want to be the main language of your app (if not, the SO language will be retrieved):

```swift
Translations.set(language: "en")
```

When you want to retrieve a translation for a specific key, you can use two methods:

```swift
let key = Translations.value(for: "key_1")
// or
let key = translate("key_1")
```


# Translations script

This script provide a easy way to download all your translation files resources. You just need to add the same configuration url provided to the SDK and it will download all languages and save it in the correct format. This script creates a `config.json` file with all configuration needed in order to improve it usage. 

## Install

`bash <(curl -s https://raw.githubusercontent.com/gigigoapps/gigigo-ios-translations/develop/scripts/install_translations_sync.sh)`

## Usage

```
>> translations-sync [configuration-url] [--iOS|--android|--universal] [--ios-strings-file]

- configuration-url: the configuration url (i.e. http://....index.json)
--universal: (default) download the translations files in 'json' format
--iOS: download the translations files in 'strings' format
--android: download the translations files in 'xml' format
--ios-strings-file: if you want to create a swift file with a constant for each translation
```

An example of usage could be:

```
>> translations-sync "http://.../index.json"
```

### iOS strings file

This option generates a swift file with a constant for each translation. This only works if the language file is a **json** type. With this file included in your project, you just need to call to `Strings.keyGenerated` to obtain the value of the translation. An example of file created is:

```swift
import Foundation
import GIGTranslations

struct Strings {
	static let homeLoginButton = translate("home_login_button")
	static let homeLogoutButton = translate("home_logout_button")
}

```

So, if you want to translate the `"home_login_button"` key, just call `Strings.homeLoginButton`.

