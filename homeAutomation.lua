wifi.setmode(wifi.STATION)
wifi.sta.config("AP_NAME","SECURITY_KEY") -- Replace with your AP Name and security key.
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then 
print("Obtaining IP...") 
else 
tmr.stop(1)
print("Got IP. "..wifi.sta.getip())
end 
end)
print(wifi.sta.getip())
led1 = 3 -- GPIO 0
led2 = 4 -- GPIO 2
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
            end
        end
        data = "<title>Home Automation Using ESP</title>";
        data = data.."<center><h1>Robo India's <br> Tutorial on Home Automation</h1>";
        data = data.."<p>GPIO0 - (Pin3) <a href=\"?req=ON1\"><button>ON</button></a>&nbsp;<a href=\"?req=OFF1\"><button>OFF</button></a></p>";
        data = data.."<p>GPIO2 - (Pin4) <a href=\"?req=ON2\"><button>ON</button></a>&nbsp;<a href=\"?req=OFF2\"><button>OFF</button></a></p>";        
        local _on,_off = "",""
        if(_GET.req == "ON1")then
              gpio.write(led1, gpio.HIGH);
        elseif(_GET.req == "OFF1")then
              gpio.write(led1, gpio.LOW);
        elseif(_GET.req == "ON2")then
              gpio.write(led2, gpio.HIGH);
        elseif(_GET.req == "OFF2")then
              gpio.write(led2, gpio.LOW);
        end
        client:send(data);
        client:close();
        collectgarbage();
    end)
end)
