module CoinPortfolio
  class Liquidation
    Details = ImmutableStruct.new(:portfolio_cost, :current_portfolio_value, :gains_percentage)
    def initialize(inventory_items)
      @inventory_items = inventory_items
    end

    def details(price)
      current_portfolio_value = current_portfolio_value(price)
      gains_percentage = (current_portfolio_value - portfolio_cost).to_f / portfolio_cost
      currency = price.currency

      attributes = {
        portfolio_cost: Money.new(amount: portfolio_cost, currency: currency),
        current_portfolio_value: Money.new(amount: current_portfolio_value, currency: currency),
        gains_percentage: gains_percentage
      }
      Details.new(attributes)
    end

    private

    def portfolio_cost
      inventory_items.reduce(0) do |sum, item|
        sum + (item.quantity * item.cost.amount)
      end
    end

    def current_portfolio_value(price)
      total_item_quantity * price.amount
    end

    def total_item_quantity
      inventory_items.reduce(0) do |sum, item|
        sum + item.quantity
      end
    end

    attr_reader :inventory_items
  end
end
