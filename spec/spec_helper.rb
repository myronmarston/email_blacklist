require 'rubygems'
$LOAD_PATH << File.join(File.dirname(__FILE__), *%w[.. vendor ginger lib])
require 'ginger'
require 'email_blacklist'
require 'spec'
require 'spec/autorun'

ActionMailer::Base.delivery_method = :test

Spec::Runner.configure do |config|
  
end
