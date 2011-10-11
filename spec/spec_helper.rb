require "pp"
require "bundler"

Bundler.require(:development)
require "rack/test"

$root = File.expand_path('../../', __FILE__)

require "#{$root}/lib/maitre_d"