namespace :humapp do
  desc "Check the humidity levels for a sensor and send a email if the values have reached the limit"
  task check_humidity_and_send_message: :environment do
    sensors = ActiveSensor.where.not(contract_id: nil)
    sensors.each do |s|
      puts s.contract_id
      contract = Contract.where(contract_id: s.contract_id).last
      values = SensorValue.where(sensor_name: s.sensor_name).last(20).pluck(:sensor_value)
      # puts values
      unless values.empty?
        # avg = 0 # default lowest value
        # puts values
        avg = values.reduce(:+) / values.size.to_f
        puts "Average reading for contract #{s.contract_id} & sensor #{s.sensor_name} is #{avg}"
        if avg < contract.fvalue
          puts "Target value #{contract.fvalue} for contract #{s.contract_id} & sensor #{s.sensor_name}  has not been reached"
        else
          if contract.alarm
            puts "email for contract #{s.contract_id} will be sent #{contract.email}"
            HumappMailer.send_alarm_message(contract, s).deliver_now
            puts "email has been sent to #{contract.email}"
            contract.alarm = false
            contract.save
          end
        end
      end
    end
    puts "Hello its working"
  end

  task test: :environment  do
    puts "test task is working!"
    HumappMailer.send_test_message().deliver_now
  end
end
