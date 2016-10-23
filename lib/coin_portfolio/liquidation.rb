module CoinPortfolio
  class Liquidation
    Details = ImmutableStruct.new(:initial_native_amount, :final_native_amount, :gain_percentage)
    def initialize(assets)
      @assets = assets
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
      assets.reduce(0) do |sum, asset|
        sum + (asset.count * asset.price.amount)
      end
    end

    def final_native_amount(price)
      total_asset_count * price.amount
    end

    def total_asset_count
      assets.reduce(0) do |sum, asset|
        sum + asset.count
      end
    end

    attr_reader :assets
  end
end
