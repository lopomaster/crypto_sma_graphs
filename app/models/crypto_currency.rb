class CryptoCurrency < ActiveRecord::Base

  validates :symbol, presence: true, uniqueness: true, allow_nil: false
  validates :name, presence: true, uniqueness: true, allow_nil: false

  SMA_INTERVALS = [48, 72, 96, 120, 144, 168].freeze
  SMA_PRECISION = 8

  def close_prices
    self.raw_data.map {|row| row[4].to_f }
  end

  def open_times
    self.raw_data.map {|row| row[0] }
  end

  def moving_average(a, group, precision=SMA_PRECISION)
    data = a.each_cons(group).map { |e| e.reduce(&:+).fdiv(group).round(precision) }
  end

  def calc_display_data
    sma_data = {sma_data: {}}
    prices = close_prices
    times = open_times

    SMA_INTERVALS.each do |interval|
      moving_average_data = moving_average(prices, interval)
      moving_average_data = moving_average_data.insert(0, Array.new(interval - 1, nil)).flatten
      sma_data[:sma_data] = sma_data[:sma_data].merge({ interval => times.zip(moving_average_data) })
    end
    sma_data[:close_prices] = times.zip(prices)
    sma_data[:date_range] = { start_at: times.first, end_at: times.last }
    sma_data
  end

end
