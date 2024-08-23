
---@param fuelLevel number
function getFuelColor(fuelLevel)
    if fuelLevel >= 65 then
        return "#0b7285" -- Color for fuel levels between 65 and 100
    elseif fuelLevel >= 30 then
        return "#d9480f" -- Color for fuel levels between 30 and 64
    else
        return "#c92a2a" -- Color for fuel levels below 30
    end
end

--- Toggles the vehicle interior light
function interiorLight()
    local vehicle = cache.vehicle
    local lightOn = IsVehicleInteriorLightOn(vehicle)
    SetVehicleInteriorlight(vehicle, not lightOn)
end

--- Locks/Unlocks the vehicle doors
function lock()
    local playerPed = cache.ped
    local vehicle = cache.vehicle

    if not vehicle then return end

    local lockStatus = GetVehicleDoorLockStatus(vehicle)

    -- Toggle between locked (4) and unlocked (1)
    if lockStatus == 1 then
        SetVehicleDoorsLocked(vehicle, 4)
    else
        SetVehicleDoorsLocked(vehicle, 1)
    end
end

--- Changes seat for the player inside the vehicle
---@param index number The seat index
function changeSeat(index)
    local playerPed = cache.ped
    local vehicle = cache.vehicle

    -- Put player in the specified seat
    SetPedIntoVehicle(playerPed, vehicle, index)
end

--- Toggles the vehicle window up or down
---@param index number The window index
function toggleWindow(index)
    local vehicle = cache.vehicle

    -- Check if window is intact and toggle it
    if not IsVehicleWindowIntact(vehicle, index) then
        RollUpWindow(vehicle, index)
    else
        RollDownWindow(vehicle, index)
    end
end

--- Toggles vehicle lights between regular and high beams
function LightControl()
    local vehicle = cache.vehicle
    local _, lightsOn, highBeamsOn = GetVehicleLightsState(vehicle)

    -- Toggle between normal lights and high beams
    if lightsOn == 1 or highBeamsOn == 1 then
        SetVehicleLights(vehicle, 1)
    else
        SetVehicleLights(vehicle, 3)
    end
end

--- Toggles the engine on or off for the current vehicle
function toggleEngine()
    local playerPed = cache.ped
    local vehicle = cache.vehicle

    if not vehicle then return end

    local engineOn = not GetIsVehicleEngineRunning(vehicle)

    if IsPedInAnyHeli(playerPed) then
        if engineOn then
            SetVehicleFuelLevel(vehicle, 60.0)
        else
            SetVehicleFuelLevel(vehicle, 0.0)
        end
    else
        SetVehicleEngineOn(vehicle, engineOn, false, true)
        SetVehicleJetEngineOn(vehicle, engineOn)
    end

    -- Disable acceleration/braking until the engine starts
    CreateThread(function()
        while not GetIsVehicleEngineRunning(vehicle) do
            Wait(1)
            DisableControlAction(0, 71, true)  -- Disable acceleration
            DisableControlAction(0, 72, true)  -- Disable braking
        end
    end)
end

--- Toggles a specific door on the vehicle
---@param index number The door index
function toggleDoors(index)
    local vehicle = cache.vehicle

    if not vehicle then return end

    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    local doorOpen = GetVehicleDoorAngleRatio(vehicle, index) > 0.1

    if lockStatus == 1 or lockStatus == 0 then
        if doorOpen then
            SetVehicleDoorShut(vehicle, index, false)
        else
            SetVehicleDoorOpen(vehicle, index, false, false)
        end
    end
end