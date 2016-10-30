module CoinPortfolio
  class Inventory
    def initialize(transactions)
      @transactions = transactions
    end

    def build
      build_inventory_with_fifo_method
    end

    private

    attr_reader :transactions

    def build_inventory_with_fifo_method
      outgoing_quantity = total_outgoing_quantity
      incoming_transactions.each_with_object([]) do |transaction, inventory_items|
        transaction_quantity = transaction.amount.amount
        remaining_quantity = transaction_quantity - outgoing_quantity
        if remaining_quantity > 0
          item = InventoryItem.new(quantity: remaining_quantity, cost: transaction.price)
          inventory_items.push(item)
        end

        outgoing_quantity = [0, outgoing_quantity - transaction_quantity].max
      end
    end

    def incoming_transactions
      transactions.select(&:incoming?)
    end

    def total_outgoing_quantity
      transactions.reject(&:incoming?).reduce(0) do |sum, transaction|
        sum + transaction.amount.amount
      end
    end
  end
end
