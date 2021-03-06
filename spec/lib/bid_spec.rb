require 'spec_helper'


RSpec.describe Bridge::Bid do
  subject(:bid) { described_class.new(rand(1..7), Bridge::Strain.all.sample) }

  describe "<=>" do
    it "is zero for identical bids" do
      expect(bid <=> bid).to eq 0
    end
    it "is greater than zero if the strain is higher" do
      expect(described_class.new(1, Bridge::Strain::Diamond) <=> described_class.new(1, Bridge::Strain::Club)).to be > 0
      expect(described_class.new(1, Bridge::Strain::NoTrump) <=> described_class.new(1, Bridge::Strain::Heart)).to be > 0
    end

    it "is less than zero if the strain is lower" do
      expect(described_class.new(1, Bridge::Strain::Club) <=> described_class.new(1, Bridge::Strain::Diamond)).to be < 0
      expect(described_class.new(1, Bridge::Strain::Heart) <=> described_class.new(1, Bridge::Strain::NoTrump)).to be < 0
    end

    it "is greater than zero if the level is higher" do
      expect(described_class.new(3, Bridge::Strain::Diamond) <=> described_class.new(1, Bridge::Strain::Club)).to be > 0
      expect(described_class.new(3, Bridge::Strain::NoTrump) <=> described_class.new(1, Bridge::Strain::Heart)).to be > 0
    end

    it "is less than zero if the level is lower" do
      expect(described_class.new(1, Bridge::Strain::Club) <=> described_class.new(2, Bridge::Strain::Club)).to be < 0
      expect(described_class.new(1, Bridge::Strain::Heart) <=> described_class.new(2, Bridge::Strain::Heart)).to be < 0
    end
  end

  describe "pass?" do
    it "is a pass if level and strain are nil" do
      expect(described_class.new(nil, nil).pass?).to be true
    end

    it "is not a pass if level or strain are not nil" do
      expect(described_class.new(1, nil).pass?).to be false
      expect(described_class.new(nil, Bridge::Strain::Club).pass?).to be false
      expect(described_class.new(1, Bridge::Strain::Club).pass?).to be false
    end
  end
end
