describe CoinPortfolio::Liquidation do
  describe "#details" do
    it "calculates the gains based on the inventory items" do
      item_1 = build_item(quantity: 2, cost_amount: 3, cost_currency: "EUR")
      item_2 = build_item(quantity: 1, cost_amount: 6, cost_currency: "EUR")
      inventory_items = [item_1, item_2]
      price = CoinPortfolio::Money.new(amount: 30, currency: "EUR")

      details = described_class.new(inventory_items).details(price)

      expect(details.initial_native_amount).to eq(CoinPortfolio::Money.new(amount: 12, currency: "EUR"))
      expect(details.final_native_amount).to eq(CoinPortfolio::Money.new(amount: 90, currency: "EUR"))
      expect(details.gain_percentage).to eq(6.5)
    end
  end

  def build_item(quantity:, cost_amount:, cost_currency:)
    cost = CoinPortfolio::Money.new(amount: cost_amount, currency: cost_currency)
    CoinPortfolio::InventoryItem.new(quantity: quantity, cost: cost)
  end
end
