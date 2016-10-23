describe CoinPortfolio::Liquidation do
  describe "#details" do
    it "calculates the gains based on the assets" do
      asset_1 = build_asset(amount: 2, price_amount: 3, price_currency: "EUR")
      asset_2 = build_asset(amount: 1, price_amount: 6, price_currency: "EUR")
      assets = [asset_1, asset_2]
      price = CoinPortfolio::Money.new(amount: 30, currency: "EUR")

      details = described_class.new(assets).details(price)

      expect(details.initial_native_amount).to eq(CoinPortfolio::Money.new(amount: 12, currency: "EUR"))
      expect(details.final_native_amount).to eq(CoinPortfolio::Money.new(amount: 90, currency: "EUR"))
      expect(details.gain_percentage).to eq(6.5)
    end
  end

  def build_asset(amount:, price_amount:, price_currency:)
    price = CoinPortfolio::Money.new(amount: price_amount, currency: price_currency)
    CoinPortfolio::Asset.new(amount: amount, price: price)
  end
end
