require('ds18b20')

-- MAPEO PINES
pin1 = 0
pin2 = 1
pin3 = 2
pin4 = 3
pin5 = 4
pin6 = 5
-- INICIALIZAR PINES
gpio.mode(pin1,gpio.OUTPUT)
gpio.mode(pin2,gpio.OUTPUT)
gpio.mode(pin3,gpio.OUTPUT)
gpio.mode(pin4,gpio.OUTPUT)
ds18b20.setup(pin5)
gpio.mode(pin6,gpio.INPUT)

-- TODOS A LOW
gpio.write(pin1,gpio.HIGH)
gpio.write(pin2,gpio.HIGH)
gpio.write(pin3,gpio.HIGH)
gpio.write(pin4,gpio.HIGH)

-- SUBSCRIBIR TODOS LOS CANALES
m:subscribe("/exterior/bomba_piscina",0, function(conn)
    print("Subscrito a bomba_piscina")
 end)
m:subscribe("/exterior/bomba_tinaja",0, function(conn)
    print("Subscrito a bomba_tinaja")
 end)
m:subscribe("/exterior/luz_patio",0, function(conn)
    print("Subscrito a luz_patio")
 end)
m:subscribe("/exterior/luz_interior",0, function(conn)
    print("Subscrito a luz_interior")
 end)
m:subscribe("/exterior/temperatura_piscina",0, function(conn)
    print("Subscrito a temperatura_piscina")
 end)
m:subscribe("/exterior/temperatura_tinja",0, function(conn)
    print("Subscrito a temperatura_tinja")
 end)
m:subscribe("/exterior/temperatura_patio",0, function(conn)
    print("Subscrito a temperatura_patio")
 end)
m:subscribe("/exterior/gas",0, function(conn)
    print("Subscrito a gas")
 end)




m:on("message", function(conn, topic, data)
  print(topic..":")
  if data ~= nil then
    print(data)
    if(topic == "/exterior/bomba_piscina") then
      if (data == "ON") then
        gpio.write(pin1, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin1, gpio.HIGH)
      end
    end
  if(topic == "/exterior/bomba_tinaja") then
      if (data == "ON") then
        gpio.write(pin2, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin2, gpio.HIGH)
      end
    end
  if(topic == "/exterior/luz_patio") then
      if (data == "ON") then
        gpio.write(pin3, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin3, gpio.HIGH)
      end
    end
  if(topic == "/exterior/luz_interior") then
      if (data == "ON") then
        gpio.write(pin4, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin4, gpio.HIGH)
      end
    end
  end
  if(topic == "/exterior/temperatura_piscina") then
      if (data == "READ") then
        addrs = ds18b20.addrs()
        lectura = ds18b20.readNumber(addrs[0],t.C)
         mqtt:publish("/exterior/temperatura_piscina",lectura,0,0, function(conn) 
          print("sent") 
        end)
      end
    end
    if(topic == "/exterior/temperatura_tinaja") then
      if (data == "READ") then
        addrs = ds18b20.addrs()
        lectura = ds18b20.readNumber(addrs[0],t.C)
         mqtt:publish("/exterior/temperatura_tinaja",lectura,0,0, function(conn) 
          print("sent") 
        end)
      end
    end
    if(topic == "/exterior/temperatura_exterior") then
      if (data == "READ") then
        addrs = ds18b20.addrs()
        lectura = ds18b20.readNumber(addrs[0],t.C)
         mqtt:publish("/exterior/temperatura_exterior",lectura,0,0, function(conn) 
          print("sent") 
        end)
      end
    end
    if(topic == "/exterior/gas") then
      if (data == "READ") then
          lectura = gpio.read(pin6)
          mqtt:publish("/exterior/gas",lectura,0,0, function(conn) 
            print("sent") 
          end)
        end)
      end
    end
  end

end)
