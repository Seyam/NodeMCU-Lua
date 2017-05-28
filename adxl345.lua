-- D1=SCL, D2=SDA

adxl345.init(1, 2)


tmr.alarm(0,500,1, function()
	-- body
	local x,y,z = adxl345.read()
	print(string.format("X = %d, Y = %d, Z = %d", x, y, z))
end)