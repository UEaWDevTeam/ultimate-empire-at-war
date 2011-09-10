require("pgevents")


function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Advance_Tech_Light_Side"
	IgnoreTarget = true
	TaskForce = {
	{
		"TechForce",
		"E2_ENHANCEMENT_V19 | E2_LIGHT_ESCORT_DEVELOPMENT | E2_HEAVY_ESCORT_DEVELOPMENT | E2_DEVELOPMENT_NEW_WEAPONS | E2_CRUISER_DEVELOPMENT | E2_ESCORT_CRUISER_DEVELOPMENT | E2_ACCEPTANCE_CLONE_ARMY | E2_HEAVY_FIGHTER_DEVELOPMENT | E2_TROOP_TRANSPORT_DEVELOPMENT | E2_REDESIGN_ACCLAMATOR | E2_ANTI_FIGHTER_FRIGATE_DEVELOPMENT | E2_DEVELOPMENT_HEAVY_CRUISERS | E2_ENHANCEMENT_VICTORY_FRIGATE | E2_HEAVY_BATTLESHIP_DEVELOPMENT | E2_ADVANCED_MATERIALS | E2_ADVANCED_DEFENCES | E2_ADVANCED_WEAPONS_SYSTEMS | E2_SUPERIOR_SYSTEMS= 1",
		"E3_STEALING_PROTOTYPES | E3_STEALING_CORVETTE_PLANS | E3_STEALING_ADV_COREVETTE_PLANS | E3_REBUILDING_OLD_CLASSES | E3_STEALING_PROTOTYPES_II | E3_DEVELOPING_HOSPITAL_FRIGATE | E3_REBUILDING_OLD_CLASSES_II | E3_REDESIGN_OLD_CLASSES_I | E3_REDESIGN_OLD_CLASSES_II | E3_CONTROL_MONCAL_DESIGNS | E3_DEVELOPING_NEW_STARFIGHTERS | E3_UPGRADE_REDESIGNS | E3_RESTRUCTURING_MONCAL_DESIGNS | E3_RESTRUCTURING_MONCAL_DESIGNS |  E3_ADVANCED_MATERIALS | E3_ADVANCED_DEFENCES | E3_ADVANCED_WEAPONS_SYSTEMS | E3_SUPERIOR_SYSTEMS = 1",
		"E4_DEVELOPMENT_SUPERIOR_FIGHTERS | E4_DEVELOPMENT_SUPERIOR_BOMBERS | E4_REDESIGN_ESCORT_SHIPS | E4_DESIGNING_NEW_CARRIER_CLASS | E4_DESIGNING_NEW_STAR_DESTROYER | E4_DEVELOPMENT_NEW_BATTLESHIP = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function TechForce_Thread()
	DebugMessage("%s -- In TechForce_Thread.", tostring(Script))
	
	-- Ensure that all goal feasability will be reevaluated based on the new production budgetting conditions
	-- (production underway that is already paid for and remains affordable under new budgets should continue)
	Purge_Goals(PlayerObject)

	TechForce.Set_As_Goal_System_Removable(false)
	
	Sleep(1)
	
	BlockOnCommand(TechForce.Produce_Force())
	TechForce.Set_Plan_Result(true)
	
	DebugMessage("%s -- TechForce done!", tostring(Script));
	ScriptExit()
end

function TechForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end