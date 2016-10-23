module CoinPortfolio
  class Liquidation
    Details = ImmutableStruct.new(:initial_native_amount, :final_native_amount, :gain_percentage)
    def initialize(assets)
      @assets = assets
    end

    def details(price)
      final_native_amount = final_native_amount(price)
      gain_percentage = (final_native_amount - initial_native_amount).to_f / initial_native_amount
      attributes = {
        initial_native_amount: initial_native_amount,
        final_native_amount: final_native_amount,
        gain_percentage: gain_percentage
      }
      Details.new(attributes)
    end

    private

    def initial_native_amount
      assets.reduce(0) do |sum, asset|
        sum + asset.amount * asset.price
      end
    end

    def final_native_amount(price)
      asset_count * price
    end

    def asset_count
      assets.reduce(0) do |sum, asset|
        sum + asset.amount
      end
    end

    attr_reader :assets
  end
end
