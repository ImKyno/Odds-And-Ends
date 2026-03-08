-- Only allow our cheat codes in debug mode.
if TUNING.OE_DEBUG_MODE then
    -- Command for revealing the minimap without freezing the game!
    function c_oerevealmap()
        local S = "local p,m=UserToPlayer(\"%s\"),TheWorld.Map local w,h=m:GetSize() StartStaticThread(function() for x=0,w,9 do for y=0,h,9 do p.player_classified.MapExplorer:RevealArea(m:GetTileCenterPoint(x,y)) end Yield() end end)"
        local s = S:format((ThePlayer or AllPlayers[1]).userid)

        if TheNet:GetIsClient() then
            TheNet:SendRemoteExecute(s)
        else
            ExecuteConsoleCommand(s)
        end
    end

    -- Command for testing food on Crock Pots.
    function c_oecookpot(warly)
        local player = ConsoleCommandPlayer()

        local x, y, z = player.Transform:GetWorldPosition()
        local n = 12
        local sector = 2 * math.pi/n
	
        for i = 1, n, 1 do
            local cookpot

            if warly then
                cookpot = SpawnPrefab("portablecookpot")
            else
                cookpot = SpawnPrefab("cookpot")
            end
		
            if cookpot then
                cookpot.Transform:SetPosition(x + 5 * math.cos(i * sector), y, z + 5 * math.sin(i * sector))
            end
        end
    end

    -- Command for testing the Mesa Biome stuff.
    function c_oemesabiome()
        local player = ConsoleCommandPlayer()
	
        if player ~= nil then
            c_select(player)

            local mesa_rock = c_findnext("oe_mesa_rock_clay")

            player.Physics:Teleport(mesa_rock.Transform:GetWorldPosition())
            player.components.inventory:Equip(c_spawn("krampus_sack", nil, true))
            
            c_give("oe_mesa_clay", 40, true)
        end
    end
end