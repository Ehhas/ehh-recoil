CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        for i, v in pairs(Config.Weapons) do
            if weapon == i then
                if IsPedShooting(ped) then
                    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', v.shake)
                end
            end
        end
        if IsPedShooting(ped) and not IsPedDoingDriveby(ped) then
            local isFirstPerson = GetFollowPedCamViewMode()
            
            if Config.Weapons[weapon] and Config.Weapons[weapon].recoil and Config.Weapons[weapon].recoil ~= 0 then
                local recoilAmount = Config.Weapons[weapon].recoil
                local cr = 0
                local pitchAdjustment = isFirstPerson == 4 and 0.2 or 0.06
                local speed = isFirstPerson == 4 and 0.1 or 0.8
                
                repeat 
                    Wait(0)
                    local currentPitch = GetGameplayCamRelativePitch()
                    local newPitch = currentPitch + pitchAdjustment
                    
                    if GetFollowPedCamViewMode() == 4 then
                        SetGameplayCamRelativePitch(newPitch, speed)
                    else
                        SetGameplayCamRelativePitch(newPitch, speed)
                        local currentHeading = GetGameplayCamRelativeHeading()
                        SetGameplayCamRelativeHeading(currentHeading + (pitchAdjustment * 0.2))
                    end
                    
                    cr = cr + pitchAdjustment
                until cr >= recoilAmount
            end
        end
    end
end)