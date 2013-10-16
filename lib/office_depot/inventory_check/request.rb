module OfficeDepot
  module InventoryCheck
    class Request
      attr_reader :timestamp,
                  :payload_id,
                  :credential,
                  :address,
                  :items

      def initialize(options={})
        @timestamp  = options[:timestamp]
        @payload_id = options[:payload_id]
        @credential = options[:credential]
        @address    = options[:address]
        @items      = options[:items]
      end

      def to_hash
        hash = {
          "ODPriceAvailability" => {
            "version"   => "1.2.011",
            "xml:lang"  => "en_US",
            "payloadID" => payload_id,
            "timestamp" => timestamp,
            "Header"    => [header_hash],
            "Request"   => [request_hash]
          }
        }
      end

      def to_cxml
        xml_options = {
          "RootName"       => nil, 
          "XmlDeclaration" => true, 
          "KeepRoot"       => false
        }

        XmlSimple.xml_out(to_hash, xml_options).strip
      end

      private

      def header_hash
        {
          "Username" => [credential.username],
          "Password" => [credential.password],
          "ShipTo"   => [{ "Addr" => [address.to_hash] }],
          "BillTo"   => [{ "Addr" => [""] }]
        }
      end

      def request_hash
        {
          "deploymentMode" => "production",
          "RequestItem"    => items.map(&:to_hash)
        }
      end
    end
  end
end