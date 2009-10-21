require 'rubygems'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'email_blacklist'
require 'spec'
require 'spec/autorun'

ActionMailer::Base.delivery_method = :test

Spec::Runner.configure do |config|
  
end
