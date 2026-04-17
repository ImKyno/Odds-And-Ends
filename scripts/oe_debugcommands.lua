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
end