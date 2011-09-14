require 'pp'

$root = File.expand_path('../../', __FILE__)
require "#{$root}/lib/maitre_d/gems"

MaitreD::Gems.activate %w(rack-test rspec)

require 'rack/test'

require "#{$root}/lib/maitre_d"

Spec::Runner.configure do |config|
end