Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(5000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('vrp:xp_increase')
	end
end)

RegisterNetEvent('notify:level_up')
AddEventHandler('notify:level_up', function(level)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(level)
  DrawNotification(true, false)
end)
