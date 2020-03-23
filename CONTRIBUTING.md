# Contributing

After checking out the repo, run `bundle install` to install dependencies. Then, run `bundle exec rake spec` to run the tests. To install this gem onto your local machine, run `bundle exec rake install`.

You can use [Guard][] to automatically run the tests every time a file in the `lib` or `spec` folder changes.

Run Guard through Bundler with:

```shell
bundle exec guard
```

[Guard]: https://github.com/guard/guard

## Code coverage

The 100% code coverage requirement must be met before submitting new code.
This can be checked by opening the generated [SimpleCov][] files:

 ```shell
open coverage/index.html
 ```

## Style guide

The Ruby style guide is configured in the [rubocop.yml](rubocop.yml) file and can be checked by running:

```shell
bundle exec rake rubocop
```
