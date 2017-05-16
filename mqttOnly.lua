-- initiate the mqtt client and set keepalive timer to 120sec

BROKER = "iot.eclipse.org"
PORT = 1883

mqtt = mqtt.Client("seyam",120)
data = tostring(math.random(10))

print "Connecting to MQTT broker. Please wait..."

mqtt:connect(BROKER, PORT, 0, function(conn)
  print("connected")
  -- subscribe topic with qos = 0
end)



mqtt:on("connect", function(con)
  print ("I'm connected to"..BROKER)

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


tmr.alarm(0, 3000, 1, function() publishData() end ) --publish every 3 seconds

function publishData()

   -- publish a message with data = my_message, QoS = 0, retain = 0
  mqtt:publish("waterState",data,0,0, function(conn)
    print("Published waterState! ")
  end)
end
