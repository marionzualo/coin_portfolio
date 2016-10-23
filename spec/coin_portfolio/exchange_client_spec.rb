describe CoinPortfolio::ExchangeClient do
  describe "#transactions" do
    it "returns the primary account's transactions" do
      tx_1 = build_client_transaction(native_amount: "-6", native_currency: "EUR", amount: "-2", currency: "BTC")
      tx_2 = build_client_transaction(native_amount: "4", native_currency: "EUR", amount: "1", currency: "BTC")
      transactions = [tx_1, tx_2]
      account = { "id" => "1" }
      client = double("client", primary_account: account)
      allow(client).to receive(:transactions).with("1", fetch_all: true).and_return(transactions)
      client_factory = double("client_factory", new: client)

      result_txs = described_class.new(api_key: "key", api_secret: "secret", client_factory: client_factory).transactions

      expect(result_txs.size).to eq(2)

      result_tx1 = result_txs[0]
      expect(result_tx1).to_not be_incoming
      amount_tx1 = CoinPortfolio::Money.new(amount: 2, currency: "BTC")
      expect(result_tx1.amount).to eq(amount_tx1)
      native_amount_tx1 = CoinPortfolio::Money.new(amount: 6, currency: "EUR")
      expect(result_tx1.native_amount).to eq(native_amount_tx1)

      result_tx2 = result_txs[1]
      expect(result_tx2).to be_incoming
      amount_tx2 = CoinPortfolio::Money.new(amount: 1, currency: "BTC")
      expect(result_tx2.amount).to eq(amount_tx2)
      native_amount_tx2 = CoinPortfolio::Money.new(amount: 4, currency: "EUR")
      expect(result_tx2.native_amount).to eq(native_amount_tx2)
    end
  end
  describe "#price" do
    it "returns the current sell price of the primary account's coin" do
      sell_price = { "amount" => "2.12", "currency" => "EUR" }
      client = double("client", sell_price: sell_price)
      client_factory = double("client_factory", new: client)

      price = described_class.new(api_key: "key", api_secret: "secret", client_factory: client_factory).price

      expect(price.amount).to eq(2.12)
      expect(price.currency).to eq("EUR")
    end
  end
  def build_client_transaction(native_amount:, native_currency:, amount:, currency:)
    {
      "amount" => { "amount" => amount, "currency" => currency },
      "native_amount" => { "amount" => native_amount, "currency" => native_currency }
    }
  end
end
