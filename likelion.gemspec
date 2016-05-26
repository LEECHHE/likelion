# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'likelion/version'

Gem::Specification.new do |spec|
  spec.name          = "likelion"
  spec.version       = Likelion::VERSION
  spec.authors       = ["ChangHee Lee"]
  spec.email         = ["leechhe90@gmail.com"]

  spec.summary       = %q{멋쟁이 사자처럼 수업 때 사용된 코드들을 쉽게 생성해줍니다.}
  spec.homepage      = "https://github.com/LEECHHE/likelion"
  spec.license       = ["MIT"]
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "devise"
  spec.add_dependency "fog-aws"
  spec.add_dependency "carrierwave"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
