require "office_depot/inventory_check"
require "pp"

address = OfficeDepot::InventoryCheck::Address.new(
  title:   "Doejo HQ",
  address: "3128 N Broadway",
  city:    "Chicago",
  state:   "IL",
  zip:     "60657",
  country: "United States"
)

item = OfficeDepot::InventoryCheck::RequestItem.new(
  line_number: 1,
  sku: "896002",
  quantity: 1,
  unit_price: 10.00,
  unit_of_measure: "EA"
)

credential = OfficeDepot::InventoryCheck::Credential.new(
  username: "67028207-cxml",
  password: "Z2lFc7Enm2MUCHw6"
)

request = OfficeDepot::InventoryCheck::Request.new(
  timestamp:  Time.now.iso8601,
  payload_id: "inventory.#{SecureRandom.hex(8)}@purchasingplatform.com",
  credential: credential,
  address:    address,
  items:      [item]
)

client   = OfficeDepot::InventoryCheck::Client.new
response = client.send_request(request)

pp response