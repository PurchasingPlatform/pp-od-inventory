require "spec_helper"

describe OfficeDepot::InventoryCheck::Response do
  let(:klass) { OfficeDepot::InventoryCheck::Response }

  describe "#initialize" do
    it "raises error on invalid xml" do
      data = "not an xml content"
      expect { klass.new(data) }.to raise_error OfficeDepot::InventoryCheck::Error
    end
  end

  describe "on invalid authentication credential" do
    let(:data)     { fixture("invalid_credential.xml") }
    let(:response) { klass.new(data) }

    it "has an error" do
      expect(response.error).to eq true
      expect(response.error_code).to eq "01"
      expect(response.error_description).to match /we could not find information for user/i
    end

    it "does not have items" do
      expect(response.items).to be_an Array
      expect(response.items.size).to eq 0
    end
  end

  describe "on successful xml response" do
    let(:data)     { fixture("success.xml") }
    let(:response) { klass.new(data) }

    it "does not have a error" do
      expect(response.error).to eq false
      expect(response.error_code).to eq nil
      expect(response.error_description).to eq nil
    end

    it "assigns response items" do
      expect(response.items).to be_an Array
      expect(response.items.size).to eq 1
    end

    it "assigns item attributes" do
      item = response.items.first

      expect(item.line_number).to eq 1
      expect(item.sku).to eq "930784"
      expect(item.valid).to eq true
      expect(item.quantity).to eq 1
      expect(item.quantity_available).to eq true
      expect(item.quantity_left).to eq 13
      expect(item.error_code).to eq "00"
      expect(item.error_description).to eq "none"
    end

    it "does not have invalid items" do
      expect(response.invalid_items).to be_empty
    end

    describe "#success?" do
      it "returns true" do
        expect(response.success?).to eq true
      end
    end

    describe "#has_errors?" do
      it "returns false" do
        expect(response.has_errors?).to eq false
      end
    end
  end

  describe "on invalid item response" do
    let(:data)     { fixture("invalid_item.xml") }
    let(:response) { klass.new(data) }

    it "does not have an error" do
      expect(response.error).to eq false
    end

    it "assigns items" do
      expect(response.items.size).to eq 1
    end

    it "assigns item error" do
      item = response.items.first

      expect(item.valid).to eq false
      expect(item.error_code).to eq "02"
      expect(item.error_description).to match /The SKU number is not valid/
    end

    it "assigns item attributes" do
      item = response.items.first

      expect(item.quantity).to eq 1
      expect(item.quantity_left).to eq nil
      expect(item.quantity_available).to eq false
    end
  end

  describe "#invalid_items" do
    let(:data)     { fixture("response1.xml") }
    let(:response) { klass.new(data) }

    it "returns array of invalid items" do
      expect(response.invalid_items).to be_an Array
      expect(response.invalid_items.size).to eq 1
      expect(response.invalid_items.first.error_description).to match /is not available for purchase/i
    end
  end
end