require "money"
I18n.enforce_available_locales = false

module CoinPortfolio
  Money = ImmutableStruct.new(:amount, :currency) do
    def to_s
      ::Money.from_amount(amount, currency).format
    end
  end
end
