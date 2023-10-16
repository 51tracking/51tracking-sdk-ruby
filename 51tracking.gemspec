
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "51tracking"

Gem::Specification.new do |spec|
  spec.name          = "51tracking"
  spec.version       = Tracking51::VERSION
  spec.authors       = ["51tracking"]
  spec.email         = ["service@51tracking.org"]

  spec.summary       = "The Ruby SDK of 51Tracking API"
  spec.description   = "Developed for easy integration with 51Tracking"
  spec.homepage      = "https://www.51tracking.com/"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rspec", "~> 3.12"
end
