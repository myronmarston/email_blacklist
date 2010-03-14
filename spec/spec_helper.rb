require 'rubygems'
require 'email_blacklist'
require 'spec'
require 'spec/autorun'

ActionMailer::Base.delivery_method = :test

Spec::Runner.configure do |config|
  
end
