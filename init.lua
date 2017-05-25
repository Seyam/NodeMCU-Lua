wifi.setmode(wifi.STATION)
wifi.sta.config("DataSoft_WiFi","support123") -- Replace with your AP Name and security key.
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then 
print("Obtaining IP...") 
else 
tmr.stop(1)
print("Got IP. "..wifi.sta.getip())
end 
end)


tmr.alarm(0,10000,0,function() dofile("wvms.lua") end)