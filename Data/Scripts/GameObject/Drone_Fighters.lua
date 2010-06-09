-- UEAW LUA file

--Do not redistribute without permission

--Controls non-independent droid starfighter behaviour

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
		
		Object.Get_Owner().Give_Money(1)
		
		returning_to_carrier = false --not returning yet
		
	elseif message == OnUpdate then --if the unit is doing something
	
		Object.Get_Owner().Give_Money(10)
	
		carrier_list = Find_All_Objects_Of_Type("C_PROVIDENCE", "C_RECUSANT", "C_RECUSANT_CARRIER", "C_LUCREHULK", "C_LUCREHULK_BATTLESHIP") --find all carrier units
	
		repeat
			Return_to_Carrier(carrier_list, Object) --tell the unit to return to the nearest carrier unit if necessary
		until (returning_to_carrier == true) --we don't have to run the loop once the drone is returning.
		
	end
	
end

function Return_to_Carrier(carrierloc_list, fighter) --define the function
	for k, unit in pairs(carrierloc_list) do --cycle through all carriers
		if TestValid(unit) and (unit.Get_Owner() == fighter.Get_Owner()) then --if a carrier exists and is owned by the fighter
			fighter.Get_Owner().Give_Money(10000)	
		
			carrierloc = Find_Nearest(fighter, unit) --find the nearest carrier to the droid fighter
			carrierdist = fighter.Get_Distance(unit)
			
			if carrierdist > 6000 then
				fighter.Get_Owner().Give_Money(100)
				fighter.Move_To(carrierloc) --move the fighter to it
				fighter.Lock_Current_Orders() --lock the move order until complete
				returning_to_carrier = true --the unit is returning to the carrier
			else
				fighter.Get_Owner().Give_Money(1000)
				returning_to_carrier = false
			end
		else
			fighter.Get_Owner().Give_Money(500)
			Sleep (5)
			fighter.Take_Damage(500) --kill the fighter after 5 seconds if no carrier is found
			returning_to_carrier = true
		end
	end
	
		
end



	
	
	
	