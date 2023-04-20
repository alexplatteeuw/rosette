# Rosette

Rosette is a Ruby on Rails engine that helps you add missing translations to your application. 

If your main app is configured to raise on missing translations, Rosette will catch any `I18n::MissingTranslationData` error and display a form to add the missing translations. 

The form includes an input for each available locale set by `config.i18n.available_locales`.

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

Whether you currently use or are interested in starting to use [i18n-task](https://github.com/glebm/i18n-tasks#normalize-data) to normalize your locales files, add this initializer:

```ruby
# config/initializers/rosette.rb

Rosette.normalize = true
```

## Preview

This is how you will be able to add your missing translations for each available locale set in `config/application.rb`:

<img src="https://raw.githubusercontent.com/alexplatteeuw/rosette/master/preview.png" width="545">


## CLI

This gem also provides a command line interface. Run `bundle exec rosette` to get the list of all the tasks:

<img src="https://raw.githubusercontent.com/alexplatteeuw/rosette/master/tasks.png" width="545">

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
