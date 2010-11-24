--      UU    UU    EEEEEEEE     AAAA     WW   WW   WW
--      UU    UU    EE         AA    AA   WW   WW   WW
--      UU    UU    EEEEE      AAAAAAAA   WW   WW   WW
--      UU    UU    EE         AA    AA    WW WWWW WW
--       UUUUUU     EEEEEEEE   AA    AA      WW  WW
-- © UEAW Team
--Controls Upgrade of Structures

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

	DebugMessage("%s -- In Definitions", tostring(Script))
	Define_State("State_Init", State_Init);

end

function State_Init(message)
			if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
				if message == OnEnter then
				Planet = Object.Get_Planet_Location()
				--Structure which has to be demolished
				structures = Find_All_Objects_Of_Type("DUMMY_MILITARY_STRUCTURE")
				for i, obj in pairs(structures) do
					if(obj.Get_Planet_Location() == Planet) then
						obj.Despawn()
					end
				end
			end
		
			if message == OnExit then
				Planet = Object.Get_Planet_Location()
				Owner = Object.Get_Owner()
				spawn_list = { "DUMMY_MILITARY_STRUCTURE" }
				SpawnList(spawn_list,Planet,Owner,false,false)
			end
		else
			if message == OnEnter then
				Owner = Object.Get_Owner()
				if(Owner == "CIS") then
					structure_level_1 = { "DS_SENSOR_RELAY" }
				end
				marker_list_level_1 = Find_All_Objects_Of_Type("Sensor_Relay")
				for i, obj in pairs(marker_list_level_1) do
					ReinforceList(marker_list_level_1
				end
			end
		end
		
end