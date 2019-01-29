MSync = MSync or {}
MSync.modules = MSync.modules or {}
--[[
 * @file       sv_samplemodule.lua
 * @package    Sample Module
 * @author     Aperture Development
 * @license    root_dir/LICENCE
 * @version    1.0.1
]]

--[[
    Define name, description and module identifier
]]
local info = {
    Name = "Sample Module",
    ModuleIdentifier = "SampleModule",
    Description = "A basic example module on how to create modules",
    Version = "1.0.1"
}

--[[
    Prepare Module
]]
MSync.modules.[info.ModuleIdentifier] = MSync.modules.[info.ModuleIdentifier] or {}
MSync.modules.[info.ModuleIdentifier].info = info

--[[
    Define mysql table and additional functions that are later used
]]
function MSync.modules.[info.ModuleIdentifier].init( transaction ) 
    transaction:addQuery( MSync.DBServer:query([[
        CREATE TABLE IF NOT EXISTS `tbl_SampleModule` (
            SampleData INT
        );
    ]] ))
    
    function MSync.modules.[info.ModuleIdentifier].SampleFunction()
        return true
    end

end

--[[
    Define net receivers and util.AddNetworkString
]]
function MSync.modules.[info.ModuleIdentifier].net() 
    net.Receive( "my_message", function( len, pl )
        if ( IsValid( pl ) and pl:IsPlayer() ) then
            print( "Message from " .. pl:Nick() .. " received. Its length is " .. len .. "." )
        else
            print( "Message from server received. Its length is " .. len .. "." )
        end
    end )
end

--[[
    Define ulx Commands and overwrite common ulx functions (module does not get loaded until ulx has fully been loaded)
]]
function MSync.modules.[info.ModuleIdentifier].ulx() 
    
end

--[[
    Define hooks your module is listening on e.g. PlayerDisconnect
]]
function MSync.modules.[info.ModuleIdentifier].hooks() 
    hook.Add("initialize", "msync_sampleModule_init", function()
        
    end)
end

--[[
    Return info ( Just for single module loading )
]]
return MSync.modules.[info.ModuleIdentifier].info