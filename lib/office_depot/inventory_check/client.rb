module OfficeDepot
  module InventoryCheck
    class Client
      API_ENDPOINT = "https://b2b.officedepot.com"

      def send_request(request)
        headers = {
          "Accept"       => "text/xml",
          "Content-Type" => "text/xml"
        }

        response = connection.post do |req|
          req.headers.merge!(headers)
          req.url "/invoke/ODServices/odPriceAvailability"
          req.body = request.to_cxml
        end
        
        OfficeDepot::InventoryCheck::Response.new(response.body)
      end

      private

      def connection
        Faraday.new(url: API_ENDPOINT, ssl: { version: "SSLv3" }) do |faraday|
          faraday.adapter(Faraday.default_adapter)
        end
      end
    end
  end
end