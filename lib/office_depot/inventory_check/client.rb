module OfficeDepot
  module InventoryCheck
    class Client
      API_ENDPOINT = "https://b2b.officedepot.com"

      def send_request(request)
        if !request.kind_of?(OfficeDepot::InventoryCheck::Request)
          raise ArgumentError, "Request instance required"
        end

        response = make_api_call("/invoke/ODServices/odPriceAvailability", request)

        # Non-successful requests are usually when something wrong
        # with backend. Invalid credentials do not raise exceptions. It'll
        # only return error in response object.
        unless response.success?
          raise OfficeDepot::InventoryCheck::Error, "Request failed"
        end

        OfficeDepot::InventoryCheck::Response.new(response.body)
      end

      private

      def connection
        Faraday.new(url: API_ENDPOINT, ssl: { version: "TLSv1" }) do |faraday|
          faraday.adapter(Faraday.default_adapter)
        end
      end

      def make_api_call(path, request)
        headers = {
          "Accept"       => "text/xml",
          "Content-Type" => "text/xml"
        }

        connection.post do |req|
          req.headers.merge!(headers)
          req.url(path)
          req.body = request.to_cxml
        end
      end
    end
  end
end