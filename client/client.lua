
local keybind = lib.addKeybind({
    name = 'carmenu',
    description = 'Open Car Menu',
    defaultKey = cfg.KeyMapping,
    onPressed = function(data)
        local playerPed = cache.ped
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if not IsPedInAnyVehicle(playerPed) or not DoesEntityExist(vehicle) then
            return
        end

        local plate = GetVehicleNumberPlateText(vehicle)
        local fuelLevel = GetVehicleFuelLevel(vehicle)

        lib.registerContext({
            id = 'Karos',
            title = locale('title'),
            options = {
                {
                    title = locale('title_fuel'),
                    icon = cfg.IconFuel,
                    progress = fuelLevel or 0,
                    colorScheme = getFuelColor(fuelLevel),
                    iconColor = cfg.ColorIconFuel,
                    iconAnimation = 'beatFade',
                    description = string.format(locale('fuel_level'), fuelLevel) ..'%',
                    disabled = true,
                },
                {
                    title = locale('plate'),
                    icon = cfg.IconPlate,
                    description = locale('vehicle_plate') .. plate,
                    iconColor = cfg.ColorIconPlate,
                    iconAnimation = 'beatFade',
                    disabled = true,
                },
                {
                    title = locale('doors'),
                    icon = cfg.IconDoors,
                    description = locale('open_doors_menu'),
                    iconColor = cfg.ColorIconDoors,
                    iconAnimation = 'beatFade',
                    arrow = true,
                    onSelect = function(data)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('lights'),
                    icon = cfg.IconLights,
                    description = locale('open_lights_menu'),
                    iconColor = cfg.ColorIconLights,
                    iconAnimation = 'beatFade',
                    arrow = true,
                    onSelect = function(data)
                        lib.showContext('LightsMenu')
                    end,
                },
                {
                    title = locale('engine'),
                    icon = cfg.IconEngine,
                    description = locale('open_engine_menu'),
                    iconColor = cfg.ColorIconEngine,
                    iconAnimation = 'beatFade',
                    arrow = true,
                    onSelect = function(data)
                        lib.showContext('EngineMenu')
                    end,
                },
                {
                    title = locale('lock_doors'),
                    icon = cfg.IconLock,
                    description = locale('lock_unlock_doors'),
                    iconColor = cfg.ColorIconLock,
                    iconAnimation = 'beatFade',
                    arrow = true,
                    onSelect = function(data)
                        lock()
                        lib.showContext('Karos')
                    end,
                },
                {
                    title = locale('windows'),
                    icon = cfg.IconWindow,
                    description = locale('toggle_windows_menu'),
                    iconColor = cfg.ColorIconWindow,
                    iconAnimation = 'beatFade',
                    arrow = true,
                    onSelect = function(data)
                        lib.showContext('WindowsMenu')
                    end,
                },
            },
        })

        lib.registerContext({
            id = 'LightsMenu',
            title = locale('lights_title'),
            menu = 'Karos',
            options = {
                {
                    title = locale('front_lights'),
                    icon = cfg.IconFrontLights,
                    description = locale('lights_on_off'),
                    iconColor = cfg.ColorIconFrontLights,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        LightControl()
                        lib.showContext('LightsMenu')
                    end,
                },
                {
                    title = locale('interior_light'),
                    icon = cfg.IconInteriorLight,
                    description = locale('interior_light_on_off'),
                    iconColor = cfg.ColorIconInteriorLight,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        interiorLight()
                        lib.showContext('LightsMenu')
                    end,
                },
            },
        })

        lib.registerContext({
            id = 'EngineMenu',
            title = locale('engine_title'),
            menu = 'Karos',
            options = {
                {
                    title = locale('engine_title'),
                    icon = cfg.IconEngine,
                    description = locale('engine_on_off'),
                    iconColor = cfg.ColorIconEngine,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleEngine()
                        lib.showContext('EngineMenu')
                    end,
                },
            },
        })

        lib.registerContext({
            id = 'DoorsMenu',
            title = locale('doors_title'),
            menu = 'Karos',
            options = {
                {
                    title = locale('driver_door'),
                    icon = cfg.IconDriversDoor,
                    description = locale('door'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(0)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('passenger_door'),
                    icon = cfg.IconPassengerDoor,
                    description = locale('door'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(1)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('driver_rear_door'),
                    icon = cfg.IconDriversRearDoor,
                    description = locale('door'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(2)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('rear_passenger_door'),
                    icon = cfg.IconPassengerRearDoor,
                    description = locale('door'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(3)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('bonnet'),
                    icon = cfg.IconBonnetDoor,
                    description = locale('bonnet_on_off'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(4)
                        lib.showContext('DoorsMenu')
                    end,
                },
                {
                    title = locale('rear_luggage_rack'),
                    icon = cfg.IconLuggageDoor,
                    description = locale('rear_luggage_rack_on_off'),
                    iconColor = cfg.ColorIconDoor,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleDoors(5)
                        lib.showContext('DoorsMenu')
                    end,
                },
            },
        })

        lib.registerContext({
            id = 'WindowsMenu',
            title = locale('windows_title'),
            menu = 'Karos',
            options = {
                {
                    title = locale('toggle_front_left_window'),
                    icon = cfg.IconWindow,
                    description = locale('window_driver_open_close'),
                    iconColor = cfg.ColorIconWindow,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleWindow(0)
                        lib.showContext('WindowsMenu')
                    end,
                },
                {
                    title = locale('toggle_front_right_window'),
                    icon = cfg.IconWindow,
                    description = locale('window_passenger_open_close'),
                    iconColor = cfg.ColorIconWindow,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleWindow(1)
                        lib.showContext('WindowsMenu')
                    end,
                },
                {
                    title = locale('toggle_rear_left_window'),
                    icon = cfg.IconWindow,
                    description = locale('window_rear_driver_open_close'),
                    iconColor = cfg.ColorIconWindow,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleWindow(2)
                        lib.showContext('WindowsMenu')
                    end,
                },
                {
                    title = locale('toggle_rear_right_window'),
                    icon = cfg.IconWindow,
                    description = locale('window_rear_passenger_open_close'),
                    iconColor = cfg.ColorIconWindow,
                    iconAnimation = 'beatFade',
                    onSelect = function(data)
                        toggleWindow(3)
                        lib.showContext('WindowsMenu')
                    end,
                },
            },
        })

        lib.showContext('Karos')
    end,
})