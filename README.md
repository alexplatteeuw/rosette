# Rosette

Rosette is a Ruby on Rails engine that helps you add missing translations to your application. If your main app is configured to raise on missing translations, Rosette will catch any `I18n::MissingTranslationData` error and display a form to add the missing translations. The form includes an input for each available locale set by `config.i18n.available_locales`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rosette"
```

And then execute:
```bash
$ bundle
```

Make sure your app raises error for missing translations in development:

```ruby
# config/environments/development.rb

config.i18n.raise_on_missing_translations = true
```

and that you explicitly set the available locales:

```ruby
# config/application.rb

config.i18n.available_locales = [:fr, :en]
```

Whether you currently use or are interested in starting to use [i18n-task to normalize](https://github.com/glebm/i18n-tasks#normalize-data) your locales files, add this initializer:

```ruby
# config/initializers/rosette.rb

Rosette.normalize = true
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
