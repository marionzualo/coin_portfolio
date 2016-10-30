module CoinPortfolio
  class Calculator
    def initialize(api_key:, api_secret:)
      @api_key = api_key
      @api_secret = api_secret
    end

    def potential_returns
      liquidation = Liquidation.new(inventory_items)
      details = liquidation.details(price)
      puts "Gains percentage: #{format_percentage(details.gains_percentage)}"
      puts "Portfolio cost: #{details.portfolio_cost}"
      puts "Current portfolio value: #{details.current_portfolio_value}"
      details
    end

    private

    attr_reader :api_key, :api_secret

    def format_percentage(percentage)
      rounded = (percentage * 100).round(2)
      "#{sprintf("%.2f", rounded)}%"
    end

    def inventory_items
      Inventory.new(transactions).build
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
