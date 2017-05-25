ledPin=1
gpio.mode(ledPin,gpio.OUTPUT)
gpio.write(ledPin,gpio.HIGH)
tmr.delay(2000)
gpio.write(ledPin,gpio.LOW)