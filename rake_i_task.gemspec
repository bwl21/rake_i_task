# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake_i_task/version'

Gem::Specification.new do |spec|
  spec.name          = "rake_i_task"
  spec.version       = RakeITask::VERSION
  spec.authors       = ["Bernhard Weichel"]
  spec.email         = ["github.com@nospam.weichel21.de"]
  spec.description   = %q{This gem provided a rake taks named 'i' making rake interactive:

  usage: add the following line to your rake file

  require 'rake_i_task'

  rake i

  it opens a REPL shell with the following commands

  *help* - provide help
  *reke* - perform rake tasks
  *exit* - leave the hell

  It provides

  * TAB completion for the rake tasks
  * History even across sessions
  * pass unknown commands to the underlying operation system

}
  spec.summary       = %q{Interactive rake task}
  spec.homepage      = "https://github.com/bwl21/rake_i_task"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
