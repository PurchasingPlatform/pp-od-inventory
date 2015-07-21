module OfficeDepot
  module InventoryCheck
    class RequestItem
      attr_accessor :line_number,
                    :sku,
                    :quantity,
                    :unit_of_measure,
                    :description,
                    :comments

      def initialize(options={})
        @line_number     = options[:line_number]
        @sku             = options[:sku]
        @quantity        = options[:quantity]
        @unit_of_measure = options[:unit_of_measure]
        @description     = options[:description] || ""
        @comments        = options[:comments] || ""
      end

      def to_hash
        {
          "LineNumber"    => [line_number],
          "Sku"           => [sku],
          "Qty"           => [quantity],
          "UnitOfMeasure" => [unit_of_measure],
          "Description"   => [description],
          "Comments"      => [comments]
        }
      end
    end
  end
end