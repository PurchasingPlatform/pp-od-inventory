module OfficeDepot
  module InventoryCheck
    class Client
      API_ENDPOINTS = {
        test:       "https://b2bwmvendors.officedepot.com",
        production: "https://b2b.officedepot.com"
      }

      attr_reader :endpoint

      def initialize(env = :production)
        @endpoint = API_ENDPOINTS[env.to_sym] or raise "Bad environment"
      end

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
        Faraday.new(url: endpoint, ssl: { version: "TLSv1_2" }) do |faraday|
          faraday.adapter(Faraday.default_adapter)
          faraday.request :retry, max: 2, interval: 0.05, interval_randomness: 0.5, backoff_factor: 2, exceptions: ['Timeout::Error']
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
          req.options = {
            timeout:      80,
            open_timeout: 60
          }
        end
      end
    end
  end
end
