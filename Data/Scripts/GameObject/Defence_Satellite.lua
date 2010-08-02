-- UEAW LUA file

--Do not redistribute without permission

--Controls Defence satellite placement over the map
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
        satmarker_list = Find_All_Objects_Of_Type("Orbital_Defence_Pods")
		Owner = Object.Get_Owner()

		for i, sat in pairs(satmarker_list) do
			if i == 1 then
			
			else
				if TestValid(sat) then
					spawn_satellite = Spawn_Unit(Find_Object_Type("ORBITAL_DEFENCE_POD_SINGLE"), sat, Owner)				
				end
			end
		end

		elseif message == OnUpdate then --if the unit is doing something

			
			
		end
	
end