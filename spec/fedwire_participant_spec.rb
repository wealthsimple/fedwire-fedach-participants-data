describe FrbParticipants::FedwireParticipant do
  describe ".find_by_routing_number" do
    context "routing number exists" do
      subject { described_class.find_by_routing_number("325182946") }

      its(:customer_name) { is_expected.to eq("UMPQUA BANK") }
      its(:type) { is_expected.to eq(:wire) }
    end

    context "routing number doesn't exist" do
      subject { described_class.find_by_routing_number("123123015") }

      it { is_expected.to be_nil }
    end
  end
end
