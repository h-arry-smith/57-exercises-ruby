require 'json'
require 'net/http'

class CurrencyCalculator
  attr_reader :rates_api

  def initialize(rates_api)
    @rates_api = rates_api
    @currencies = rates_api.fetch_currencies
  end

  def exchange(from, to, amount)
    from = from.upcase
    to = to.upcase

    raise CurrencyDoesNotExistError unless exists?(from)
    raise CurrencyDoesNotExistError unless exists?(to)

    rates = rates_api.fetch_rates(from)

    convert(amount, rates[to], rates[from])
  end

  def convert(amount, rate_from, rate_to)
    ((amount * rate_from) / rate_to).round(2)
  end

  private

  def exists?(currency)
    @currencies[currency] != nil
  end
end

class CurrencyDoesNotExistError < StandardError
end

class RatesProvider
  def initialize(api)
    @api = api
  end

  def fetch_currencies
    @api.fetch_currencies
  end

  def fetch_rates(base)
    @api.fetch_rates(base)['rates']
  end
end

class OpenExchangeRates
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_rates(base)
    JSON.parse(Net::HTTP.get(latest_uri(base)))
  end

  def fetch_currencies
    JSON.parse(Net::HTTP.get(currencies_uri))
  end

  private

  def latest_uri(base)
    URI("https://openexchangerates.org/api/latest.json?app_id=#{@api_key}&base=#{base}")
  end

  def currencies_uri
    URI("https://openexchangerates.org/api/currencies.json")
  end
end
