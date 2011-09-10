
require("pgevents")


function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Category = "Build_Space_Defense_Level_3"
	IgnoreTarget = true
	TaskForce = {
	{
		"StructureForce",
		"S_GALACTIC_PERIMETER_OUTPOST | C_GALACTIC_PERIMETER_OUTPOST | E_GALACTIC_PERIMETER_OUTPOST | IR_GALACTIC_PERIMETER_OUTPOST | OR_GALACTIC_PERIMETER_OUTPOST | R_GALACTIC_PERIMETER_OUTPOST | RA_GALACTIC_PERIMETER_OUTPOST | NR_GALACTIC_PERIMETER_OUTPOST = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function BaseForce_Thread()
	DebugMessage("%s -- In BaseForce_Thread.", tostring(Script))
	
	Sleep(1)
	
--	BaseForce.Set_As_Goal_System_Removable(false)
	AssembleForce(BaseForce)
	
	BaseForce.Set_Plan_Result(true)
	DebugMessage("%s -- BaseForce done!", tostring(Script));
	ScriptExit()
end

function BaseForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end