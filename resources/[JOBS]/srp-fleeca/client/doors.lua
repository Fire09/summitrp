Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local inRange = true

        local PacificDist = GetDistanceBetweenCoords(pos, Config.BigBanks["pacific"]["coords"][4]["x"], Config.BigBanks["pacific"]["coords"][4]["y"], Config.BigBanks["pacific"]["coords"][4]["z"], true)


        -- Pacific Check
        if PacificDist < 50 then
            inRange = true
            if Config.BigBanks["pacific"]["isOpened"] then
                local object = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][4]["x"], Config.BigBanks["pacific"]["coords"][4]["y"], Config.BigBanks["pacific"]["coords"][4]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
                if object ~= 0 then
                    SetEntityHeading(object, Config.BigBanks["pacific"]["heading"].open)
                end
            else
                local object = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][4]["x"], Config.BigBanks["pacific"]["coords"][4]["y"], Config.BigBanks["pacific"]["coords"][4]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
                if object ~= 0 then
                    SetEntityHeading(object, Config.BigBanks["pacific"]["heading"].closed)
                end
            end
        end

        if not inRange then
            Citizen.Wait(5000)
        end

        Citizen.Wait(1000)
    end
end)
