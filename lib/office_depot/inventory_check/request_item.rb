module OfficeDepot
  module InventoryCheck
    class RequestItem
      attr_accessor :line_number, :sku, :quantity
      attr_accessor :unit_price, :unit_of_measure
      attr_accessor :description, :comments

      def initialize(options={})
        @line_number     = options[:line_number]
        @sku             = options[:sku]
        @quantity        = options[:quantity]
        @unit_price      = options[:unit_price]
        @unit_of_measure = options[:unit_of_measure]
        @description     = options[:description] || ""
        @comments        = options[:comments] || ""
      end

      def to_hash
        {
          "LineNumber"    => [line_number],
          "Sku"           => [sku],
          "Qty"           => [quantity],
          "UnitPrice"     => [unit_price],
          "UnitOfMeasure" => [unit_of_measure],
          "Description"   => [description],
          "Comments"      => [comments]
        }
      end
    end
  end
end