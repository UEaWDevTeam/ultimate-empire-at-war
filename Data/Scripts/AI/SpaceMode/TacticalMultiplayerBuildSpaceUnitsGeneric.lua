-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TacticalMultiplayerBuildSpaceUnitsGeneric.lua#5 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TacticalMultiplayerBuildSpaceUnitsGeneric.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 54441 $
--
--          $DateTime: 2006/09/13 15:08:39 $
--
--          $Revision: #5 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	
	Category = "Tactical_Multiplayer_Build_Space_Units_Generic"
	IgnoreTarget = true
	TaskForce = {
		{
		"ReserveForce"
		,"RS_Level_Two_Starbase_Upgrade | RS_Level_Three_Starbase_Upgrade | RS_Level_Four_Starbase_Upgrade | RS_Level_Five_Starbase_Upgrade = 0,1"
		,"ES_Level_Two_Starbase_Upgrade | ES_Level_Three_Starbase_Upgrade | ES_Level_Four_Starbase_Upgrade | ES_Level_Five_Starbase_Upgrade = 0,1"
		," = 0,1"
		," = 0,2"
		,"RA_CORELLIAN_CORVETTE | RA_CORELLIAN_GUNBOAT | RA_MARAUDER | RA_DREADNAUGHT | RA_DREADNAUGHT_REFIT | RA_EF76_HOSPITAL_FRIGATE | RA_EF76_FRIGATE | RA_MC30_FRIGATE | RA_ASSAULT_FRIGATE_I | RA_ASSAULT_FRIGATE_II | RA_MC80_HOMEONETYPE | RA_MC80_LIBERTYTYPE = 0,3"
		,"E_IPV_PATROL_CRAFT | E_TARTAN_CRUISER | E_BROADSIDE | E_DREADNAUGHT | E_ACCLAMATOR_ASSAULT_FRIGATE_I | E_ACCLAMATOR_ASSAULT_FRIGATE_II | E_INTERDICTOR_CRUISER | E_VICTORY_I | E_VICTORY_II | E_ISDI | E_ISDII = 0,3"
		," = 0,3"
		," = 0,1"
		," = 0,1"
		," = 0,1"
		}
	}
	RequiredCategories = {"Fighter | Bomber | Corvette | Frigate | Capital | SpaceHero"}
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)
		
	-- Give some time to accumulate money.
	tech_level = PlayerObject.Get_Tech_Level()
	min_credits = 2000
	max_sleep_seconds = 30
	if tech_level == 2 then
		min_credits = 4000
		max_sleep_seconds = 50
	elseif tech_level >= 3 then
		min_credits = 6000
		max_sleep_seconds = 80
	end
	
	current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end

	ScriptExit()
end