# CoinPortfolio

CoinPortfolio calculates the gains/losses of the current cryptocurrency portfolio.

Typically when checking the evolution of the price of bitcoin you can see how much the price increased/decreased over
a period of time (e.g. day, week, year).

What if you wanted to answer the question: Would it be profitable to sell all my bitcoins now? This small library
attempts to answer that question by calculating the initial and current value of the portfolio as well as the
percentage gains/losses, if the portfolio were to be fully liquidated now.

The library tries to account for scenarios in which an account has multiple incoming and outgoing transactions with
distinct prices.

## Usage

The library uses the Coinbase API to:
- access the primary account for a given API key and secret

- iterate through all the account's transactions in order to get a snapshot of the distribution of the portfolio

- get the current price of the account's cryptocurrency

The API keys need to have the following permissions: `wallet:accounts:read`, `wallet:transactions:read`.

```ruby
$ api_key = "key"
$ api_secret = "secret"
$ calculator = CoinPortfolio::Calculator.new(api_key: api_key, api_secret: api_secret)
$ returns = calculator.potential_returns
$ returns.gain_percentage
0.25
$ returns.initial_native_amount.amount
100
$ returns.final_native_amount.amount
125
```

## Improvements
Until now the priority has been getting a working version therefore, there are still plenty of improvements to be made:
- Naming - The names of a couple of classes/methods could be better. For instance, amount is a very common word in most
of the code, even when it is representing different things (which is confusing at times).

- API client - the code that interacts with coinbase's gem is isolated in a single class which translates
response hashes into domain objects. Yet the code is tied to coinbase's gem and would require some changes if there was
a need to integrate with another exchange.

## License
MIT (c) Mário Nzualo
