
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cloud/instancetype/version"

Gem::Specification.new do |spec|
  spec.name          = "cloud-instancetype"
  spec.version       = Cloud::InstanceType::VERSION
  spec.authors       = ["James Mason"]
  spec.email         = ["jmason@suse.com"]
  spec.license       = "GPL-3.0-only"
  spec.summary       = %q{Describe public cloud instance types}
  spec.homepage      = "https://github.com/suse-enceladus/rubygem-cloud-instancetype"

  git_tracked_files = `git ls-files -z`.split("\x0")
  gem_ignored_files = `git ls-files -i -X .gemignore -z`.split("\x0")
  spec.files = git_tracked_files - gem_ignored_files
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "pry", "~> 0.12"
end
