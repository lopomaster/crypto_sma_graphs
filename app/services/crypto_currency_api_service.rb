class CryptoCurrencyApiService
  require 'net/http'

  def perform a=nil
    update_bulk_cryptocurrency_data
  end

  def update_bulk_cryptocurrency_data
    symbols = CryptoCurrency.all.pluck(:symbol).map { |symbol| symbol.upcase }.join(',')
    symbols.split(',').each do |symbol|
      json = send_api_request(symbol)
      update_cryptocurrency(symbol, json) if json
    end
  end

  def update_single_cryptocurrency_data(symbol)
    json = send_api_request(symbol)
    update_cryptocurrency(symbol, json)
  end

  private

  def send_api_request(symbol='ADABNB', interval='1h')
    url  = "https://api.binance.com/api/v3/klines?symbol=#{symbol}&interval=#{interval}"
    uri  = URI(url)
    res  = Net::HTTP.get(uri)
    json = JSON.parse(res)
  rescue => e
    puts "Raised exception requesting crypto_currency data url: #{url}"
    puts e.message
    puts e.backtrace.inspect
  end

  def update_cryptocurrency(symbol, api_data)
    crypto = CryptoCurrency.find_by(symbol: symbol)
    crypto.raw_data = api_data
    crypto.display_data = crypto.calc_display_data
    crypto.save!
  rescue => e
    puts "Raised exception updating #{symbol}"
    puts e.message
    puts e.backtrace.inspect
  end

end
