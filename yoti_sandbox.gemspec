lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'yoti_sandbox'
  spec.version       = '1.3.0'
  spec.authors       = ['Yoti']
  spec.email         = ['websdk@yoti.com']

  spec.summary       = 'Yoti Ruby Sandbox SDK for back-end integration.'
  spec.description = <<-DESC
    This gem contains the tools you need to test your Ruby back-end
    integration.
  DESC

  spec.homepage      = 'https://github.com/getyoti/yoti-ruby-sdk-sandbox'
  spec.license       = 'MIT'

  exclude_patterns = [
    '^(test|spec|features|examples|docs|.github)/',
    '^.gitignore$',
    '^.pre-commit-config.yaml$',
    '^sonar-project.properties$',
    '^.dependabot/config.yml$',
    '^.travis.yml$',
    '^CONTRIBUTING.md$',
    '^Guardfile$',
    '^Rakefile$',
    '^yardstick.yml$',
    '^rubocop.yml$'
  ]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/#{exclude_patterns.join('|')}/) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  spec.add_dependency 'yoti', '~> 1.7'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'webmock', '~> 3.3'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'yardstick', '~> 0.9'
end
