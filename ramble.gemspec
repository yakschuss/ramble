# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ramble/version"

Gem::Specification.new do |spec|
  spec.name = "ramble"
  spec.version = Ramble::VERSION
  spec.authors = ["Alex Stophel"]
  spec.email = ["alexstophel@gmail.com"]
  spec.summary = "Simple blogging based somewhat off of Jekyll."
  spec.homepage = "https://github.com/alexstophel/ramble"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "redcarpet"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
