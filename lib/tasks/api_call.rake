namespace :api_call do
  desc "Will send a request to our crypto_currency api and update saved data"
  task update_crypto_data: :environment do
    api_service = CryptoCurrencyApiService.new
    api_service.update_bulk_cryptocurrency_data
  end
end
