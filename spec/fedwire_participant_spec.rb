describe FrbParticipants::FedwireParticipant do
  describe ".find_by_routing_number" do
    context "routing number exists" do
      subject { described_class.find_by_routing_number("325182946") }

      its(:customer_name) { is_expected.to eq("UMPQUA BANK") }
      its(:type) { is_expected.to eq(:wire) }
      its(:known_normalized_name) { is_expected.to be_nil }
    end

    context "routing number exists, and has known_normalized_name" do
      subject { described_class.find_by_routing_number("084202264") }

      its(:customer_name) { is_expected.to eq("BANKPLUS") }
      its(:known_normalized_name) { is_expected.to eq("BankPlus") }
    end

    context "routing number doesn't exist" do
      subject { described_class.find_by_routing_number("123123015") }

      it { is_expected.to be_nil }
    end
  end
end
