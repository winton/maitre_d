require File.expand_path('../../gems', __FILE__)

MaitreD::Gems.activate %w(sinatra)

require File.dirname(__FILE__) + '/application'
require File.dirname(__FILE__) + '/sinatra'
require File.dirname(__FILE__) + '/model'