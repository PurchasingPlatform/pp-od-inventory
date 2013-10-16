require "spec_helper"

describe OfficeDepot::InventoryCheck::Client do
  it "has a production endpoint" do
    expect(OfficeDepot::InventoryCheck::Client::API_ENDPOINT).to eq "https://b2b.officedepot.com"
  end

  describe "#send_request" do
    let(:client) do
      OfficeDepot::InventoryCheck::Client.new
    end

    let(:credential) do
      OfficeDepot::InventoryCheck::Credential.new(
        username: "foo",
        password: "bar"
      )
    end

    let(:address) do
      OfficeDepot::InventoryCheck::Address.new(
        title:   "Doejo HQ",
        address: "3128 N Broadway",
        city:    "Chicago",
        state:   "IL",
        zip:     "60657",
        country: "United States"
      )
    end

    let(:item) do
      OfficeDepot::InventoryCheck::RequestItem.new(
        line_number: 1,
        sku: "123456",
        quantity: 1,
        unit_price: 10.00,
        unit_of_measure: "EA"
      )
    end

    let(:request) do
      OfficeDepot::InventoryCheck::Request.new(
        payload_id: "TEST",
        credential: credential,
        address: address,
        items: [item]
      )
    end

    let(:response) do
      client.send_request(request)
    end

    it "requires a request instance as argument" do
      expect { client.send_request(nil) }.to raise_error ArgumentError, "Request instance required"
      expect { client.send_request(request) }.not_to raise_error ArgumentError
    end

    context "request fails" do
      before do
        stub_request(:post, "https://b2b.officedepot.com/invoke/ODServices/odPriceAvailability").
          to_return(status: 400, body: "foobar")
      end

      it "raises error" do
        expect { client.send_request(request) }.
          to raise_error OfficeDepot::InventoryCheck::Error, "Request failed"
      end
    end

    context "request successful but not valid" do
      before do
        stub_request(:post, "https://b2b.officedepot.com/invoke/ODServices/odPriceAvailability").
          to_return(status: 200, body: fixture("success.xml"))
      end

      it "does not raise error" do
        expect { client.send_request(request) }.
          not_to raise_error OfficeDepot::InventoryCheck::Error
      end
    end

    context "invalid credential" do
      before do
        stub_request(:post, "https://b2b.officedepot.com/invoke/ODServices/odPriceAvailability").
          to_return(status: 200, body: fixture("invalid_credential.xml"))
      end

      it "returns response with credential error" do
        expect(response.success?).to eq false
        expect(response.has_errors?).to eq false
        expect(response.error_description).to match /We could not find information for user/
      end
    end

    context "invalid item" do
      before do
        stub_request(:post, "https://b2b.officedepot.com/invoke/ODServices/odPriceAvailability").
          to_return(status: 200, body: fixture("invalid_item.xml"))
      end

      it "returns response with invalid items" do
        expect(response.success?).to eq true
        expect(response.has_errors?).to eq true
      end
    end
  end
end