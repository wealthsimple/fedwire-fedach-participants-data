describe FrbParticipants::FedachParticipant do
  describe ".find_by_routing_number" do
    context "routing number exists" do
      subject { described_class.find_by_routing_number("011000015") }

      its(:customer_name) { is_expected.to eq("FEDERAL RESERVE BANK") }
      its(:type) { is_expected.to eq(:ach) }
      its(:known_normalized_name) { is_expected.to be_nil }
    end

    context "routing number exists, and has known_normalized_name" do
      subject { described_class.find_by_routing_number("075909204") }

      its(:customer_name) { is_expected.to eq("BANK OF PRAIRIE DU SAC") }
      its(:known_normalized_name) { is_expected.to eq("Bank of Prairie du Sac") }
    end

    context "routing number doesn't exist" do
      subject { described_class.find_by_routing_number("123123015") }

      it { is_expected.to be_nil }
    end
  end
end
