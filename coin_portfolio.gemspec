# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coin_portfolio/version'

Gem::Specification.new do |spec|
  spec.name          = "coin_portfolio"
  spec.version       = CoinPortfolio::VERSION
  spec.authors       = ["Mário Nzualo"]
  spec.email         = ["mario.nzualo@gmail.com"]

  spec.summary       = %q{Calculate the gains/losses of the current crytocurrency portfolio}
  spec.description   = %q{Calculate the gains/losses of the current crytocurrency portfolio}
  spec.homepage      = "https://github.com/marionzualo/coin_portfolio"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_dependency "immutable-struct", "~> 2.2.2"
  spec.add_dependency "coinbase", "~> 4.1.0"
end
