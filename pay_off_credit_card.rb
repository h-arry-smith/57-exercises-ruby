FACTOR = -1.0 / 30.0

def months_to_pay_off(balance, apr, monthly_payment)
  daily_rate = apr / 100.0 / 365.0

  (FACTOR * (
    (Math.log(1 + ((balance / monthly_payment) * (1 - ((1 + daily_rate)**30))))) /
      Math.log(1 + daily_rate)
  )).ceil
end
