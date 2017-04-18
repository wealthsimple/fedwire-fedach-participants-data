describe FrbParticipants::FedachParticipant do
  describe ".find_by_routing_number" do
    context "routing number exists" do
      subject { described_class.find_by_routing_number("011000015") }

      its(:customer_name) { is_expected.to eq("FEDERAL RESERVE BANK") }
    end

    context "routing number doesn't exist" do
      subject { described_class.find_by_routing_number("123123015") }

      it { is_expected.to be_nil }
    end
  end
end
