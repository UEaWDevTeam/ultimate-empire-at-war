require("pgevents")


function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Advance_Tech_Dark_Side"
	IgnoreTarget = true
	TaskForce = {
	{
		"TechForce",
		"E2_AGREEMENT_BAKTOID | E2_DEVELOPMENT_HEAVY_FIGHTERS | E2_DEVELOPMENT_HEAVY_BOMBERS | E2_DEVELOPMENT_CORVETTES | E2_AGREEMENT_HOERSCH_KESSEL | E2_DEVELOPMENT_FRIGATES | E2_DEVELOPMENT_LIGHT_DESTROYERS | E2_RESTRUCTURING_DESTROYERS | E2_DEVELOPMENT_HEAVY_DESTROYERS | E2_DEVELOPMENT_SUPERIOR_BATTLESHIPS | E2_RESTRUCTURING_BATTLESHIPS | E2_ADVANCED_MATERIALS_CIS | E2_ADVANCED_DEFENCES_CIS | E2_ADVANCED_WEAPONS_SYSTEMS_CIS | E2_SUPERIOR_SYSTEMS_CIS= 1",
		"E3_ACQUIRATION_PATROL_CRAFT | E3_DEVELOPING_NEW_PATROL_CLASS | E3_DEVELOPING_NEW_GUNSHIPS | E3_DRAFT_CLONE_WARS_SHIPS | E3_REDESIGN_CLONE_WARS_DESIGNS | E3_CONTINUE_CLONE_WARS_SHIPS | E3_GET_INTERDICTOR_PLANS | E3_REDESIGN_VICTORY_I | E3_REDESIGN_VICTORY_CLASS | E3_DEVELOPING_NEW_FIGHTERS | E3_SUPERIOR_GUNBOATS | E3_DEVELOPMENT_SUPERIOR_BATTLESHIPS | E3_DEVELOPMENT_SUPERIOR_ASSAULT_FIGHTERS | E3_DEVELOPMENT_SUPERSHIPS | E3_REVISING_OLD_BATTLESTATION_PLANS | E3_BUILDING_PROTOTYPE | E3_PLANNING_BUILDING | E3_GATHER_RESSOURCES | E3_BUILDING_DEATH_STAR_I | E3_REDESIGN_DEATH_STAR_I | E3_BUILDING_DEATH_STAR_II | E3_ADVANCED_MATERIALS_EMPIRE | E3_ADVANCED_DEFENCES_EMPIRE | E3_ADVANCED_WEAPONS_SYSTEMS_EMPIRE | E3_SUPERIOR_SYSTEMS_EMPIRE= 1",
		"E4_RESEARCHING_CLOAKING_TECHNOLOGY | E4_AUTOMATED_COMBAT_SYSTEM | E4_ADV_AF_DEFENCE | E4_DEVELOPING_NEW_RAID_TECHNOLOGY | E4_COMBINING_SUPERLASER_SUPERSHIPS = 1"
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