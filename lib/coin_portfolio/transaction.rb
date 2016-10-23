module CoinPortfolio
  class Transaction
    attr_accessor :amount, :native_amount

    def initialize(amount:, native_amount:, incoming:)
      @amount = amount
      @native_amount = native_amount
      @incoming = incoming
    end

    def price
      native_amount.to_f / amount
    end

    def incoming?
      incoming
    end

    private

    attr_accessor :incoming
  end
end
