require "rubygems"
require "bundler"

Bundler.setup(:default)

$:.unshift File.dirname(__FILE__)

require 'maitre_d/application'
require 'maitre_d/core_ext'

require 'application/sinatra'
require 'application/log'
require 'application/session'
require 'application/haml'
require 'application/lilypad'
require 'application/redis'
require 'application/model'
require 'application/controller'
require 'application/helper'