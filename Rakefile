require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "email_blacklist"
    gem.summary = %Q{Ensure no emails are ever sent to particular email addresses.}
    gem.description = %Q{Blacklist particular email addresses so ActionMailer doesn't deliver emails to them.}
    gem.email = "myron.marston@gmail.com"
    gem.homepage = "http://github.com/myronmarston/email_blacklist"
    gem.authors = ["Myron Marston"]
    gem.add_dependency 'actionmailer', '>= 1.3.6'
    gem.add_development_dependency "rspec", ">= 1.2.9"

    gem.files.exclude 'vendor/ginger'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :ginger

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "email_blacklist #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Run ginger tests'
task :ginger do
  ENV['USE_GINGER'] = 'true'
  $LOAD_PATH << File.join(*%w[vendor ginger lib])
  ARGV.clear
  ARGV << 'spec'
  load File.join(*%w[vendor ginger bin ginger])
end