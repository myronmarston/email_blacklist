require 'ginger'

def create_scenario(version)
  scenario = Ginger::Scenario.new("Rails #{version}")
  scenario[/^action_?mailer$/] = version
  scenario[/^action_?pack$/] = version
  scenario[/^active_?support$/] = version
  scenario
end

Ginger.configure do |config|
  config.aliases["action_mailer"] = "actionmailer"
  config.aliases["action_pack"] = "actionpack"
  config.aliases["active_support"] = "activesupport"

  %w(
  2.3.5 2.3.4 2.3.3 2.3.2
  2.2.3 2.2.2
  2.1.2 2.1.1 2.1.0
  2.0.5 2.0.4 2.0.2 2.0.1 2.0.0
  ).each do |version|
    config.scenarios << create_scenario(version)
  end

  rails126 = Ginger::Scenario.new("Rails 1.2.6")
  rails126[/^action_?mailer$/] = '1.3.6'
  rails126[/^action_?pack$/] = '1.13.6'
  rails126[/^active_?support$/] = '1.4.4'
  config.scenarios << rails126
end