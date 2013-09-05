require "spec_helper"

describe OfficeDepot::InventoryCheck::Address do
  it { should respond_to :title }
  it { should respond_to :address }
  it { should respond_to :address2 }
  it { should respond_to :city }
  it { should respond_to :state }
  it { should respond_to :zip }
  it { should respond_to :country }
  it { should respond_to :contact }

  describe "#initialize" do
    it "assigns attributes" do
      address = OfficeDepot::InventoryCheck::Address.new(
        title:   "Doejo HQ",
        address: "3128 N Broadway",
        city:    "Chicago",
        state:   "IL",
        zip:     "60657",
        country: "United States"
      )

      expect(address.title).to eq "Doejo HQ"
      expect(address.address).to eq "3128 N Broadway"
      expect(address.city).to eq "Chicago"
      expect(address.state).to eq "IL"
      expect(address.zip).to eq "60657"
      expect(address.country).to eq "United States"
    end
  end

  describe "#to_hash" do
    let(:address) do
      OfficeDepot::InventoryCheck::Address.new(
        title:   "Doejo HQ",
        address: "3128 N Broadway",
        city:    "Chicago",
        state:   "IL",
        zip:     "60657",
        country: "United States",
        contact: "John Doe"
      )
    end

    let(:hash) { address.to_hash }

    it "sets attributes" do
      expect(hash["id"]).not_to be_nil
      expect(hash["Name"]).not_to be_nil
      expect(hash["PostalAddress"]).not_to be_nil
      expect(hash["Contact"]).not_to be_nil
    end

    it "includes address id" do
      expect(hash["id"]).to eq "TEST ORDER"
    end

    it "includes address name" do
      expect(hash["Name"]).to eq ["Doejo HQ"]
    end

    it "includes contact" do
      expect(hash["Contact"]).to eq [{"Name" => ["John Doe"]}]
    end

    it "includes postal address" do
      expect(hash["PostalAddress"]).to be_an Array

      addr = hash["PostalAddress"][0]

      expect(addr["Address1"]).to eq ["3128 N Broadway"]
      expect(addr["City"]).to eq ["Chicago"]
      expect(addr["State"]).to eq ["IL"]
      expect(addr["PostalCode"]).to eq ["60657"]
      expect(addr["Country"]).to eq ["United States"]
    end
  end
end