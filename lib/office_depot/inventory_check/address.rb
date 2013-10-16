module OfficeDepot
  module InventoryCheck
    class Address
      attr_accessor :title,
                    :address,
                    :address2,
                    :city,
                    :state,
                    :zip,
                    :country,
                    :contact

      def initialize(options={})
        @title    = options[:title]
        @address  = options[:address]
        @address2 = options[:address2]
        @city     = options[:city]
        @state    = options[:state]
        @zip      = options[:zip]
        @country  = options[:country]
        @contact  = options[:contact]
      end

      def to_hash
        {
          "id" => "TEST ORDER",
          "Name" => [title],
          "PostalAddress" => [
            {
              "Address1"   => [address],
              "Address2"   => [address2],
              "City"       => [city],
              "State"      => [state],
              "PostalCode" => [zip],
              "Country"    => [country]
            }
          ],
          "Contact" => [
            {
              "Name" => [contact]
            }
          ]
        }
      end
    end
  end
end