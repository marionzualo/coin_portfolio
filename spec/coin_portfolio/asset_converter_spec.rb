describe CoinPortfolio::AssetConverter do
  describe "#convert" do
    it "creates a list of assets from a list of transactions" do
      transaction = CoinPortfolio::Transaction.new(amount: 2, native_amount: 6, incoming: true)
      transactions = [transaction]

      assets = described_class.new(transactions).convert

      asset = assets.first

      expect(asset.amount).to eq(2)
      expect(asset.price).to eq(3)
    end
  end
end
