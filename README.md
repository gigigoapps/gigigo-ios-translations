# Gigigo tranlations sdk

![Language](https://img.shields.io/badge/Language-Swift-orange.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Integrating

### Using Carthage

Add the following line to your `Cartfile` 

```
github "XXXXX/gigigo-translations-lib" ~> 1.0
```

## Set up

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


## Translations script

(WIP)