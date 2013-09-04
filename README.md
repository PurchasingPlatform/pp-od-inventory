# OfficeDepot::InventoryCheck

Module for checking Office Depot inventory status in real-time. 

Operates over cXML protocol.

## Install

Clone repository and install dependencies:

```
git clone git@gitslice.com:pp-od-inventory.git
cd pp-od-inventory
bundle install
```

##  Usage

Require gem:

```ruby
require "office_depot/inventory_check"
```

Setup shipping address:

```ruby
address = OfficeDepot::InventoryCheck::Address.new(
  title:   "Doejo HQ",
  address: "3128 N Broadway",
  city:    "Chicago",
  state:   "IL",
  zip:     "60657",
  country: "United States"
)
```

Setup request items:

```
items = []

items << OfficeDepot::InventoryCheck::RequestItem.new(
  line_number: 1,
  sku: "123456",
  quantity: 1,
  unit_price: 10.00,
  unit_of_measure: "EA"
)
```

Setup authentication:

```ruby
credential = OfficeDepot::InventoryCheck::Credential.new(
  username: "67028207-cxml",
  password: "Z2lFc7Enm2MUCHw6"
)
```

Setup request:

```ruby
request = OfficeDepot::InventoryCheck::Request.new(
  timestamp:  Time.now.iso8601,
  payload_id: "inventory.#{SecureRandom.hex(8)}@purchasingplatform.com",
  credential: credential,
  address:    address,
  items:      items
)
```

Make request:

```
client = OfficeDepot::InventoryCheck::Client.new
response = client.send_request(request)
```

Response:

```
#<OfficeDepot::InventoryCheck::Response:0x007ff5cc2622c0
 @error=false,
 @has_errors=true,
 @items=
  [#<OfficeDepot::InventoryCheck::ResponseItem:0x007ff5cc3c99d8
    @error_code={},
    @error_description={},
    @line_number=1,
    @quantity=1,
    @quantity_available=true,
    @quantity_left=nil,
    @sku="863173",
    @valid=true>,
   #<OfficeDepot::InventoryCheck::ResponseItem:0x007ff5cc3c97d0
    @error_code={},
    @error_description={},
    @line_number=2,
    @quantity=1,
    @quantity_available=true,
    @quantity_left=nil,
    @sku="706252",
    @valid=true>
  ]>
```