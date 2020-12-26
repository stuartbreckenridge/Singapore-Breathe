#  Localization

Localization is handled by [SwiftGen](https://github.com/SwiftGen/SwiftGen).  

1. Add new strings that need to be localized to `Localizable.strings`
2. Run a build
3. Use the resultant `L10N.{variable}` in code.

There is a script in Build Phases that handles this _if_ SwiftGen is installed.
