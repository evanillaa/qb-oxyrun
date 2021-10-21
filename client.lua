-- Variables

QBCore = exports['qb-core']:GetCoreObject()
local tasking = false
local drugStorePed = 0
local oxyVehicle = 0
local rnd = 0
local blip = 0
local deliveryPed = 0

-- Functions

local function CreateOxyVehicle()
	if DoesEntityExist(oxyVehicle) then

	    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
		SetEntityAsNoLongerNeeded(oxyVehicle)
		DeleteEntity(oxyVehicle)
	end
	
    local car = GetHashKey(Config.carpick[math.random(#Config.carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #Config.carspawns do
	    local caisseo = GetClosestVehicle(Config.carspawns[i]['coords']["x"], Config.carspawns[i]['coords']["y"], Config.carspawns[i]['coords']["z"], 3.500, 0, 70)
		if not DoesEntityExist(caisseo) then
			spawnpoint = i
		end
    end

    oxyVehicle = CreateVehicle(car, Config.carspawns[spawnpoint]['coords']["x"], Config.carspawns[spawnpoint]['coords']["y"], Config.carspawns[spawnpoint]['coords']["z"], Config.carspawns[spawnpoint]['coords']["w"], true, false)
    local plt = GetVehicleNumberPlateText(oxyVehicle)
    SetVehicleHasBeenOwnedByPlayer(oxyVehicle,true)
	TriggerEvent('vehiclekeys:client:SetOwner', plt)
    while true do
		Wait(1)
		DrawText3Ds(Config.carspawns[spawnpoint]['coords']["x"], Config.carspawns[spawnpoint]['coords']["y"], Config.carspawns[spawnpoint]['coords']["z"], "Your Delivery Car (Stolen).")
		if #(GetEntityCoords(PlayerPedId()) - vector3(Config.carspawns[spawnpoint]['coords']["x"], Config.carspawns[spawnpoint]['coords']["y"], Config.carspawns[spawnpoint]['coords']["z"])) < 8.0 then
			return
		end
    end
end

local function CreateOxyPed()
    local hashKey = `a_m_y_stwhi_01`
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Wait(100)
    end
	deliveryPed = CreatePed(pedType, hashKey, Config.OxyDropOffs[rnd]['coords']["x"],Config.OxyDropOffs[rnd]['coords']["y"],Config.OxyDropOffs[rnd]['coords']["z"], Config.OxyDropOffs[rnd]['coords']["w"], 0, 0)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)
    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)
end

local function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		Wait(20000)
		DeletePed(deliveryPed)
	end
end

local function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

local function CreateBlip()
	DeleteBlip()
	if OxyRun then
		blip = AddBlipForCoord(Config.OxyDropOffs[rnd]['coords']["x"],Config.OxyDropOffs[rnd]['coords']["y"],Config.OxyDropOffs[rnd]['coords']["z"])
	end
    
    SetBlipSprite(blip, 514)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

local function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait( 5 )
    end
end 

local function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

local function giveAnim()
    if (DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed)) then 
        loadAnimDict( "mp_safehouselost@" )
        if (IsEntityPlayingAnim(deliveryPed, "mp_safehouselost@", "package_dropoff", 3)) then 
            TaskPlayAnim(deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
        else
            TaskPlayAnim(deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
        end
    end
end

local function DoDropOff()
	local success = true
	local OxyChance = math.random(1,1000)
	Wait(1000)
	playerAnim()
	Wait(800)

	PlayPedAmbientSpeechNative(deliveryPed, "Chat_State", "Speech_Params_Force")
	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then
		local counter = math.random(50,200)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Wait(1)
		end
	
		if success then
			local counter = math.random(100,300)
			while counter > 0 do
				local crds = GetEntityCoords(deliveryPed)
				counter = counter - 1
				Wait(1)
			end
			giveAnim()
		end
	
		local crds = GetEntityCoords(deliveryPed)
		local crds2 = GetEntityCoords(PlayerPedId())
	
		if #(crds - crds2) > 3.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
			success = false
		end
		
		DeleteBlip()
		if success then

			if OxyChance <= Config.OxyChance then
				TriggerServerEvent("oxydelivery:receiveoxy")
			elseif OxyChance <= Config.BigRewarditemChance then
				TriggerServerEvent("oxydelivery:receiveBigRewarditem")
			else
				TriggerServerEvent("oxydelivery:receivemoneyyy")
			end

			Wait(2000)
			QBCore.Functions.Notify('The delivery was on point, your GPS will be updated with the next drop off', 'success')
		else
			QBCore.Functions.Notify('The drop-off failed', 'error')
		end
	
		DeleteCreatedPed()
	end
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-- Events

RegisterNetEvent('oxydelivery:client', function()
	if tasking then
		return
	end
	rnd = math.random(1,#Config.OxyDropOffs)
	CreateBlip()
	local pedCreated = false
	tasking = true
	local toolong = 600000
	while tasking do
		Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(Config.OxyDropOffs[rnd]['coords']["x"],Config.OxyDropOffs[rnd]['coords']["y"],Config.OxyDropOffs[rnd]['coords']["z"])) 
		local oxyVehCoords = GetEntityCoords(oxyVehicle)
		local dstcheck2 = #(plycoords - oxyVehCoords) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated and (oxyVehicle == veh or dstcheck2 < 15.0) then
			pedCreated = true
			DeleteCreatedPed()
			CreateOxyPed()
			QBCore.Functions.Notify('You are close to the drop-off point')
		end
		toolong = toolong - 1
		if toolong < 0 then

			SetVehicleHasBeenOwnedByPlayer(oxyVehicle,false)
			SetEntityAsNoLongerNeeded(oxyVehicle)
			tasking = false
			OxyRun = false
			QBCore.Functions.Notify('You took too long', 'error')
		end
		if dstcheck < 2.0 and pedCreated then
			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")
			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Wait(1500)
				PlayPedAmbientSpeechNative(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()
				tasking = false
			end
		end
	end
	DeleteCreatedPed()
	DeleteBlip()
end)

RegisterNetEvent('oxydelivery:startDealing', function()
    local NearNPC = GetClosestPed()
	PlayPedAmbientSpeechNative(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	salecount = 0
	CreateOxyVehicle()
	OxyRun = true
	firstdeal = true
	QBCore.Functions.Notify('A car has been provided. Your GPS will be updated with locations soon', 'success')
end)

-- Threads

CreateThread(function()
    while true do
		Wait(1)
		local dropOff6 = #(GetEntityCoords(PlayerPedId()) - vector3(Config.pillWorker['coords']["x"],Config.pillWorker['coords']["y"],Config.pillWorker['coords']["z"]))
		if dropOff6 < 1.6 and not OxyRun then
			DrawText3Ds(Config.pillWorker['coords']["x"],Config.pillWorker['coords']["y"],Config.pillWorker['coords']["z"], "[E] $6,500 - Delivery Job (Payment Cash + Oxy)") 
			if IsControlJustReleased(0,38) then
				TriggerServerEvent("oxydelivery:server")
				Wait(1000)
			end
		end
    end
end)

CreateThread(function()
	while true do
		Wait(5)
		if OxyRun then
			if not DoesEntityExist(oxyVehicle) or GetVehicleEngineHealth(oxyVehicle) < 200.0 or GetVehicleBodyHealth(oxyVehicle) < 200.0 then
				OxyRun = false
				tasking = false
				QBCore.Functions.Notify("The dealer isn't giving you anymore locations due to the state of his car", "error")
			else
				if tasking then
					Wait(30000)
				else
					TriggerEvent("oxydelivery:client")  
					salecount = salecount + 1
					if salecount == Config.RunAmount then
						Wait(300000)
						OxyRun = false
					end
				end
			end
		end
	end
end)
