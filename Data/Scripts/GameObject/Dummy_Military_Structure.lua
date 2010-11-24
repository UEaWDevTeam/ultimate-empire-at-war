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
		
		if message == OnExit then
			is_only_structure = true
			structures = Find_All_Objects_Of_Type("MILITARY_STRUCTURE_1")
			for i, obj in pairs(structures) do
				if(obj.Get_Planet_Location() == Object.Get_Planet_Location) then
					is_only_structure = false
				end
			end
			
			if(is_only_structure) then
				Planet = Object.Get_Planet_Location()
				Owner = Object.Get_Owner()
				spawn_list = { "DUMMY_MILITARY_STRUCTURE" }
				SpawnList(spawn_list,Planet,Owner,false,false)
			end
		end
end