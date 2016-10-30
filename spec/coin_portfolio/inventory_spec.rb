describe CoinPortfolio::Inventory do
  describe "#build" do
    it "creates a list of inventory items from a list of transactions" do
      transaction_1 = build_transaction(amount: 2, currency: "BTC", native_amount: 6, native_currency: "EUR", incoming: true)
      transaction_2 = build_transaction(amount: 2, currency: "BTC", native_amount: 8, native_currency: "EUR", incoming: true)
      transaction_3 = build_transaction(amount: 1, currency: "BTC", native_amount: 5, native_currency: "EUR", incoming: false)
      transaction_4 = build_transaction(amount: 2, currency: "BTC", native_amount: 9, native_currency: "EUR", incoming: false)
      transaction_5 = build_transaction(amount: 2, currency: "BTC", native_amount: 7, native_currency: "EUR", incoming: true)
      transactions = [transaction_1, transaction_2, transaction_3, transaction_4, transaction_5]

      inventory_items = described_class.new(transactions).build

      expect(inventory_items.size).to eq(2)

      item_1 = inventory_items[0]
      expect(item_1.quantity).to eq(1)
      expect(item_1.cost).to eq(CoinPortfolio::Money.new(amount: 4, currency: "EUR"))

      item_2 = inventory_items[1]
      expect(item_2.quantity).to eq(2)
      expect(item_2.cost).to eq(CoinPortfolio::Money.new(amount: 3.5, currency: "EUR"))
    end
  end

  def build_transaction(amount:, currency:, native_amount:, native_currency:, incoming:)
    money_amount = CoinPortfolio::Money.new(amount: amount, currency: currency)
    money_native_amount = CoinPortfolio::Money.new(amount: native_amount, currency: native_currency)
    CoinPortfolio::Transaction.new(amount: money_amount, native_amount: money_native_amount, incoming: incoming)
  end
end
