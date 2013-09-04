module OfficeDepot
  module InventoryCheck
    class Response
      attr_reader :error, :error_code, :error_description
      attr_reader :items

      def initialize(data)
        hash = XmlSimple.xml_in(data)

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

      private

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
        @items = data["Response"][0]["ResponseItem"].map do |chunk|
          build_item(chunk)
        end
      end

      def check_for_errors
        @has_errors = @items.select { |item| item.valid == false }.size > 0
      end

      def build_item(data)
        OfficeDepot::InventoryCheck::ResponseItem.new(
          line_number:        Integer(data["LineNumber"][0]),
          sku:                data["Sku"][0],
          quantity:           Integer(data["QtyReq"][0]),
          quantity_left:      data["QtyAvail"][0] =~ /^[\d]+$/ ? Integer(data["QtyAvail"][0]) : nil,
          quantity_available: (data["QtyAvail"][0] == "true"),
          error_code:         data["ErrCode"][0],
          error_description:  data["ErrDescription"][0],
          valid:              (data["valid"] == "true")
        )
      end
    end
  end
end