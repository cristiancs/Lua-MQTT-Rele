dofile('config.lua')
m = mqtt.Client(client_id, 120, username, password)

m:on("offline", function(con)
  print ("reconnecting...")
  print(node.heap())
  tmr.alarm(1, 1000, 1, function() 
    m:connect(mqtt_broker_ip, mqtt_broker_port)
  end)
end)
tmr.alarm(1, 1000, 1, function() 
  m:connect(mqtt_broker_ip, mqtt_broker_port)
end)
conectado = 0
m:on("connect", function(con) 
	tmr.stop(1)
	print("Connected to MQTT")
    print("  IP: ".. mqtt_broker_ip)
    print("  Port: ".. mqtt_broker_port)
    print("  Client ID: ".. mqtt_client_id)
    print("  Username: ".. mqtt_username)
    dofile("main.lua")

end)
