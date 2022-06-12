class HomeController < ApplicationController
  layout 'application'

  def index
    @adabnb = CryptoCurrency.find_by_symbol('ADABNB')
  end
end
