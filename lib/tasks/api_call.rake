namespace :api_call do
  desc "Will send a request to our crypto_currency api and update saved data"
  task update_crypto_data: :environment do
    puts 'UPDATE STARTING'
    CryptoCurrencyApiService.new.update_bulk_cryptocurrency_data
    puts 'UPDATE FINISHED'
  end
end
