--[[
The contents of this file are subject to the Common Public Attribution
License Version 1.0 (the "License"); you may not use this file except in
compliance with the License. You may obtain a copy of the License at
http://ultimate-empire-at-war.com/cpal. The License is based on the Mozilla
Public License Version 1.1 but Sections 14 and 15 have been added to cover
use of software over a computer network and provide for limited attribution
for the Original Developer. In addition, Exhibit A has been modified to be
consistent with Exhibit B.
    
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.
    
The Original Code is Ultimate Empire at War.
    
The Original Developer is the Initial Developer. The Initial Developer of the
Original Code is the Ultimate Empire at War team. All portions of the code
written by the Ultimate Empire at War team are Copyright (c) 2012.
All Rights Reserved. ]]
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PurchaseLandUpgradesGeneric.lua#6 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PurchaseLandUpgradesGeneric.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 56734 $
--
--          $DateTime: 2006/10/24 14:15:48 $
--
--          $Revision: #6 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	
	Category = "Purchase_Land_Upgrades_Generic"
	IgnoreTarget = true
	TaskForce = {
	{
		"ReserveForce"
		,"DenySpecialWeaponAttach"
		,"DenyHeroAttach"
		
		-- Even though only one can be purchased, the 0,10 should increase the liklihood of items from these lists being chosen.
		,"EL_Increased_Mobility_Upgrade | EL_Stamina_Boost_Upgrade | EL_Light_Reflective_Armor_L1_Upgrade | EL_Light_Reflective_Armor_L2_Upgrade | EL_Enhanced_Reactors_L1_Upgrade | EL_Enhanced_Reactors_L2_Upgrade | EL_Heavy_Reflective_Armor_L1_Upgrade | EL_Heavy_Reflective_Armor_L2_Upgrade | EL_Improved_ATAT_Reactors_L1_Upgrade | EL_Improved_ATAT_Reactors_L2_Upgrade | EL_Increased_Production_L1_Upgrade | EL_Increased_Production_L2_Upgrade | EL_Bombing_Run_Use_Upgrade | EL_Reinforced_Structures_Upgrade | EL_Enhanced_Turret_Firepower_L1_Upgrade | EL_Enhanced_Turret_Firepower_L2_Upgrade | EL_Enhanced_Base_Shield_Upgrade | EL_More_Garrisons_L1_Upgrade | EL_Weatherproof_Upgrade | EL_Planetary_Bombard_Use_Upgrade | E_Magnetically_Sealed_Structure_Upgrade | E_Secure_Area_Upgrade = 0,10"
		,"EL_Increased_Mobility_Upgrade_NoPre | EL_Stamina_Boost_Upgrade_NoPre | EL_Enhanced_Reactors_L1_Upgrade_NoPre | EL_Enhanced_Reactors_L2_Upgrade_NoPre | EL_Heavy_Reflective_Armor_L1_Upgrade_NoPre | EL_Heavy_Reflective_Armor_L2_Upgrade_NoPre = 0,10"
		,"EL_Scout_Trooper_Research_Upgrade | EL_ATAA_Research_Upgrade | EL_ATST_Research_Upgrade | EL_M1_Tank_Research_Upgrade | EL_SPMAT_Research_Upgrade | EL_ATAT_Research_Upgrade | EL_Enhanced_Deployment_L1_Upgrade = 0,1"

		,"RL_Combat_Armor_L1_Upgrade | RL_Combat_Armor_L2_Upgrade | RL_Light_Armor_L1_Upgrade | RL_Light_Armor_L2_Upgrade | RL_Enhanced_Repulsors_L1_Upgrade | RL_Enhanced_Repulsors_L2_Upgrade | RL_Heavy_Armor_L1_Upgrade | RL_Heavy_Armor_L2_Upgrade | RL_Improved_Treads_L1_Upgrade | RL_Improved_Treads_L2_Upgrade | RL_Improved_T4B_Damage_L1_Upgrade | RL_Improved_T4B_Damage_L2_Upgrade | RL_Increased_Production_L1_Upgrade | RL_Increased_Production_L2_Upgrade | RL_Bombing_Run_Use_Upgrade | RL_Reinforced_Structures_Upgrade | RL_Enhanced_Turret_Firepower_L1_Upgrade | RL_Enhanced_Turret_Firepower_L2_Upgrade | RL_Enhanced_Base_Shield_Upgrade | RL_More_Garrisons_L1_Upgrade | RL_Weatherproof_Upgrade | RL_Planetary_Bombard_Use_Upgrade | R_Magnetically_Sealed_Structure_Upgrade | R_Secure_Area_Upgrade= 0,10"
		,"RL_Combat_Armor_L1_Upgrade_NoPre | RL_Combat_Armor_L2_Upgrade_NoPre | RL_Enhanced_Repulsors_L1_Upgrade_NoPre | RL_Enhanced_Repulsors_L2_Upgrade_NoPre | RL_Improved_Treads_L1_Upgrade_NoPre | RL_Improved_Treads_L2_Upgrade_NoPre = 0,10"
		,"RL_Plex_Soldier_Research_Upgrade | RL_Infiltrator_Research_Upgrade | RL_T2B_Research_Upgrade | RL_Snowspeeder_Research_Upgrade | RL_T4B_Research_Upgrade | RL_MPTL_Research_Upgrade | RL_Enhanced_Deployment_L1_Upgrade = 0,1"
		
		,"UL_Bounty_Upgrade | UL_Smuggled_Droid_Systems_L1_Upgrade | UL_MDU_Armor_Plating_L2_Upgrade | UL_Weapon_Boost_L1_Upgrade | UL_Weapon_Boost_L2_Upgrade | UL_Smuggled_Droid_Systems_L2_Upgrade | UL_Extort_Cash_L1_Upgrade | UL_Extort_Cash_L2_Upgrade | U_Magnetically_Sealed_Structure_Upgrade | UL_Planetary_Bombard_Use_Upgrade | UL_Bombing_Run_Use_Upgrade | U_Secure_Area_Upgrade = 0,10"
		,"UL_Black_Market_Shielding_L1_Upgrade | UL_Black_Market_Shielding_L2_Upgrade | UL_MDU_Armor_Plating_L1_Upgrade | UL_Rancor_Stimulant_L1_Upgrade | UL_Rancor_Stimulant_L2_Upgrade | UL_Enhanced_Deployment_L1_Upgrade = 0,1"
	}
	}
	 
	RequiredCategories = {"Upgrade"}
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)
	BlockOnCommand(ReserveForce.Produce_Force())

	-- Give some time to accumulate money.
	tech_level = PlayerObject.Get_Tech_Level()
	min_credits = 2000
	if tech_level == 2 then
		min_credits = 3000
	elseif tech_level >= 3 then
		min_credits = 4000
	end
	
	max_sleep_seconds = 50
	current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end
		
	ScriptExit()
end


