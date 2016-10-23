module CoinPortfolio
  class AssetConverter
    def initialize(transactions)
      @transactions = transactions
    end

    def convert
      transaction = transactions.first
      [Asset.new(amount: transaction.amount, price: transaction.price)]
    end

    private

    attr_reader :transactions
  end
end
