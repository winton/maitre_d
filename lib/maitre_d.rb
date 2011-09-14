require File.dirname(__FILE__) + '/maitre_d/gems'

MaitreD::Gems.activate %w(haml lilypad sinatra)

$:.unshift File.dirname(__FILE__)

require 'maitre_d/boot/application'
require 'maitre_d/boot/sinatra'
require 'maitre_d/boot/log'
require 'maitre_d/boot/session'
require 'maitre_d/boot/haml'
require 'maitre_d/boot/lilypad'
require 'maitre_d/boot/redis'
require 'maitre_d/boot/controller'
require 'maitre_d/boot/helper'