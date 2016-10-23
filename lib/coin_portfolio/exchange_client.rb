require "coinbase/wallet"

module CoinPortfolio
  class ExchangeClient
    def initialize(api_key:, api_secret:, client_factory: Coinbase::Wallet::Client)
      @api_key = api_key
      @api_secret = api_secret
      @client_factory = client_factory
    end

    def price
      sell_price = client.sell_price
      CoinPortfolio::Money.new(amount: BigDecimal.new(sell_price["amount"]), currency: sell_price["currency"])
    end

    def transactions
      transactions_from_client.map do |transaction|
        amount = transaction["amount"]
        money_amount = CoinPortfolio::Money.new(amount: BigDecimal.new(amount["amount"]).abs, currency: amount["currency"])

        native_amount = transaction["native_amount"]
        money_native_amount = CoinPortfolio::Money.new(amount: BigDecimal.new(native_amount["amount"]).abs, currency: native_amount["currency"])

        incoming = amount["amount"][0] != "-"

        CoinPortfolio::Transaction.new(amount: money_amount, native_amount: money_native_amount, incoming: incoming)
      end
    end

    private

    attr_reader :api_key, :api_secret, :client_factory

    def transactions_from_client
      client.transactions(account_id, fetch_all: true)
    end

    def account_id
      client.primary_account["id"]
    end

    def client
      @client = client_factory.new(api_key: api_key, api_secret: api_secret)
    end
  end
end
