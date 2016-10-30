# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coin_portfolio/version'

Gem::Specification.new do |spec|
  spec.name          = "coin_portfolio"
  spec.version       = CoinPortfolio::VERSION
  spec.authors       = ["Mário Nzualo"]
  spec.email         = ["mario.nzualo@gmail.com"]

  spec.summary       = %q{Calculate the gains/losses of the a crytocurrency portfolio}
  spec.homepage      = "https://github.com/marionzualo/coin_portfolio"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.licenses = %w(MIT)

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4", ">= 3.4.0"
  spec.add_dependency "immutable-struct", "~> 2.2", ">= 2.2.2"
  spec.add_dependency "coinbase", "~> 4.1", ">= 4.1.0"
  spec.add_dependency "money", "~> 6.7", ">= 6.7.1"
end
