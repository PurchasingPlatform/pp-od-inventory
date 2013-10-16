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

      # Returns true if request has been processed correctly
      def success?
        @error == false
      end

      # Returns true if any item in response is invalid
      def has_errors?
        @has_errors == true
      end

      # Returns a collection of invalid items (discontinued, etc)
      def invalid_items
        @items.select { |item| item.valid == false }
      end

      def to_hash
        {
          error: error,
          error_code: error_code,
          error_description: error_description,
          items: items.map(&:to_hash)
        }
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