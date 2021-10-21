QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('oxydelivery:server', function()
	local player = QBCore.Functions.GetPlayer(source)
	if player.PlayerData.money['cash'] >= Config.StartOxyPayment then
		player.Functions.RemoveMoney('cash', Config.StartOxyPayment)
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		TriggerClientEvent('QBCore:Notify', source, 'You dont have enough money', 'error')
	end
end)

RegisterNetEvent('oxydelivery:receiveBigRewarditem', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.PlayerData.AddItem(Config.BigRewarditem, 1)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.BigRewarditem], "add")
end)

RegisterNetEvent('oxydelivery:receiveoxy', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.Functions.AddMoney('cash', Config.Payment / 2)
	player.Functions.AddItem(Config.Item, Config.OxyAmount)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Item], "add")
end)

RegisterNetEvent('oxydelivery:receivemoneyyy', function()
	local player = QBCore.Functions.GetPlayer(source)
	player.Functions.AddMoney('cash', Config.Payment)
end)
