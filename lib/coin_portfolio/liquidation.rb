module CoinPortfolio
  class Liquidation
    Details = ImmutableStruct.new(:initial_native_amount, :final_native_amount, :gain_percentage)
    def initialize(inventory_items)
      @inventory_items = inventory_items
    end

    def details(price)
      final_native_amount = final_native_amount(price)
      gain_percentage = (final_native_amount - initial_native_amount).to_f / initial_native_amount
      currency = price.currency

      attributes = {
        initial_native_amount: Money.new(amount: initial_native_amount, currency: currency),
        final_native_amount: Money.new(amount: final_native_amount, currency: currency),
        gain_percentage: gain_percentage
      }
      Details.new(attributes)
    end

    private

    def initial_native_amount
      inventory_items.reduce(0) do |sum, item|
        sum + (item.quantity * item.cost.amount)
      end
    end

    def final_native_amount(price)
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
