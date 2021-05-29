class HumappMailer < ApplicationMailer
  def send_alarm_message(contract, sensor)
    @sensor = sensor
    @contract = contract
    mail(to: @contract.email, subject: "Contract #{@contract.contract_id} completed!")
    # puts "email method is called"
  end

  def send_test_message
    mail(to: "manesourabh2@gmail.com", subject: "Crontab tasks are working")
  end
end
