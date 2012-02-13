# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rc/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ian Leitch"]
  gem.email         = ["port001@gmail.com"]
  gem.description   = %q{Command line tool for managing Rackspace Cloud Servers.}
  gem.summary       = %q{Command line tool for managing Rackspace Cloud Servers.}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rc"
  gem.require_paths = ["lib"]
  gem.version       = Rc::VERSION
end
