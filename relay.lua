-- MAPEO PINES

pin1 = 6
pin2 = 5
pin3 = 0
pin4 = 1

-- INICIALIZAR PINES
gpio.mode(pin1,gpio.OUTPUT)
gpio.mode(pin2,gpio.OUTPUT)
gpio.mode(pin3,gpio.OUTPUT)
gpio.mode(pin4,gpio.OUTPUT)

-- TODOS A LOW
gpio.write(pin1,gpio.HIGH)
gpio.write(pin2,gpio.HIGH)
gpio.write(pin3,gpio.HIGH)
gpio.write(pin4,gpio.HIGH)

-- SUBSCRIBIR TODOS LOS CANALES
m:subscribe("/light/1",0, function(conn)
    print("Subscrito a light/1")
 end)
m:subscribe("/light/2",0, function(conn)
    print("Subscrito a light/2")
 end)
m:subscribe("/light/3",0, function(conn)
    print("Subscrito a light/3")
 end)
m:subscribe("/light/4",0, function(conn)
    print("Subscrito a light/4")
 end)

m:on("message", function(conn, topic, data)
  print(topic..":")
  if data ~= nil then
    print(data)
    if(topic == "/light/1") then
      if (data == "ON") then
        gpio.write(pin1, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin1, gpio.HIGH)
      end
    end
  if(topic == "/light/2") then
      if (data == "ON") then
        gpio.write(pin2, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin2, gpio.HIGH)
      end
    end
  if(topic == "/light/3") then
      if (data == "ON") then
        gpio.write(pin3, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin3, gpio.HIGH)
      end
    end
  if(topic == "/light/4") then
      if (data == "ON") then
        gpio.write(pin4, gpio.LOW)
      end
      if (data == "OFF") then
        gpio.write(pin4, gpio.HIGH)
      end
    end
  end
end)