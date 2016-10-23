describe CoinPortfolio::Liquidation do
  describe "#details" do
    it "calculates the gains based on the assets" do
      asset_1 = double("asset", amount: 2, price: 3)
      asset_2 = double("asset", amount: 1, price: 6)
      assets = [asset_1, asset_2]
      price = 30

      details = described_class.new(assets).details(price)

      expect(details.initial_native_amount).to eq(12)
      expect(details.final_native_amount).to eq(90)
      expect(details.gain_percentage).to eq(6.5)
    end
  end
end
