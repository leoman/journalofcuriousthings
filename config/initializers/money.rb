MoneyRails.configure do |config|

  # set the default currency
  config.default_currency = :gbp
  config.rounding_mode = BigDecimal::ROUND_HALF_UP

end