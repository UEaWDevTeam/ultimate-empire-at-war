-- UEAW LUA file

--Do not redistribute without permission

--Controls non-independant droid starfighter behaviour

require ("PGStateMachine")

function Definitions ()

	Define_State("State_Init", State_Init)
	
	ServiceRate = 1 --set repeat rate of the check
	
end

function State_Init(message) --initialise	
	
	if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
		ScriptExit()
	end
	 
	if message == OnEnter then --unit has entered the game
		
		providence = Find_All_Objects_Of_Type("C_PROVIDENCE") --find all carrier units
		--recusant = Find_All_Objects_Of_Type("C_RECUSANT")
		--recusant_variant = Find_All_Objects_Of_Type("C_RECUSANT_CARRIER")
		--lucrehulk = Find_All_Objects_Of_Type("C_LUCREHULK")
		--lucrehulk_battleship = Find_All_Objects_Of_Type("C_LUCREHULK_BATTLESHIP")
	
		carrier_list = {providence}--, recusant, recusant_variant, lucrehulk, lucrehulk_battleship --put them all in a list
		
		returning_to_carrier = false --not returning yet
		
	elseif message == OnUpdate then --if the unit is doing something
	
		repeat
			Object.Return_to_Carrier(carrier_list) --tell the unit to return to the nearest carrier unit
		until (returning_to_carrier == true) --we don't have to run the loop once the drone is returning.
		
	end
	
end

--function Distance_From_Carrier(carrierdist_list)
--	 for k, carrier in pairs(carrierdist_list) do --cycle through all carriers
--		if TestValid(carrier) then --if a carrier exists
--			carrierdist = Object.Get_Distance(Find_Nearest(Object, carrier)) --find the distance to the nearest carrier to the droid fighter
--		end
--	end
	
--	return carrierdist

--end	

function Return_to_Carrier(carrierloc_list) --define the function
	for k, unit in pairs(carrierloc_list) do --cycle through all carriers
		if TestValid(unit) then --if a carrier exists
			carrierloc = Find_Nearest(Object, unit) --find the nearest carrier to the droid fighter
			carrierdist = Object.Get_Distance(carrierloc.Get_Position())
		else
			Sleep (5)
			Object.Take_Damage(500)
			returning_to_carrier = true
		end
	end
	if carrierdist > 6000 then
		Object.Move_To(carrierloc) --move the fighter to it
		returning_to_carrier = true
	end
		
end



	
	
	
	