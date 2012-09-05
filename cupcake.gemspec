$:.push File.expand_path("../lib", __FILE__)
require "cupcake/version"

Gem::Specification.new do |s|
  s.name        = "cupcake"
  s.version     = Cupcake::VERSION
  s.authors     = ["Henry Garner"]
  s.email       = ["henry.garner@mac.com"]
  s.homepage    = "https://github.com/henrygarner/cupcake"
  s.summary     = %q{Script the MakerBot 3D Printer}
  s.description = %q{}

  s.rubyforge_project = "cupcake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "serialport"
  s.add_dependency "digest-crc", "~> 0.3.0"
end
