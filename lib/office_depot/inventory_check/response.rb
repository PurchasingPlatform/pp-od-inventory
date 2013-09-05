module OfficeDepot
  module InventoryCheck
    class Response
      attr_reader :error, :error_code, :error_description
      attr_reader :items

      def initialize(data)
        @items = []

        hash = parse_xml(data)

        if hash["Error"]
          assign_error(hash["Error"][0])
        else
          assign_items(hash)
        end
      end

      def success?
        @error == false
      end

      def has_errors?
        @has_errors == true
      end

      def invalid_items
        @items.select { |item| item.valid == false }
      end

      private

      def parse_xml(data)
        XmlSimple.xml_in(data)
      rescue Exception => err
        raise OfficeDepot::InventoryCheck::Error, err.message
      end

      def assign_error(data)
        @error             = true
        @error_code        = data["ErrCode"][0]
        @error_description = data["ErrDescription"][0]
      end

      def assign_items(data)
        @error = false

        build_items(data)
        check_for_errors
      end

      def build_items(data)
        data["Response"][0]["ResponseItem"].map do |chunk|
          @items << build_item(chunk)
        end
      end

      def check_for_errors
        @has_errors = invalid_items.size > 0
      end

      def build_item(data)
        OfficeDepot::InventoryCheck::ResponseItem.build(data)
      end
    end
  end
end