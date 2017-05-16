-- initiate the mqtt client and set keepalive timer to 120sec

mqtt = mqtt.Client("seyam", 120)



print "Connecting to MQTT broker. Please wait..."

mqtt:connect("mqtt://broker.hivemq.com", 1883, 0, function(conn) 
  print("connected")
  -- subscribe topic with qos = 0
  -- mqtt:subscribe("my_topic",0, function(conn) 
    -- publish a message with data = my_message, QoS = 0, retain = 0
    mqtt:publish("waterState","LOW",0,0, function(conn) 
      print("sent") 
    end)
  end)
-- end)



mqtt:on("connect", function(con) print ("connected") end)
mqtt:on("offline", function(con) print ("offline") end)



-- on receive message
mqtt:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)