MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_level")

-- mysql commands
MySQL.createCommand("vRP/level_table","ALTER TABLE vrp_users ADD IF NOT EXISTS level INTEGER DEFAULT 0, ADD IF NOT EXISTS experience INTEGER DEFAULT 0")

MySQL.createCommand("vRP/up_level","UPDATE vrp_users SET level=level+1 WHERE id=@id")
MySQL.createCommand("vRP/xp_modify","UPDATE vrp_users SET experience = @experience  WHERE id=@id")
MySQL.createCommand("vRP/up_experience","UPDATE vrp_users SET experience=experience+1 WHERE id=@id")
MySQL.createCommand("vRP/select_xp","SELECT * FROM vrp_users WHERE id=@id")

MySQL.execute("vRP/level_table")

RegisterServerEvent('vrp:xp_increase')
AddEventHandler('vrp:xp_increase', function()
	local a = false
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
	MySQL.execute("vRP/up_experience", {id = user_id})

	MySQL.query("vRP/select_xp", {id = user_id}, function(rows,affected)
		experience = rows[1].experience
		level = rows[1].level
		xpnec = 5*level+6
		if experience >= xpnec then 
			xp = experience - xpnec
			MySQL.query("vRP/up_level", {id = user_id})
			MySQL.query("vRP/xp_modify", {experience = xp, id = user_id})
			TriggerClientEvent('notify:level_up',player,tostring(level+1))
		end
	end)
end)