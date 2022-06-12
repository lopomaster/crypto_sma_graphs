class CryptocurrencyApiService
  require 'net/http'

  def initialize
  end

  def update_bulk_cryptocurrency_data
    symbols = Cryptocurrency.all.pluck(:symbol).map { |symbol| symbol.upcase }.join(',')
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


  #   [
  #     [
  #       1499040000000,      // Open time
  #   "0.01634790",       // Open
  #   "0.80000000",       // High
  #   "0.01575800",       // Low
  #   "0.01577100",       // Close
  #   "148976.11427815",  // Volume
  #   1499644799999,      // Close time
  #   "2434.19055334",    // Quote asset volume
  #   308,                // Number of trades
  #   "1756.87402397",    // Taker buy base asset volume
  #   "28.46694368",      // Taker buy quote asset volume
  #   "17928899.62484339" // Ignore.
  #   ]
  # ]

  def send_api_request(symbol='ADABNB', interval='1h')
    begin
      url  = "https://api.binance.com/api/v3/klines?symbol=#{symbol}&interval=#{interval}"
      uri  = URI(url)
      res  = Net::HTTP.get(uri)
      json = JSON.parse(res)
    rescue => e
      puts "Raised exception requesting cryptocurrency data url: #{url}"
      puts e.message
      puts e.backtrace.inspect
    end
  end

  def update_cryptocurrency(symbol, api_data)
    begin
      crypto = Cryptocurrency.find_by(symbol: symbol)
      crypto.raw_data = api_data
      crypto.display_data = crypto.calc_display_data
      crypto.save!
    rescue => e
      puts "Raised exception updating #{symbol}"
      puts e.message
      puts e.backtrace.inspect
    end
  end
end

# https://api.binance.com/api/v3/avgPrice?symbol=ADABNB