module CoinPortfolio
  class Transaction
    attr_accessor :amount, :native_amount

    def initialize(amount:, native_amount:, incoming:)
      @amount = amount
      @native_amount = native_amount
      @incoming = incoming
    end

    def price
      price_f = native_amount.amount.to_f / amount.amount
      CoinPortfolio::Money.new(amount: price_f, currency: native_amount.currency)
    end

    def incoming?
      incoming
    end

    private

    attr_accessor :incoming
  end
end
