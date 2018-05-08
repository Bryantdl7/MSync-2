MSync           = MSync     or {}
MSync.net       = MSync.net or {}
MSync.mysql     = MSync.mysql or {}
MSync.modules = MSync.modules or {}
MSync.settings  = MSync.settings or {}
MSync.function  = MSync.function or {}

--[[
    Description: Function to load the server side files
    Returns: nothing
]]
function MSync.function.loadServer()

    include("/msync/server/sv_net.lua")
    include("/msync/server/sv_mysql.lua")
    include("/msync/server/sv_modules.lua")
    include("/msync/server/sv_hooks.lua")

end

--[[
    Description: Function to load the MSync settings file
    Returns: true
]]
function MSync.function.loadSettings()
    if not file.Exists("msync/settings.txt", "DATA") then
        MSync.settings.data = {
            mysql = {
                host = "127.0.0.1",
                port = "3306",
                username = "root",
                password = "",
                database = "msync"
            },
            enabledModules = {
                "mrsync"
            },
            serverGroup = "allservers"
        }
        file.CreateDir("msync")
        file.Write("msync/settings.txt", util.TableToJSON(MSync.settings.data, true))
    else
        MSync.settings.data = util.JSONToTable(file.Read("msync/settings.txt", "DATA"))
    end

    return true
end

--[[
    Description: Function to save the MSync settings to the settings file
    Returns: true if the settings file exists
]]
function MSync.function.saveSettings()
    file.Write("msync/settings.txt", util.TableToJSON(MSync.settings.data, true))
    return file.Exists("msync/settings.txt", "DATA")
end

--[[
    Description: Function to get a table of the module informations
    Returns: table with Module informations
]]
function MSync.function.getModuleInfos()
    local infoTable = {}

    for k,v in pairs(MSync.modules) do
        infoTable[k] = v.info
        infoTable[k].state = table.HasValue( MSync.settings.data.enabledModules, v.info["ModuleIdentifier"] ) 
    end

    return infoTable
end

--[[
    Description: Function to return settings without the MySQL password
                We have decided that its better to Re-Enter the password always, and not be able to see the MySQL password client side
    Returns: safe settings table
]]
function MSync.function.getSafeSettings()
    local settings = MSync.settings.data
    settings.mysql.password = nil

    return settings
end