require "spec_helper"

describe OfficeDepot::InventoryCheck::Client do
  it "has a production endpoint" do
    url = OfficeDepot::InventoryCheck::Client::API_ENDPOINT
    expect(url).to eq "https://b2b.officedepot.com"
  end
end