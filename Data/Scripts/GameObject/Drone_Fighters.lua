-- UEAW LUA file

--Do not redistribute without permission

--Controls non-independent droid starfighter behaviour

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

        Define_State("State_Init", State_Init)
		
		ServiceRate = 0.5

end

function State_Init(message) --initialise

        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end

        if message == OnEnter then --unit has entered the game
             

		elseif message == OnUpdate then --if the unit is doing something
			
		        carrier_list = Find_All_Objects_Of_Type("C_PROVIDENCE") --find all carrier units
				
			    if table.getn(carrier_list) > 0  then
					
					Find_Nearest_Carrier("C_PROVIDENCE", 2000)
					
				else
				
					Fighter_Killer()
				
				end

			
			
		end
	
end

function Find_Nearest_Carrier(carrier_type, control_range)

	nearest_carrier = Find_Nearest(Object, carrier_type, PlayerObject)
	carrier_distance = Object.Get_Distance(nearest_carrier)
	
		if(carrier_distance > control_range) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end

end
	
function Fighter_Killer()
	
	Sleep(5)
	Object.Take_Damage(1000)

end

