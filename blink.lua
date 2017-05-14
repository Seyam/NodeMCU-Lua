while 1 do
gpio.write(0, gpio.HIGH)
tmr.delay(1000000) -- wait 1,000,000 us = 1 second
gpio.write(0, gpio.LOW)
tmr.delay(1000000) -- wait 1,000,000 us = 1 second
end