require "test_helper"

class CryptoCurrencyTest < ActiveSupport::TestCase

  test 'valid crypto_currency' do
    crypto_currency = CryptoCurrency.new(name: 'ETH', symbol: 'ETH')
    assert crypto_currency.valid?
  end

  test 'invalid without name' do
    crypto_currency = CryptoCurrency.new(symbol: 'ETH')
    refute crypto_currency.valid?
    assert_not_nil crypto_currency.errors[:name], 'no validation error for name present'
  end

  test 'invalid without symbol' do
    crypto_currency = CryptoCurrency.new(name: 'ETH')
    refute crypto_currency.valid?
    assert_not_nil crypto_currency.errors[:name], 'no validation error for name present'
  end

  test 'validate uniqueness name' do
    crypto_currency = CryptoCurrency.new(name: 'ETH', symbol: 'SYMBOL1')
    assert crypto_currency.valid?
    crypto_currency.save

    crypto_currency = CryptoCurrency.new(name: 'ETH', symbol: 'SYMBOL2')
    refute crypto_currency.valid?
    assert_not_nil crypto_currency.errors[:name], 'no validation error for name present'
  end

  test 'validate uniqueness symbol' do
    crypto_currency = CryptoCurrency.new(name: 'NAME1', symbol: 'SYMBOL')
    assert crypto_currency.valid?
    crypto_currency.save!

    crypto_currency = CryptoCurrency.new(name: 'NAME2', symbol: 'SYMBOL')
    refute crypto_currency.valid?
    assert_not_nil crypto_currency.errors[:name], 'no validation error for name present'
  end

end
