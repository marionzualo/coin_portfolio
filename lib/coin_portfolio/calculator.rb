module CoinPortfolio
  class Calculator
    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def potential_returns
      liquidation = Liquidation.new(assets)
      liquidation.details(price)
    end

    private

    attr_reader :api_key, :api_secret

    def assets
      AssetConverter.new(transactions).convert
    end

    def transactions
      client.transactions
    end

    def price
      client.price
    end

    def client
      @client ||= ExchangeClient.new(api_key: api_key, api_secret: api_secret)
    end
  end
end
