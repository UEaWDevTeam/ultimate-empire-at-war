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

-- Ultimate Empire at War V1 Space Skirmish build objects code

require("pgevents")


function Definitions()
	
	Category = "Tactical_Multiplayer_Build_Space_Units_Generic"
	IgnoreTarget = true
	TaskForce = {
		{
		"ReserveForce"
		,"OR_Starbase_Upgrade_Level_2 | OR_Starbase_Upgrade_Level_3 | OR_Starbase_Upgrade_Level_4 | OR_Starbase_Upgrade_Level_5 = 0,1"
		,"S_Starbase_Upgrade_Level_2 | S_Starbase_Upgrade_Level_3 | S_Starbase_Upgrade_Level_4 | S_Starbase_Upgrade_Level_5 = 0,1"
		,"R_Starbase_Upgrade_Level_2 | R_Starbase_Upgrade_Level_3 | R_Starbase_Upgrade_Level_4 | R_Starbase_Upgrade_Level_5 = 0,1"
		,"RS_Level_Two_Starbase_Upgrade | RS_Level_Three_Starbase_Upgrade | RS_Level_Four_Starbase_Upgrade | RS_Level_Five_Starbase_Upgrade = 0,1"
		,"ES_Level_Two_Starbase_Upgrade | ES_Level_Three_Starbase_Upgrade | ES_Level_Four_Starbase_Upgrade | ES_Level_Five_Starbase_Upgrade = 0,1"
		,"NR_Starbase_Upgrade_Level_2 | NR_Starbase_Upgrade_Level_3 | NR_Starbase_Upgrade_Level_4 | NR_Starbase_Upgrade_Level_5 = 0,1"
		,"IR_Starbase_Upgrade_Level_2 | IR_Starbase_Upgrade_Level_3 | IR_Starbase_Upgrade_Level_4 | IR_Starbase_Upgrade_Level_5 = 0,1"
		,"C_Starbase_Upgrade_Level_2 | C_Starbase_Upgrade_Level_3 | C_Starbase_Upgrade_Level_4 | C_Starbase_Upgrade_Level_5 = 0,1"
		,"OR_AUREK_SQUADRON | OR_CHELA_SQUADRON | OR_FORAY_CLASS | OR_HAMMERHEAD | OR_PRAETORIAN | OR_THRANTA | OR_HEAVY_CRUISER | OR_INEXPUGNABLE | OR_CENTURION = 0,3"
		,"S_SITH_FIGHTER_SQUADRON | S_SITH_BOMBER_SQUADRON | S_SITH_GUNBOAT_SQUADRON | S_INTERDICTOR_CRUISER | S_CENTURION | S_SITH_STAR_DESTROYER = 0,3"
		,"R_ARC-170_SQUADRON | R_V19_TORRENT_SQUADRON | R_NTB_630_SQUADRON | R_CONSULAR_CLASS | R_LIGHT_CRUISER | R_VICTORY_FRIGATE | R_CARRACK_CRUISER | R_ACCLAMATOR_ASSAULT_FRIGATE_I | R_ACCLAMATOR_ASSAULT_FRIGATE_II | R_DREADNAUGHT | R_VICTORY_I | R_VENATOR = 0,3"
		,"C_VULTURE_DROID_SQUADRON | C_TRI_FIGHTER_SQUADRON | C_DROID_BOMBER_SQUADRON | C_HYENA_SQUADRON | C_MISSILE_FRIGATE | C_MUNIFICENT | C_RECUSANT_CARRIER | C_RECUSANT | C_PROVIDENCE | C_LUCREHULK | C_LUCREHULK_CARRIER = 0,3"
		,"RA_Z-95_SQUADRON| RA_X-WING_SQUADRON | RA_A-WING_SQUADRON | RA_Y-WING_SQUADRON | RA_B-WING_SQUADRON | RA_CORELLIAN_CORVETTE | RA_CORELLIAN_GUNBOAT | RA_MARAUDER | RA_MARAUDER_DB | RA_DREADNAUGHT | RA_DREADNAUGHT_REFIT | RA_EF76_HOSPITAL_FRIGATE | RA_EF76_FRIGATE | RA_MC30_FRIGATE | RA_ASSAULT_FRIGATE_I | RA_ASSAULT_FRIGATE_II | RA_MC80_HOMEONETYPE | RA_MC80_LIBERTYTYPE = 0,3"
		,"E_TIE_SCOUT_SQUADRON | E_TIE_FIGHTER_SQUADRON | E_TIE_INTERCEPTOR_SQUADRON | E_TIE_BOMBER_SQUADRON | E_TIE_DEFENDER_SQUADRON | E_XG_STAR_WING_SQUADRON | E_TARTAN_CRUISER | E_IPV_PATROL_CRAFT | E_BROADSIDE | E_BROADSIDE_DB | E_INTERDICTOR_CRUISER | E_ACCLAMATOR_ASSAULT_FRIGATE_I | E_ACCLAMATOR_ASSAULT_FRIGATE_II | E_DREADNAUGHT | E_DREADNAUGHT_REFIT | E_VICTORY_I | E_VICTORY_II | E_ISDI | E_ISDII = 0,3"
		,"NR_X-WING_SQUADRON | NR_A-WING_SQUADRON | NR_Y-WING_SQUADRON | NR_B-WING_SQUADRON | NR_E-WING_SQUADRON | NR_K-WING_SQUADRON | NR_K-WING_ESCORT_SQUADRON | NR_CORELLIAN_GUNBOAT | NR_QUASAR_FIRE_CRUISER | NR_MARAUDER | NR_MARAUDER_DB | NR_EF76_HOSPITAL_FRIGATE | NR_EF76_FRIGATE | NR_MC30_FRIGATE | NR_ASSAULT_FRIGATE_I | NR_ASSAULT_FRIGATE_II | NR_DREADNAUGHT_REFIT | NR_MC80_HOMEONETYPE | NR_MC80_LIBERTYTYPE | NR_MC90 = 0,3"
		,"IR_TIE_SCOUT_SQUADRON | IR_TIE_FIGHTER_SQUADRON | IR_TIE_INTERCEPTOR_SQUADRON | IR_TIE_BOMBER_SQUADRON | IR_TIE_DEFENDER_SQUADRON | IR_XG_STAR_WING_SQUADRON | IR_TIE_PHANTOM_SQUADRON | IR_TIE_DROID_SQUADRON | IR_TARTAN_CRUISER | IR_IPV_PATROL_CRAFT | IR_LANCER_FRIGATE | IR_BROADSIDE | IR_BROADSIDE_DB | IR_ACCLAMATOR_ASSAULT_FRIGATE_I | IR_ACCLAMATOR_ASSAULT_FRIGATE_II | IR_STRIKE_CLASS_CRUISER | IR_INTERDICTOR_CRUISER | IR_DREADNAUGHT_REFIT | IR_VICTORY_I | IR_VICTORY_II | IR_ISDI | IR_ISDII | IR_ECLIPSE = 0,3"
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
	max_sleep_seconds = 20
	if tech_level == 2 then
		min_credits = 4000
		max_sleep_seconds = 25
	elseif tech_level >= 3 then
		min_credits = 6000
		max_sleep_seconds = 40
	end
	
	current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end

	ScriptExit()
end