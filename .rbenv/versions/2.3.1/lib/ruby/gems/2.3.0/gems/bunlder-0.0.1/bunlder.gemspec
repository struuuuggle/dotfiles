# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bunlder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Benjamin Smith"]
  gem.email         = ["benjamin.lee.smith@gmail.com"]
  gem.description   = %q{this is not the gem you're looking for}
  gem.summary       = %q{this is not the gem you're looking for}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bunlder"
  gem.require_paths = ["lib"]
  gem.version       = Bunlder::VERSION
end
