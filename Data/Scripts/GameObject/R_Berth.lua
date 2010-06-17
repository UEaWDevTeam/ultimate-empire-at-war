-- UEAW LUA file

--Do not redistribute without permission

--Controls Capital berth launching ability at start

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

        Define_State("State_Init", State_Init)
end

function State_Init(message) --initialise

        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end

        if message == OnEnter then --unit has entered the game
				Owner = Object.Get_Owner()
				 
				empire_list_0 = 
				{
					"R_VENATOR"
				}
				ReinforceList(empire_list_0, Object.Get_Bone_Position("SPAWN_00"), Owner, true, true, true) 
		elseif message == OnUpdate then --if the unit is doing something
			
		end
end