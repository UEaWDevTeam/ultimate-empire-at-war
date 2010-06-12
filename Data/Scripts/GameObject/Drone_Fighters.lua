-- UEAW LUA file

--Do not redistribute without permission

--Controls non-independent droid starfighter behaviour

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

        Define_State("State_Init", State_Init)
		
		ServiceRate = 0.2

end

function State_Init(message) --initialise

        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end

        if message == OnEnter then --unit has entered the game

                

		elseif message == OnUpdate then --if the unit is doing something
			
		        carrier_list = Find_All_Objects_Of_Type("C_PROVIDENCE") --find all carrier units

				nearest_carrier = Find_Nearest(Object, "C_PROVIDENCE", PlayerObject) --find nearest player carrier unit
				carrier_distance = Object.Get_Distance(nearest_carrier)
				

				
			    if table.getn(carrier_list) > 0  then

					--checking the distance to the next unit
							if(carrier_distance > 2000) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end

				
				
				
				else
				
				Sleep(5)
				Object.Take_Damage(1000)
				
				end

			
			
		end
	
end








