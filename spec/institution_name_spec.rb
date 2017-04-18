describe FrbParticipants::InstitutionName do
  describe ".find_by_frb_name" do
    context "frb name mapping exists (via Plaid)" do
      subject { described_class.find_by_frb_name("BANK AND TRUST COMPANY") }

      its(:known_normalized_name) { is_expected.to eq("Bank & Trust Company") }
    end

    context "frb name mapping exists (manually normalized)" do
      subject { described_class.find_by_frb_name("BANK OF AMERICA, N.A. - ARIZONA") }

      its(:known_normalized_name) { is_expected.to eq("Bank of America") }
    end

    context "frb name mapping doesn't exist" do
      subject { described_class.find_by_frb_name("U-HAUL FEDERAL CREDIT UNION") }

      its(:known_normalized_name) { is_expected.to be_nil }
      its(:best_attempt_normalized_name) { is_expected.to eq("U-Haul Federal Credit Union") }
    end
  end
end
