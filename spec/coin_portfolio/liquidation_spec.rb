describe CoinPortfolio::Liquidation do
  describe "#details" do
    context "when there is a single incoming transaction" do
      it "calculates the gains/losses based on the single transaction" do
        transaction = double("transaction", amount: 2, native_amount: 6)
        price = 30

        details = described_class.new(transaction).details(price)

        expect(details.initial_native_amount).to eq(6)
        expect(details.final_native_amount).to eq(60)
        expect(details.gain_percentage).to eq(9)
      end
    end
  end
end
