describe FrbParticipants::InstitutionName do
  describe ".find_by_frb_name" do
    context "frb name mapping exists" do
      subject { described_class.find_by_frb_name("BANK AND TRUST COMPANY") }

      its(:normalized_name) { is_expected.to eq("Bank & Trust Company") }
    end

    context "frb name mapping doesn't exist" do
      subject { described_class.find_by_frb_name("BANK OF TEST") }

      it { is_expected.to be_nil }
    end
  end
end
