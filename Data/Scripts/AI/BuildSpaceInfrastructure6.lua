
require("pgevents")


function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))

	Category = "Build_Space_Infrastructure_6"
	IgnoreTarget = true
	TaskForce = {
	{
		"StructureForce",
		"DS_ORBITAL_MANUFACTURING | LS_ORBITAL_MANUFACTURING = 1"
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
ends