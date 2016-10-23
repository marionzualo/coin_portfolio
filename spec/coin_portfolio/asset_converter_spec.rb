describe CoinPortfolio::AssetConverter do
  describe "#convert" do
    it "creates a list of assets from a list of transactions" do
      transaction_1 = CoinPortfolio::Transaction.new(amount: 2, native_amount: 6, incoming: true)
      transaction_2 = CoinPortfolio::Transaction.new(amount: 2, native_amount: 8, incoming: true)
      transaction_3 = CoinPortfolio::Transaction.new(amount: 1, native_amount: 5, incoming: false)
      transaction_4 = CoinPortfolio::Transaction.new(amount: 2, native_amount: 9, incoming: false)
      transaction_5 = CoinPortfolio::Transaction.new(amount: 2, native_amount: 7, incoming: true)
      transactions = [transaction_1, transaction_2, transaction_3, transaction_4, transaction_5]

      assets = described_class.new(transactions).convert

      expect(assets.size).to eq(2)

      asset_1 = assets[0]
      expect(asset_1.amount).to eq(1)
      expect(asset_1.price).to eq(4)

      asset_2 = assets[1]
      expect(asset_2.amount).to eq(2)
      expect(asset_2.price).to eq(3.5)
    end
  end
end
