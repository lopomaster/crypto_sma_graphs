class HomeController < ApplicationController
  layout 'application'

  def index
    @adabnb = Cryptocurrency.find_by_symbol('ADABNB')
  end
end
