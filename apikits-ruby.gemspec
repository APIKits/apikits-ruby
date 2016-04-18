require "./lib/api_kits/version"

Gem::Specification.new do |spec|

  spec.name         = 'apikits-ruby'
  spec.version      = ApiKits::Version::Compact
  spec.summary      = ApiKits::Version::Summary
  spec.description  = ApiKits::Version::Description

  spec.license      = 'MIT'
  spec.author       = "Jurgen Jocubeit"
  spec.email        = "support@apikits.com"
  spec.homepage     = "https://github.com/APIKits/apikits-ruby"

  spec.files        = `git ls-files`.split("\n")
  spec.test_files   = `git ls-files -- {test,spec,features,examples,gemfiles}/*`.split("\n")
  spec.executables  = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_path = 'lib'

  spec.platform     = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2.0'
  spec.rdoc_options.concat ['--encoding', 'UTF-8']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coveralls'

  spec.add_runtime_dependency 'activemodel'
  spec.add_runtime_dependency 'json_pure'

end
