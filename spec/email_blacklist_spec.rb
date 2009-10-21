require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/mailers/test_mailer')

describe EmailBlacklist::Config do
  context 'when the blacklisted.org domain is blacklisted' do
    before(:all) do
      EmailBlacklist::Config.blacklist do |email_address|
        email_address =~ /blacklisted\.org/
      end
    end

    it 'should return true for #blacklisted?("bob@blacklisted.org")' do
      EmailBlacklist::Config.blacklisted?("bob@blacklisted.org").should == true
    end

    it 'should return false for #blacklisted?("bob@gmail.com")' do
      EmailBlacklist::Config.blacklisted?("bob@gmail.com").should == false
    end
  end

  context 'when no blacklist is defined' do
    before(:all) do
      EmailBlacklist::Config.blacklist # ensure it's nil...
    end

    it 'should return false for #blacklisted?("bob@blacklisted.org")' do
      EmailBlacklist::Config.blacklisted?("bob@blacklisted.org").should == false
    end

    it 'should return false for #blacklisted?("bob@gmail.com")' do
      EmailBlacklist::Config.blacklisted?("bob@gmail.com").should == false
    end
  end
end

describe ActionMailer do
  context 'when the blacklisted.org domain is blacklisted' do
    before(:all) do
      EmailBlacklist::Config.blacklist do |email_address|
        email_address =~ /blacklisted\.org/
      end
    end

    EmailBlacklist::ADDRESS_TYPES.each do |blacklisted_address_type|
      other_address_types = (EmailBlacklist::ADDRESS_TYPES - [blacklisted_address_type])
      context "sending an email with #{blacklisted_address_type} set to 'bob@blacklisted.org' and #{other_address_types.join(" and ")} set to 'valid_address@gmail.com'" do
        before(:all) do
          options = { blacklisted_address_type => 'bob@blacklisted.org' }
          other_address_types.each { |t| options[t] = 'valid_address@gmail.com' }
          @email = TestMailer.deliver_email(options)
        end

        it "should not deliver it to 'bob@blacklisted.org' for the #{blacklisted_address_type} address" do
          @email.send(blacklisted_address_type).should be_nil
        end

        other_address_types.each do |t|
          it "should deliver it to 'valid_address@gmail.com' for the #{t} address" do
            @email.send(t).should == ['valid_address@gmail.com']
          end
        end
      end
    end

    context "sending an email to just 'bob@blacklisted.org'" do
      before(:each) do
        ActionMailer::Base.deliveries.clear
        TestMailer.deliver_email({:to => 'bob@blacklisted.org'})
      end

      it "should not send the email at all" do
        ActionMailer::Base.deliveries.should == []
      end
    end
  end

  it "should not include the friendly name in the call to #blacklisted?" do
    EmailBlacklist::Config.should_receive(:blacklisted?).with('bob@blacklisted.org')
    TestMailer.deliver_email({:to => 'Bob <bob@blacklisted.org>'})
  end
end
