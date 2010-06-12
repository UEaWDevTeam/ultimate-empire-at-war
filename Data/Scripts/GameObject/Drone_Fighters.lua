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
			
				carrier_type = ""
		        carrier_list = Find_All_Objects_Of_Type("C_PROVIDENCE") + Find_All_Objects_Of_Type("C_RECUSANT_CARRIER") + Find_All_Objects_Of_Type("C_RECUSANT")--find all carrier units
				
				nearest_carrier = Find_Nearest(Object, "C_PROVIDENCE", PlayerObject) --find nearest player carrier unit
				carrier_distance = Object.Get_Distance(nearest_carrier)
				nearest_carrier = Find_Nearest(Object, "C_RECUSANT_CARRIER", PlayerObject)
				carrier_distance2 = Object.Get_Distance(nearest_carrier)
				
				--checking which unit/unit class is the nearest
				if(carrier_distance > carrier_distance2) then
					carrier_type="C_PPROVIDENCE"
				else
					carrier_distance=carrier_distance2
					carrier_type="C_RECUSANT_CARRIER"
				end
				
				nearest_carrier = Find_Nearest(Object, "C_RECUSANT", PlayerObject)
				carrier_distance2 = Object.Get_Distance(nearest_carrier)
				
				if(carrier_distance > carrier_distance2) then				
				else
					carrier_distance=carrier_distance2
					carrier_type="C_RECUSANT"
				end
				
				--nearest_carrier = Find_Nearest(Object, "C_LUCREHULK", PlayerObject)
				--carrier_distance2 = Object.Get_Distance(nearest_carrier)
				
				--if(carrier_distance > carrier_distance2) then				
				--else
					--carrier_distance=carrier_distance2
					--carrier_type="C_LUCREHULK"
				--end
				
				--nearest_carrier = Find_Nearest(Object, "C_LUCREHULK_CARRIER", PlayerObject)
				--carrier_distance2 = Object.Get_Distance(nearest_carrier)
				
				--if(carrier_distance > carrier_distance2) then
				--else
					--carrier_distance=carrier_distance2
					--carrier_type="C_LUCREHULK_CARRIER"
				--end
				

				
			    if table.getn(carrier_list) > 0 then

					--checking the distance to the next unit
					if(carrier_type=="C_PROVIDENCE") then
							if(carrier_distance > 2000) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end
					end
				
					if(carrier_type=="C_RECUSANT") then
							if(carrier_distance > 3000) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end
					end
				
					if(carrier_type=="C_RECUSANT_CARRIER") then
							if(carrier_distance > 4000) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end
					end
				
					if(carrier_type=="C_LUCREHULK") then
							if(carrier_distance > 3500) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end
					end
				
					if(carrier_type=="C_LUCREHULK_CARRIER") then
							if(carrier_distance > 5000) then
								Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
								Object.Lock_Current_Orders()
							end
					end
				
				
				
				else
				
				Object.Take_Damage(1000)
				
				end

			
			
		end
	
end








