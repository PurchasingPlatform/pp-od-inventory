describe OfficeDepot::InventoryCheck::Address do
  it { is_expected.to respond_to :title }
  it { is_expected.to respond_to :address }
  it { is_expected.to respond_to :address2 }
  it { is_expected.to respond_to :city }
  it { is_expected.to respond_to :state }
  it { is_expected.to respond_to :zip }
  it { is_expected.to respond_to :country }
  it { is_expected.to respond_to :contact }

  let(:address) do
    described_class.new(
      title:   "Doejo HQ",
      address: "3128 N Broadway",
      city:    "Chicago",
      state:   "IL",
      zip:     "60657",
      country: "United States",
      contact: "John Doe"
    )
  end

  describe "#initialize" do
    it "assigns attributes" do
      expect(address.title).to eq "Doejo HQ"
      expect(address.address).to eq "3128 N Broadway"
      expect(address.city).to eq "Chicago"
      expect(address.state).to eq "IL"
      expect(address.zip).to eq "60657"
      expect(address.country).to eq "United States"
    end
  end

  describe "#to_hash" do
    let(:hash) { address.to_hash }
    let(:addr) { hash["PostalAddress"][0] }

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
      expect(addr["Address1"]).to eq ["3128 N Broadway"]
      expect(addr["City"]).to eq ["Chicago"]
      expect(addr["State"]).to eq ["IL"]
      expect(addr["PostalCode"]).to eq ["60657"]
      expect(addr["Country"]).to eq ["United States"]
    end
  end
end