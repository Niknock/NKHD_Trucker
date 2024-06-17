ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local truckerPoint = vector3(1199.2227, -3250.5273, 7.0952)
local inMarker = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(playerCoords, truckerPoint, true)

        if distance < 10.0 then
            DrawMarker(1, truckerPoint.x, truckerPoint.y, truckerPoint.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
            if distance < 1.5 then
                if Config.English == false then
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um Trucker Menü zu öffnen")
                else
                    ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to open Trucker Menu")
                end
                if IsControlJustReleased(0, 38) then
                    OpenTruckerMenu()
                end
            end
        end
    end
end)

local xp = 0

function OpenTruckerMenu()
    TriggerServerEvent('nkhd_trucker:getTruckerXP', source)
end

RegisterNetEvent('nkhd_trucker:TruckerXP')
AddEventHandler('nkhd_trucker:TruckerXP', function(truckerxp)
    xp = truckerxp
    OpenTruckerMenu2()
end)

function OpenTruckerMenu2()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openTruckerMenu",
        xp = xp
    })
end

RegisterNUICallback('selectRoute', function(data, cb)
    local route = data.route
    local useOwnTruck = data.useOwnTruck

    if useOwnTruck then
        ShowNotification('Du benutzt deinen eigenen LKW.')
    else
        if route == "short" then
            if xp >= 1 then
                if Config.English == false then
                    ShowNotification('Du leihst einen LKW aus.')
                    ShowNotification('Du hast die Route ' .. route .. ' ausgewählt.')
                else
                    ShowNotification('You are renting a truck.')
                    ShowNotification('You have selected the route ' .. route .. '.')
                end
                SetNuiFocus(false, false)
                cb('ok')
                Shortroute()
            else
                if Config.English == false then
                    ShowNotification('~r~Du hast nicht genügend XP')
                else
                    ShowNotification('~r~You do not have enough XP')
                end
            end
        elseif route == "middle" then
            if xp >= 10 then
                if Config.English == false then
                    ShowNotification('Du leihst einen LKW aus.')
                    ShowNotification('Du hast die Route ' .. route .. ' ausgewählt.')
                else
                    ShowNotification('You are renting a truck.')
                    ShowNotification('You have selected the route ' .. route .. '.')
                end
                SetNuiFocus(false, false)
                cb('ok')
                Middleroute()
            else
                if Config.English == false then
                    ShowNotification('~r~Du hast nicht genügend XP')
                else
                    ShowNotification('~r~You do not have enough XP')
                end
            end
        elseif route == "long" then
            if xp >= 80 then
                if Config.English == false then
                    ShowNotification('Du leihst einen LKW aus.')
                    ShowNotification('Du hast die Route ' .. route .. ' ausgewählt.')
                else
                    ShowNotification('You are renting a truck.')
                    ShowNotification('You have selected the route ' .. route .. '.')
                end
                SetNuiFocus(false, false)
                cb('ok')
                Longroute()
            else
                if Config.English == false then
                    ShowNotification('~r~Du hast nicht genügend XP')
                else
                    ShowNotification('~r~You do not have enough XP')
                end
            end
        elseif route == "cayo" then
            if xp >= 150 then
                if Config.English == false then
                    ShowNotification('Du leihst einen LKW aus.')
                    ShowNotification('Du hast die Route ' .. route .. ' ausgewählt.')
                else
                    ShowNotification('You are renting a truck.')
                    ShowNotification('You have selected the route ' .. route .. '.')
                end
                SetNuiFocus(false, false)
                cb('ok')
                Cayoroute()
            else
                if Config.English == false then
                    ShowNotification('~r~Du hast nicht genügend XP')
                else
                    ShowNotification('~r~You do not have enough XP')
                end
            end
        end
    end

    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

function Shortroute()
    local ModelHash = "pounder"
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) 
    while not HasModelLoaded(ModelHash) do 
    Wait(0)
    end
    local x = 1186.4092 
    local y = -3246.1897 
    local z = 6.0288
    local heading = 87.7510
    CreateVehicle(ModelHash, x, y, z, heading, 1, 0)
    
        SetNewWaypoint(796.1169, -2502.8032)
        local shortPoint = vector3(796.1169, -2502.8032, 21.6084) 
        local shortPoint2 = vector3(-106.7487, -2511.7678, 5.2499) 
        local Depot = vector3(1186.4092, -3246.1897, 6.0288) 

        local notloaded = true
        local Loaded = false
        local inJob = false

        while notloaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, shortPoint, true)
            
                if distance < 25.0 then
                    DrawMarker(1, shortPoint.x, shortPoint.y, shortPoint.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu beladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to load the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Belade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Loading the truck")
                            end
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW Beladen.')
                            else
                                ShowNotification('~g~You have loaded the truck.')
                            end
                            notloaded = false
                            Loaded = true
                            if Config.English == false then
                                ESX.ShowNotification("Bringe die Ladung zum Ziel.")
                            else
                                ESX.ShowNotification("Bring the cargo to the destination.")
                            end
                            SetNewWaypoint(-106.7487, -2511.7678)
                        end
                    end
                end
            end

        while Loaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, shortPoint2, true)

                if distance < 25.0 then
                    DrawMarker(1, shortPoint2.x, shortPoint2.y, shortPoint2.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu entladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to unload the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Entlade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Unload the truck")
                            end                            
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW entladen.')
                                ShowNotification('Bringe den LKW zum Depot.')
                            else
                                ShowNotification('~g~You have unloaded the truck.')
                                ShowNotification('Take the truck back to the depot.')
                            end                            
                            Loaded = false
                            inJob = true
                            SetNewWaypoint(1186.4092, -3246.1897)
                        end
                    end
                end
            end

        while inJob == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, Depot, true)
            local amount = 5000
            local amountxp = 1
            
                if distance < 25.0 then
                    DrawMarker(1, Depot.x, Depot.y, Depot.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zurück zu geben")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to return the truck")
                        end                        
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Gebe den Truck zurück.")
                            else
                                exports['progressBars']:startUI(10000, "Returning the truck.")
                            end                            
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~b~Du hast ' ..amount.. '$ bekommen und ' ..amountxp..' Job XP')
                                ShowNotification('~g~Du hast den LKW zurück gegeben.')
                            else
                                ShowNotification('~b~You received ' ..amount.. '$ and ' ..amountxp..' Job XP')
                                ShowNotification('~g~You have returned the truck.')
                            end                            
                            TriggerServerEvent('nkhd_trucker:pay', amount, amountxp)
                            inJob = false
                            local ped = GetPlayerPed( -1 )
                            local veh = GetVehiclePedIsIn( ped, false )
                            SetEntityAsMissionEntity( veh, true, true )
                            DeleteVehicle( veh )
                        end
                    end
                end
        end
end

function Middleroute()
    local ModelHash = "pounder"
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) 
    while not HasModelLoaded(ModelHash) do
    Wait(0)
    end
    local x = 1186.4092 
    local y = -3246.1897 
    local z = 6.0288
    local heading = 87.7510
    CreateVehicle(ModelHash, x, y, z, heading, 1, 0)
    
        SetNewWaypoint(-105.8672, -2512.4983)
        local middlePoint = vector3(-105.8672, -2512.4983, 5.3679) 
        local middlePoint2 = vector3(67.5874, 122.2432, 79.1247) 
        local Depot = vector3(1186.4092, -3246.1897, 6.0288) 

        local notloaded = true
        local Loaded = false
        local inJob = false

        while notloaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, middlePoint, true)
            
                if distance < 25.0 then
                    DrawMarker(1, middlePoint.x, middlePoint.y, middlePoint.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu beladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to load the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Belade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Loading the truck")
                            end
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW Beladen.')
                            else
                                ShowNotification('~g~You have loaded the truck.')
                            end
                            notloaded = false
                            Loaded = true
                            if Config.English == false then
                                ESX.ShowNotification("Bringe die Ladung zum Ziel.")
                            else
                                ESX.ShowNotification("Bring the cargo to the destination.")
                            end
                            SetNewWaypoint(67.5874, 122.2432)
                        end
                    end
                end
            end

        while Loaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, middlePoint2, true)

                if distance < 25.0 then
                    DrawMarker(1, middlePoint2.x, middlePoint2.y, middlePoint2.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu entladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to unload the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Entlade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Unload the truck")
                            end 
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW entladen.')
                                ShowNotification('Bringe den LKW zum Depot.')
                            else
                                ShowNotification('~g~You have unloaded the truck.')
                                ShowNotification('Take the truck back to the depot.')
                            end                            
                            Loaded = false
                            inJob = true
                            SetNewWaypoint(1186.4092, -3246.1897)
                        end
                    end
                end
            end

        while inJob == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, Depot, true)
            local amount = 10000
            local amountxp = 2
            
                if distance < 25.0 then
                    DrawMarker(1, Depot.x, Depot.y, Depot.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zurück zu geben")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to return the truck")
                        end                        
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Gebe den Truck zurück.")
                            else
                                exports['progressBars']:startUI(10000, "Returning the truck.")
                            end                            
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~b~Du hast ' ..amount.. '$ bekommen und ' ..amountxp..' Job XP')
                                ShowNotification('~g~Du hast den LKW zurück gegeben.')
                            else
                                ShowNotification('~b~You received ' ..amount.. '$ and ' ..amountxp..' Job XP')
                                ShowNotification('~g~You have returned the truck.')
                            end                            
                            TriggerServerEvent('nkhd_trucker:pay', amount, amountxp)
                            inJob = false
                            local ped = GetPlayerPed( -1 )
                            local veh = GetVehiclePedIsIn( ped, false )
                            SetEntityAsMissionEntity( veh, true, true )
                            DeleteVehicle( veh )
                        end
                    end
                end
        end
end

function Longroute()
    local ModelHash = "pounder"
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) 
    while not HasModelLoaded(ModelHash) do 
    Wait(0)
    end
    local x = 1186.4092 
    local y = -3246.1897 
    local z = 6.0288
    local heading = 87.7510
    CreateVehicle(ModelHash, x, y, z, heading, 1, 0)
    
        SetNewWaypoint(-105.8672, -2512.4983)
        local longPoint = vector3(-105.8672, -2512.4983, 5.3679) 
        local longPoint2 = vector3(2737.5957, 3413.7422, 56.6175) 
        local Depot = vector3(1186.4092, -3246.1897, 6.0288) 

        local notloaded = true
        local Loaded = false
        local inJob = false

        while notloaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, longPoint, true)
            
                if distance < 25.0 then
                    DrawMarker(1, longPoint.x, longPoint.y, longPoint.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu beladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to load the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Belade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Loading the truck")
                            end
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW Beladen.')
                            else
                                ShowNotification('~g~You have loaded the truck.')
                            end
                            notloaded = false
                            Loaded = true
                            if Config.English == false then
                                ESX.ShowNotification("Bringe die Ladung zum Ziel.")
                            else
                                ESX.ShowNotification("Bring the cargo to the destination.")
                            end
                            SetNewWaypoint(2737.5957, 3413.7422)
                        end
                    end
                end
            end

        while Loaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, longPoint2, true)

                if distance < 25.0 then
                    DrawMarker(1, longPoint2.x, longPoint2.y, longPoint2.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu entladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to unload the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Entlade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Unload the truck")
                            end 
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW entladen.')
                                ShowNotification('Bringe den LKW zum Depot.')
                            else
                                ShowNotification('~g~You have unloaded the truck.')
                                ShowNotification('Take the truck back to the depot.')
                            end                            
                            Loaded = false
                            inJob = true
                            SetNewWaypoint(1186.4092, -3246.1897)
                        end
                    end
                end
            end

        while inJob == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, Depot, true)
            local amount = 25000
            local amountxp = 4
            
                if distance < 25.0 then
                    DrawMarker(1, Depot.x, Depot.y, Depot.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zurück zu geben")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to return the truck")
                        end                        
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Gebe den Truck zurück.")
                            else
                                exports['progressBars']:startUI(10000, "Returning the truck.")
                            end                            
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~b~Du hast ' ..amount.. '$ bekommen und ' ..amountxp..' Job XP')
                                ShowNotification('~g~Du hast den LKW zurück gegeben.')
                            else
                                ShowNotification('~b~You received ' ..amount.. '$ and ' ..amountxp..' Job XP')
                                ShowNotification('~g~You have returned the truck.')
                            end                            
                            TriggerServerEvent('nkhd_trucker:pay', amount, amountxp)
                            inJob = false
                            local ped = GetPlayerPed( -1 )
                            local veh = GetVehiclePedIsIn( ped, false )
                            SetEntityAsMissionEntity( veh, true, true )
                            DeleteVehicle( veh )
                        end
                    end
                end
        end
end

function Cayoroute()
    local ModelHash = "pounder"
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) 
    while not HasModelLoaded(ModelHash) do 
    Wait(0)
    end
    local x = 1186.4092 
    local y = -3246.1897 
    local z = 6.0288
    local heading = 87.7510
    CreateVehicle(ModelHash, x, y, z, heading, 1, 0)
    
        SetNewWaypoint(-105.8672, -2512.4983)
        local cayoPoint = vector3(-105.8672, -2512.4983, 5.3679) 
        local cayoPoint2 = vector3(4958.4546, -5728.9580, 19.8881) 
        local Depot = vector3(1186.4092, -3246.1897, 6.0288) 

        local notloaded = true
        local Loaded = false
        local inJob = false

        while notloaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, cayoPoint, true)
            
                if distance < 25.0 then
                    DrawMarker(1, cayoPoint.x, cayoPoint.y, cayoPoint.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu beladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to load the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            exports['progressBars']:startUI(10000, "Belade den Truck")
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW Beladen.')
                            else
                                ShowNotification('~g~You have loaded the truck.')
                            end
                            notloaded = false
                            Loaded = true
                            if Config.English == false then
                                ESX.ShowNotification("Bringe die Ladung zum Ziel.")
                            else
                                ESX.ShowNotification("Bring the cargo to the destination.")
                            end
                            SetNewWaypoint(4958.4546, -5728.9580)
                        end
                    end
                end
            end

        while Loaded == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, cayoPoint2, true)

                if distance < 25.0 then
                    DrawMarker(1, cayoPoint2.x, cayoPoint2.y, cayoPoint2.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zu entladen")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to unload the truck")
                        end
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Entlade den Truck")
                            else
                                exports['progressBars']:startUI(10000, "Unload the truck")
                            end 
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~g~Du hast den LKW entladen.')
                                ShowNotification('Bringe den LKW zum Depot.')
                            else
                                ShowNotification('~g~You have unloaded the truck.')
                                ShowNotification('Take the truck back to the depot.')
                            end                            
                            Loaded = false
                            inJob = true
                            SetNewWaypoint(1186.4092, -3246.1897)
                        end
                    end
                end
            end

        while inJob == true do
            Citizen.Wait(0)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, Depot, true)
            local amount = 27500
            local amountxp = 8
            
                if distance < 25.0 then
                    DrawMarker(1, Depot.x, Depot.y, Depot.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, nil, nil, false)
                    if distance < 4.5 then
                        if Config.English == false then
                            ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um den Truck zurück zu geben")
                        else
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to return the truck")
                        end                        
                        if IsControlJustReleased(0, 38) then
                            if Config.English == false then
                                exports['progressBars']:startUI(10000, "Gebe den Truck zurück.")
                            else
                                exports['progressBars']:startUI(10000, "Returning the truck.")
                            end                            
                            Citizen.Wait(10000)
                            if Config.English == false then
                                ShowNotification('~b~Du hast ' ..amount.. '$ bekommen und ' ..amountxp..' Job XP')
                                ShowNotification('~g~Du hast den LKW zurück gegeben.')
                            else
                                ShowNotification('~b~You received ' ..amount.. '$ and ' ..amountxp..' Job XP')
                                ShowNotification('~g~You have returned the truck.')
                            end                            
                            TriggerServerEvent('nkhd_trucker:pay', amount, amountxp)
                            inJob = false
                            local ped = GetPlayerPed( -1 )
                            local veh = GetVehiclePedIsIn( ped, false )
                            SetEntityAsMissionEntity( veh, true, true )
                            DeleteVehicle( veh )
                        end
                    end
                end
        end
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end