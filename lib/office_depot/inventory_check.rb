require "securerandom"
require "faraday"
require "xmlsimple"
require "time"

module OfficeDepot
  module InventoryCheck
    class Error < StandardError ; end

    autoload :Address,      "office_depot/inventory_check/address"
    autoload :Client,       "office_depot/inventory_check/client"
    autoload :Credential,   "office_depot/inventory_check/credential"
    autoload :Request,      "office_depot/inventory_check/request"
    autoload :RequestItem,  "office_depot/inventory_check/request_item"
    autoload :Response,     "office_depot/inventory_check/response"
    autoload :ResponseItem, "office_depot/inventory_check/response_item"
  end
end