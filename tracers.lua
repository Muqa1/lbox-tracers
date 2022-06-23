local width, height = draw.GetScreenSize()

local function update()

    local players = entities.FindByClass("CTFPlayer")
    local localPlayer = entities.GetLocalPlayer()

    for i, p in ipairs( players ) do

        if p:IsAlive() and not (p == localPlayer) and not p:IsDormant() then

            local distance = vector.Distance(localPlayer:GetAbsOrigin(),p:GetAbsOrigin())

            local opacity = math.floor(255 / distance * 500)

            if (opacity < 20) then
                opacity = 20
            end

            if (opacity > 255) then 
                opacity = 255
            end

            draw.Color(255, 255, 255, opacity)

            local screenPos = client.WorldToScreen( p:GetAbsOrigin() )
            local team = p:GetTeamNumber()

            if (team == 3) then
                draw.Color(0, 0, 255, opacity)
            end
            if (team == 2) then
                draw.Color(255, 0, 0, opacity)
            end

            if screenPos ~= nil then
                draw.Text(screenPos[1], screenPos[2],distance)
                draw.Line(width/2,height/2, screenPos[1], screenPos[2])
            end
            
        end
    end
end

callbacks.Register("Draw", "draw", update)
