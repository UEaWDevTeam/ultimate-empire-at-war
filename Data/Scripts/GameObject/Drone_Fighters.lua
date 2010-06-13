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
			
		        providence_list = Find_All_Objects_Of_Type("C_PROVIDENCE")--find all carrier units
		        recusant_list = Find_All_Objects_Of_Type("C_RECUSANT")--find all carrier units
				recusant_carrier_list = Find_All_Objects_Of_Type("C_RECUSANT_CARRIER")--find all carrier units
				lucrehulk_list = Find_All_Objects_Of_Type("C_LUCREHULK")--find all carrier units
				lucrehulk_carrier_list = Find_All_Objects_Of_Type("C_LUCREHULK_CARRIER")--find all carrier units
	
				--Rec. Car. is founded but the fighters don't fly to it
				--but fly to other units => if/else structure never ends in rec. carrier.
				--why?
				--right you've wrote >= instead of <=
				--meh program don't see that there isn't any carrier...why? or table.getn(lucrehulk_list) > 0 or table.getn(lucrehulk_carrier_List) > 0
				--because you've forgot a >0 >< 
				--WHAT NOW? AGAIN THE SAME SHIT! DOESN'T KILL THE FIGHTERS! SEEMS AS SOMETHING WOULD BE FALSE AGAIN! NO REALLY? YOU'RE...meh
				--error is at the or-line; I've deleted the lucrehulk/lucrehulk-carrier check and everything seems fine...maybe aren't more than 3 or's allowed?
				--yeah not more than 4 conditions are allowed
			    if table.getn(providence_list) > 0 or table.getn(recusant_list) > 0 or table.getn(recusant_carrier_list) > 0  or table.getn(lucrehulk_list) > 0 then
					Find_Nearest_Function()					
									
				elseif table.getn(lucrehulk_carrier_list) > 0 then
					Find_Nearest_Function()
					
				else
				
					Fighter_Killer()
				
				end

			
			
		end
	
end

function Find_Nearest_Carrier_Distance(carrier_type)

	nearest_carrier = Find_Nearest(Object, carrier_type, PlayerObject)
	carrier_distance = Object.Get_Distance(nearest_carrier)

	return carrier_distance
end

function Check_and_Return(carrier_type)
	nearest_carrier = Find_Nearest(Object, carrier_type, PlayerObject)
	carrier_distance = Object.Get_Distance(nearest_carrier)
	if(carrier_type=="C_PROVIDENCE") then
		if(carrier_distance > 2000) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end
	elseif(carrier_type=="C_RECUSANT") then
		if(carrier_distance > 2000) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end
	elseif(carrier_type=="C_RECUSANT_CARRIER") then
		if(carrier_distance > 2000) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end
	elseif(carrier_type=="C_LUCREHULK") then
		if(carrier_distance > 2000) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end
	elseif(carrier_type=="C_LUCREHULK_CARRIER") then
		if(carrier_distance > 2000) then
			Object.Get_Parent_Object().Move_To(nearest_carrier) --move the fighter to it
			Object.Lock_Current_Orders()
		end
		
	end
	
end

function Find_Nearest_Function()
					
					
	if(table.getn(Find_All_Objects_Of_Type("C_PROVIDENCE")) > 0) then
		providence_distance = Find_Nearest_Carrier_Distance("C_PROVIDENCE")
	else
		providence_distance = 50000
	end
	
	if(table.getn(Find_All_Objects_Of_Type("C_RECUSANT")) > 0) then
		recusant_distance = Find_Nearest_Carrier_Distance("C_RECUSANT")
	else
		recusant_distance = 50000
	end
	
	if(table.getn(Find_All_Objects_Of_Type("C_RECUSANT_CARRIER")) > 0) then
		recusant_carrier_distance = Find_Nearest_Carrier_Distance("C_RECUSANT_CARRIER")
	else
		recusant_carrier_distance = 50000
	end
	
	if(table.getn(Find_All_Objects_Of_Type("C_LUCREHULK")) > 0) then
		lucrehulk_distance = Find_Nearest_Carrier_Distance("C_LUCREHULK")
	else
		lucrehulk_distance = 50000
	end
	
	if(table.getn(Find_All_Objects_Of_Type("C_LUCREHULK_CARRIER")) > 0) then
		lucrehulk_carrier_distance = Find_Nearest_Carrier_Distance("C_LUCREHULK_CARRIER")
	else
		lucrehulk_carrier_distance = 50000
	end

					
	--if I would explain this chain, I wont stop before tomorrow, so just one word: recursion
	if(providence_distance <= recusant_distance) then
		if(providence_distance <= recusant_carrier_distance) then
			if(providence_distance <= lucrehulk_distance) then
				if(providence_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_PROVIDENCE")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			else 
				if(lucrehulk_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_LUCREHULK")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
							
			end
		else
			if(recusant_carrier_distance <= lucrehulk_distance) then
				if(recusant_carrier_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_RECUSANT_CARRIER")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			else
				if(lucrehulk_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_LUCREHULK")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			end
		end
							
	else
		if(recusant_distance <= recusant_carrier_distance) then
			if(recusant_distance <= lucrehulk_distance) then
				if(recusant_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_RECUSANT")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			else
				if(lucrehulk_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_LUCREHULK")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			end
		else
			if(recusant_carrier_distance <= lucrehulk_distance) then 
				if(recusant_carrier_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_RECUSANT_CARRIER")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			else
				if(lucrehulk_distance <= lucrehulk_carrier_distance) then
					Check_and_Return("C_LUCREHULK")
				else
					Check_and_Return("C_LUCREHULK_CARRIER")
				end
			end
		end
	end
end

function Fighter_Killer()
	
	Sleep(5)
	Object.Take_Damage(1000)

end

