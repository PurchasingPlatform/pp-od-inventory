module OfficeDepot
  module InventoryCheck
    class Credential
      attr_accessor :username, :password

      def initialize(options={})
        @username = options[:username]
        @password = options[:password]
      end
    end
  end
end