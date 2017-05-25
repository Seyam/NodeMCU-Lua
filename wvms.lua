-- initiate the mqtt client and set keepalive timer to 120sec

BROKER = "broker.hivemq.com"
PORT = 1883

adxl345.init(1, 2)

waterPin=3
gpio.mode(waterPin,gpio.INPUT)



tmr.alarm(0,1000,1, function()
  -- body
  local x,y,z = adxl345.read()
  print(string.format("X = %d, Y = %d, Z = %d", x, y, z))
end)






mqtt = mqtt.Client("seyam",120)
-- data = tostring(math.random(10))


print "Connecting to MQTT broker. Please wait..."

mqtt:connect(BROKER, PORT, 0, function(conn)
  print("connected")
  -- subscribe topic with qos = 0
end)



mqtt:on("connect", function(con)
  print ("I'm connected to "..BROKER)

  mqtt:subscribe("wvms",0, function(conn)
    print("Subscribed to wvms!")
  end)
end)


mqtt:on("offline", function(con) print ("I'm offline") end)




-- on receive message
mqtt:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)


tmr.alarm(0, 1000, 1, function() publishData() end ) --publish every 3 seconds

function publishData()

  local state = tostring(gpio.read(waterPin))

  print(state)

  local x,y,z = adxl345.read() --No need to do 'tostring' coz x,y,z they expect only number

  print(string.format("X = %d, Y = %d, Z = %d", x, y, z))

  accDataTable={X=x,Y=y,Z=z}
  accJson=cjson.encode(accDataTable)
  -- print(accJson)
  

  -- publish a message with data = my_message, QoS = 0, retain = 0
  -- mqtt:publish("wvms/test/weightStatus",state,0,0, function(conn)
  --   print("Published waterState: "..state)
  -- end)

  mqtt:publish("wvms/test/balanceStatus",accJson,0,0, function(conn)
    -- print("Published balanceStatus")
  end)

end


