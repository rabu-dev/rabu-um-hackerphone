local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("hackerphone", function(source)
   local src = source
   local Player = QBCore.Functions.GetPlayer(src)
   local name = Player.PlayerData.charinfo.firstname
   TriggerClientEvent('um-hackerphone:client:openphone',src,name)
end)

QBCore.Functions.CreateUseableItem("tracker", function(source)
   TriggerClientEvent('um-hackerphone:client:vehicletracker',source)
end)

QBCore.Functions.CreateUseableItem("centralchip", function(source)
   TriggerClientEvent('um-hackerphone:client:centralchip',source)
end)

RegisterNetEvent('um-hackerphone:server:removeitem', function(item)
   local Player = QBCore.Functions.GetPlayer(source)
   Player.Functions.RemoveItem(item, 1)
end)


RegisterNetEvent('um-hackerphone:server:targetinformation', function()
   local src = source
   local PlayerPed = GetPlayerPed(src)
   local pCoords = GetEntityCoords(PlayerPed)
   local found = false
      for k, v in pairs(QBCore.Functions.GetPlayers()) do
         local TargetPed = GetPlayerPed(v)
         local tCoords = GetEntityCoords(TargetPed)
         local dist = #(pCoords - tCoords)
         if PlayerPed ~= TargetPed and dist < 3.0 then
            found = true
            TargetPlayer = QBCore.Functions.GetPlayer(v)
         end
     end
  if found then 
         local targetinfo = {
            ['targetname'] = TargetPlayer.PlayerData.charinfo.firstname,
            ['targetlastname'] = TargetPlayer.PlayerData.charinfo.lastname,
            ['targetdob'] = TargetPlayer.PlayerData.charinfo.birthdate,
            ['targetphone'] = TargetPlayer.PlayerData.charinfo.phone,
            ['targetbank'] = "******"
          }
      TriggerClientEvent('um-hackerphone:client:targetinfornui',src,targetinfo)
   else
      TriggerClientEvent('um-hackerphone:client:notify',src)
   end
end)

-- comando terminal quitar dinero y ponerlo en el banco de player que utilizando el item
RegisterNetEvent('um-hackerphone:server:botnet', function()
   local closestPlayer = QBCore.Functions.GetClosestPlayer()
   local minNu = Config.MinNum
   local maxNu = Config.MaxNum
   if closestPlayer ~= nil then
   local closestPlayerBank = QBCore.Functions.GetPlayerData(closestPlayer).money
   if closestPlayerBank >= 500 and closestPlayerBank <= 5000 then
   local randomAmount = math.random(minNu, maxNu)
   QBCore.Functions.RemoveMoneyFromPlayer(closestPlayer, randomAmount)
   QBCore.Functions.AddMoneyToPlayer(PlayerId(), randomAmount)
   Citizen.Trace("Has quitado $" .. randomAmount .. " del banco del jugador más cercano a ti")
   else
   Citizen.Trace("El jugador más cercano a ti no tiene suficiente dinero")
   end
   else
   Citizen.Trace("No hay jugadores cerca")
   end
end)
