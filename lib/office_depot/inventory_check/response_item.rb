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
      end
    end
  end
end