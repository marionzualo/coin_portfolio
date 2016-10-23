module CoinPortfolio
  class Liquidation
    Details = ImmutableStruct.new(:initial_native_amount, :final_native_amount, :gain_percentage)
    def initialize(transaction)
      @transaction = transaction
    end

    def details(price)
      initial_native_amount = transaction.native_amount
      final_native_amount = price * transaction.amount
      gain_percentage = (final_native_amount - initial_native_amount).to_f / initial_native_amount
      attributes = {
        initial_native_amount: initial_native_amount,
        final_native_amount: final_native_amount,
        gain_percentage: gain_percentage
      }
      Details.new(attributes)
    end

    private

    attr_reader :transaction
  end
end
