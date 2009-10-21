require 'action_mailer'
require 'override'

module EmailBlacklist
  ADDRESS_TYPES = [:to, :cc, :bcc].freeze

  class Config
    class << self
      def blacklist(&blk)
        @@blacklist_block = blk
      end

      def blacklisted?(email_address)
        return false unless @@blacklist_block
        @@blacklist_block.call(email_address) ? true : false
      end
    end
  end
end

ActionMailer::Base.class_eval do
  override :deliver!
  def deliver!(mail = @mail)
    if mail
      all_addresses = []

      EmailBlacklist::ADDRESS_TYPES.each do |address_type|
        addresses = mail.send(address_type)
        addresses.reject! { |a| EmailBlacklist::Config.blacklisted?(a) } if addresses
        all_addresses << addresses
        mail.send("#{address_type}=", addresses)
      end

      return if all_addresses.flatten.compact.empty?
    end

    super(mail)
  end
end