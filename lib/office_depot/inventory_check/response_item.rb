module OfficeDepot
  module InventoryCheck
    class ResponseItem
      attr_reader :line_number, :sku, :valid
      attr_reader :quantity, :quantity_available, :quantity_left
      attr_reader :error_code, :error_description

      def initialize(options={})
        @line_number        = options[:line_number]
        @sku                = options[:sku]
        @quantity           = options[:quantity]
        @quantity_available = options[:quantity_available]
        @quantity_left      = options[:quantity_left]
        @error_code         = options[:error_code]
        @error_description  = options[:error_description]
        @valid              = options[:valid]

        if @error_code == {}
          @error_code = nil
        end

        if @error_description.kind_of?(String)
          @error_description = @error_description.gsub(/[\s]{2,}/, " ")
        else
          @error_description = nil
        end
      end

      def to_hash
        attrs = [
          :line_number, :sku, :valid, :quantity, :quantity_available, :quantity_left,
          :error_code, :error_description
        ]

        result = {}
        attrs.each do |name|
          result[name] = self.send(name)
        end

        result
      end

      def self.build(data)
        qty_left = nil
        qty_available = false

        if data["QtyAvail"][0] =~ /^[\d]+$/
          qty_left = Integer(data["QtyAvail"][0])
          qty_available = true
        else
          qty_available = data["QtyAvail"][0] == "true"
        end

        OfficeDepot::InventoryCheck::ResponseItem.new(
          line_number:        Integer(data["LineNumber"][0]),
          sku:                data["Sku"][0],
          quantity:           Integer(data["QtyReq"][0]),
          quantity_left:      qty_left,
          quantity_available: qty_available,
          error_code:         data["ErrCode"][0],
          error_description:  data["ErrDescription"][0],
          valid:              (data["valid"] == "true")
        )
      end
    end
  end
end