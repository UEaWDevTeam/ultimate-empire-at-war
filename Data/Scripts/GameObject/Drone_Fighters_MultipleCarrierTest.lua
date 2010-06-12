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
		
				player = Object.Get_Owner()
			
		        providence_list = Find_All_Objects_Of_Type("C_PROVIDENCE") --find all carrier units
				recusant_list = Find_All_Objects_Of_Type("C_RECUSANT") 
				recusant_variant_list = Find_All_Objects_Of_Type("C_RECUSANT_CARRIER") 
				lucrehulk_list = Find_All_Objects_Of_Type("C_LUCREHULK")

				if table.getn(lucrehulk_list) > 0 then

					nearest_lucrehulk = Find_Nearest(Object, "C_LUCREHULK", PlayerObject) --find nearest player carrier unit
					lucrehulk_distance = Object.Get_Distance(nearest_lucrehulk)
	
					--checking the distance to the next unit
							if(lucrehulk_distance > 8000) then
								Object.Get_Parent_Object().Move_To(nearest_lucrehulk) --move the fighter to it
								Object.Lock_Current_Orders()
							end

				elseif table.getn(providence_list) > 0 then
				
					nearest_providence = Find_Nearest(Object, "C_PROVIDENCE", PlayerObject) --find nearest player carrier unit
					providence_distance = Object.Get_Distance(nearest_providence)
	
					--checking the distance to the next unit
							if(providence_distance > 5000) then
								Object.Get_Parent_Object().Move_To(nearest_providence) --move the fighter to it
								Object.Lock_Current_Orders()
							end
							
				elseif table.getn(recusant_variant_list) > 0 then
				
					nearest_recusant_variant = Find_Nearest(Object, "C_RECUSANT_CARRIER", PlayerObject) --find nearest player carrier unit
					recusant_variant_distance = Object.Get_Distance(nearest_recusant_variant)
	
					--checking the distance to the next unit
							if(recusant_variant_distance > 4000) then
								Object.Get_Parent_Object().Move_To(nearest_recusant_variant) --move the fighter to it
								Object.Lock_Current_Orders()
							end
							
				elseif table.getn(recusant_list) > 0 then
				
					nearest_recusant = Find_Nearest(Object, "C_RECUSANT", PlayerObject) --find nearest player carrier unit
					recusant_distance = Object.Get_Distance(nearest_recusant)
	
					--checking the distance to the next unit
							if(recusant_distance > 5000) then
								Object.Get_Parent_Object().Move_To(nearest_recusant) --move the fighter to it
								Object.Lock_Current_Orders()
							end
										
				
				else
				
				Sleep(5)
				Object.Take_Damage(1000)
				
				end

			
			
		end
	
end








