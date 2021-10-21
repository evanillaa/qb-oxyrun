Config = {}

-- Oxy runs.
Config.StartOxyPayment = 6500 -- How much you pay at the start to start the run
Config.RunAmount = math.random(25,50) -- How many drop offs the player does before it automatixally stops.
Config.Payment = math.random(330, 410) -- How much you get paid when RN Jesus doesnt give you oxy, divided by 2 for when it does.
Config.Item = "oxy" -- The item you receive from the oxy run. Should be oxy right??
Config.OxyChance = 550 -- Percentage chance of getting oxy on the run. Multiplied by 100. 10% = 100, 20% = 200, 50% = 500, etc. Default 55%.
Config.OxyAmount = 4 -- How much oxy you get when RN Jesus gives you oxy. Default: 4.
Config.BigRewarditemChance = 500 -- Percentage of getting rare item on oxy run. Multiplied by 100. 0.1% = 1, 1% = 10, 20% = 200, 50% = 500, etc. Default 50%.
Config.BigRewarditem = "lockpick" -- Put a rare item here which will have 50% chance of being given on the run.
Config.OxyCars = "CHECK THE CODE" -- Cars
Config.DropOffs = "CHECK THE CODE" -- Drop off spots
Config.pillWorker = { ['coords'] = vector4(68.7, -1569.87, 29.6, 230.65), ['info'] = ' store ' }

Config.carpick = {
    [1] = "felon",
    [2] = "kuruma",
    [3] = "sultan",
    [4] = "granger",
    [5] = "tailgater",
}

Config.OxyDropOffs = {
	[1] =  { ['coords'] = vector4(74.5, -762.17, 31.68, 160.98), ['info'] = ' 1' },
	[2] =  { ['coords'] = vector4(100.58, -644.11, 44.23, 69.11), ['info'] = ' 2' },
	[3] =  { ['coords'] = vector4(175.45, -445.95, 41.1, 92.72), ['info'] = ' 3' },
	[4] =  { ['coords'] = vector4(130.3, -246.26,  51.45, 219.63), ['info'] = ' 4' },
	[5] =  { ['coords'] = vector4(198.1, -162.11, 56.35, 340.09), ['info'] = ' 5' },
	[6] =  { ['coords'] = vector4(341.0, -184.71, 58.07, 159.33), ['info'] = ' 6' },
	[7] =  { ['coords'] = vector4(-26.96, -368.45, 39.69, 251.12), ['info'] = ' 7' },
	[8] =  { ['coords'] = vector4(-155.88, -751.76, 33.76, 251.82), ['info'] = ' 8' },
	[9] =   { ['coords'] = vector4(-305.02, -226.17, 36.29, 306.04), ['info'] = ' 9 ' },
	[10] =  { ['coords'] = vector4(-347.19, -791.04, 33.97, 3.06), ['info'] = ' 10 ' },
	[11] =  { ['coords'] = vector4(-703.75, -932.93, 19.22, 87.86), ['info'] = ' 11 ' },
	[12] =  { ['coords'] = vector4(-659.35, -256.83, 36.23, 118.92), ['info'] = ' 12 ' },
	[13] =  { ['coords'] = vector4(-934.18, -124.28, 37.77, 205.79), ['info'] = ' 13 ' },
	[14] =  { ['coords'] = vector4(-1214.3, -317.57, 37.75, 18.39), ['info'] = ' 14 ' },
	[15] =  { ['coords'] = vector4(-822.83, -636.97, 27.9, 160.23), ['info'] = ' 15 ' },
	[16] =  { ['coords'] = vector4(308.04, -1386.09, 31.79, 47.23), ['info'] = ' 16 ' },
}

Config.carspawns = {
	[1] =  { ['coords'] = vector4(79.85, -1544.99, 29.47, 51.55), ['info'] = ' car 8' },
	[2] =  { ['coords'] = vector4(66.93, -1561.73, 29.47, 45.73), ['info'] = ' car 1' },
	[3] =  { ['coords'] = vector4(68.57, -1559.53, 29.47, 50.6), ['info'] = ' car 2' },
	[4] =  { ['coords'] = vector4(70.4, -1557.12, 29.47, 51.18), ['info'] = ' car 3' },
	[5] =  { ['coords'] = vector4(72.22, -1554.63, 29.47, 50.32), ['info'] = ' car 4' },
	[6] =  { ['coords'] = vector4(73.99, -1552.22, 29.47, 52.47), ['info'] = ' car 5' },
	[7] =  { ['coords'] = vector4(76.06, -1549.87, 29.47, 51.53), ['info'] = ' car 6' },
	[8] =  { ['coords'] = vector4(77.9, -1547.45, 29.47, 53.24), ['info'] = ' car 7' },
}
