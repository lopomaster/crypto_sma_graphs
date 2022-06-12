module HomeHelper

  def klines_date_range start_date, end_date
    (Time.at(start_date/1000)).to_date.to_s + ' - ' + (Time.at(end_date/1000)).to_date.to_s
  end

end
