Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(5000) -- Every X ms you'll get paid (300000 = 5 min)
		TriggerServerEvent('vrp:xp_increase')
	end
end)

RegisterNetEvent('notify:level_up')
AddEventHandler('notify:level_up', function(level)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
            function Initialize(scaleform)
                local scaleform = RequestScaleformMovie(scaleform)
                while not HasScaleformMovieLoaded(scaleform) do
                    Citizen.Wait(0)
                end
                PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                PushScaleformMovieFunctionParameterString("~y~Zentrix ~w~| ~b~Level up")
                PushScaleformMovieFunctionParameterString("~w~Ai luat ~b~level "..level.."~w~!")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
                Citizen.SetTimeout(5000, function()
                    PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
                    PushScaleformMovieFunctionParameterInt(1)
                    PushScaleformMovieFunctionParameterFloat(0.33)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
                end)
                return scaleform
            end

            scaleform = Initialize("mp_big_message_freemode")

            while true do
                Citizen.Wait(0)
                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            end
    end)
end)