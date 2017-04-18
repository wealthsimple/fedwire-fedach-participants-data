describe FrbParticipants::Data do
  describe ".preload!" do
    subject { described_class.preload! }

    it { is_expected.to be_truthy }
  end

  describe ".load" do
    subject { described_class.load("plaid-institution-names.yml") }

    it { is_expected.to be_a(Hash) }
  end
end
