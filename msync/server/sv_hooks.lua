--[[
    Description: hook to initialize MSync 2
    Returns: nothing

    Somehow the hook never gets called and I can't fix that.
]
hook.Add( "Initialize", "msync.initScript", function()
    MSync.func.loadSettings()
    
    --[[
        Description: timer to prevent loading before ULX
        Returns: nothing
    ]   
    timer.Create("msync.t.checkForULXandULib", 5, 0, function()
        if not ULX or not ULib then return end;

        timer.Remove("msync.t.checkForULXandULib")
        MSync.ulx.createPermissions()
        MSync.ulx.createCommands()
        MSync.mysql.initialize() 
    end)
end)
]]
--[[
        Description: Creates a entry to the database for every player that joins.
        Returns: nothing
    ]]     
hook.Add("PlayerInitialSpawn", "msync.createUser", function( ply )
    MSync.mysql.addUser(ply)
    MSync.net.sendTable(ply, "modulestate", MSync.settings.data.enabledModules)
end)