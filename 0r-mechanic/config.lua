Config = {}

Config.Framework = "qbcore" -- esx or qbcore

Config.Settings = {
    colorandfitmentpricefrom = "cash", -- OR card
    driftMode = {
        keyCode = 21, -- drift key
    },
    performanceMode = {
        torqValue = 16.0, -- torque multiplier of the vehicle in performance mode
        engineValue = 16.0, -- engine power multiplier of the vehicle in performance mode
    },
    nitro = {
        multiplier = 1.10, -- propulsion coefficient when using nitro (don't increase it too much)
        time = 3000, -- how many seconds it will take when using nitro
        cooldown = 30000, -- cooldown for next nitro use
        keyCode = 38, -- nitro key
    },
    popcornExhaust = {
        openKeyCode = 74, -- popcorn key
    },
    syncFitment = false, -- can affect performance!
}

Config.Menus = {
    upgrades = {
        brakes = {
            basePrice = 5000,
            increaseby = 500,
        },
        transmission = {
            basePrice = 5000,
            increaseby = 500,
        },
        suspension = {
            basePrice = 5000,
            increaseby = 500,
        },
        engine = {
            basePrice = 5000,
            increaseby = 500,
        },
        turbo = 5000,
    },
    customization = {
        spoiler = {
            basePrice = 1500,
            increaseby = 250,
        },
        skirts = {
            basePrice = 750,
            increaseby = 100,
        },
        exhausts = {
            basePrice = 1000,
            increaseby = 200,
        },
        grille = {
            basePrice = 750,
            increaseby = 150,
        },
        hood = {
            basePrice = 2200,
            increaseby = 350,
        },
        fenders = {
            basePrice = 1250,
            increaseby = 250,
        },
        roof = {
            basePrice = 1000,
            increaseby = 250,
        },
        horn = {
            basePrice = 500,
            increaseby = 0,
        },
        engine_block = {
            basePrice = 5000,
            increaseby = 1250,
        },
        air_filters = {
            basePrice = 3500,
            increaseby = 1000,
        },
        struts = {
            basePrice = 2500,
            increaseby = 250,
        },
        license_plate = {
            basePrice = 500,
            increaseby = 0,
        },
        plate_holders = {
            basePrice = 500,
            increaseby = 0,
        },
        vanity_plates = {
            basePrice = 750,
            increaseby = 250,
        },
        headlights = {
            basePrice = 1250,
            increaseby = 0,
        },
        front_bumper = {
            basePrice = 1250,
            increaseby = 250,
        },
        rear_bumper = {
            basePrice = 1250,
            increaseby = 250,
        },
        arch_cover = {
            basePrice = 750,
            increaseby = 250,
        },
        aerials = {
            basePrice = 500,
            increaseby = 150,
        },
        trim = {
            basePrice = 750,
            increaseby = 250,
        },
        tank = {
            basePrice = 500,
            increaseby = 250,
        },
        windows = {
            basePrice = 350,
            increaseby = 250,
        },
        frame = {
            basePrice = 1000,
            increaseby = 250,
        },
    },
    cosmetic = {
        headlight_color = {
            basePrice = 250,
            increaseby = 0,
        },
        livery = {
            basePrice = 500,
            increaseby = 0,
        },
        neon = {
            basePrice = 250,
            increaseby = 0,
        },
        window_tint = {
            basePrice = 100,
            increaseby = 50,
        },
        tire_smoke = {
            basePrice = 250,
            increaseby = 0,
        },
        trim_design = {
            basePrice = 500,
            increaseby = 150,
        },
        ornaments = {
            basePrice = 500,
            increaseby = 0,
        },
        dashboard = {
            basePrice = 500,
            increaseby = 100,
        },
        dial_design = {
            basePrice = 500,
            increaseby = 100,
        },
        door_speaker = {
            basePrice = 250,
            increaseby = 0,
        },
        seats = {
            basePrice = 250,
            increaseby = 150,
        },
        steering_wheels = {
            basePrice = 500,
            increaseby = 250,
        },
        shifter_leavers = {
            basePrice = 500,
            increaseby = 250,
        },
        plaques = {
            basePrice = 750,
            increaseby = 250,
        },
        speakers = {
            basePrice = 500,
            increaseby = 250,
        },
        trunk = {
            basePrice = 500,
            increaseby = 250,
        },
        wheels = {
            basePrice = 5000,
            increaseby = 0
        },
    },
    fitment = {
        price = 7500,
    },
    tuning = {
        vehicle_traction = 10000,
        tuner_chip = 25000,
        nitro = 15000,
        popcorn = 15000,
    },
    paintBooth = {
        color = 500, 
        pearlescent = 500, 
        chrome = 750, 
        chameleon = 2500, 
        neon = 250, 
        smoke = 250, 
        wheel = 250,
    },
    extras = {
        price = 250
    }
}

Config.Locations = {
    ["Bennys Workshop"] = {
        illegalMechanic = true,
        job = "perm.mecanica",
        coords = {
            vector3(940.38,-1029.53,40.84),
            vector3(940.33,-1022.25,40.84),
            vector3(940.49,-1015.17,40.84),
            vector3(951.28,-1040.71,40.17),
            vector3(939.57,-1044.21,40.98),
            vector3(939.79,-1037.36,40.93),
            vector3(951.1,-1025.7,55.55),

            vector3(742.69,-804.8,24.9),
            vector3(732.72,-808.18,24.9),
            vector3(732.99,-815.84,24.9),
            
        },
        showBlip = true,
        blipSprite = 446,
        blipColor = 4,
        blipCoords = vector3(-211.2, -1323.79, 30.22),
    }
}

Config.ExtraMenuLocations = {
    ["LSPD"] = {
        job = "none",
        coords = {
            -- vector3(455.23, -1020.47, 27.95)
        },
    } 
}

Config.Locale = {
    ["open_mechanic_menu"] = "~INPUT_CONTEXT~ Mechanic Menu",
    ["open_extra_menu"] = "~INPUT_CONTEXT~ Extra Menu",
    ["dont_have_money"] = "You don't have enough money",
    ["popcorn_exhaust"] = "Exhaust status: %s",
    ["save_cancel"] = "Changes canceled.",
    ["saved"] = "Changes saved successfully."
}