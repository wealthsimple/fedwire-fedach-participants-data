describe FrbParticipants::Participant do
  describe ".find_by_routing_number" do
    context "FedACH routing number exists" do
      subject { described_class.find_by_routing_number("011000015") }

      its(:customer_name) { is_expected.to eq("FEDERAL RESERVE BANK") }
      its(:type) { is_expected.to eq(:ach) }
    end

    context "FedWire routing number exists" do
      subject { described_class.find_by_routing_number("031101266") }

      its(:customer_name) { is_expected.to eq("TD BANK, NA") }
      its(:type) { is_expected.to eq(:wire) }
    end

    context "routing number doesn't exist" do
      subject { described_class.find_by_routing_number("123123015") }

      it { is_expected.to be_nil }
    end
  end
end
