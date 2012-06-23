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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/PurchaseSpaceUpgradesGeneric.lua#5 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/PurchaseSpaceUpgradesGeneric.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 55010 $
--
--          $DateTime: 2006/09/19 19:14:06 $
--
--          $Revision: #5 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	
	Category = "Purchase_Space_Upgrades_Generic"
	IgnoreTarget = true
	TaskForce = {
	{
		"ReserveForce"
		,"DenySpecialWeaponAttach"
		,"DenyHeroAttach"  
		,"OR_SMALL_SHIPS_UPGRADE_L_1 | OR_SMALL_SHIPS_UPGRADE_L_2 | OR_SMALL_SHIPS_UPGRADE_L_3 | OR_MEDIUM_SHIPS_UPGRADE_L_1 | OR_MEDIUM_SHIPS_UPGRADE_L_2 | OR_MEDIUM_SHIPS_UPGRADE_L_3 | OR_HUGE_SHIPS_UPGRADE_L_1 | OR_HUGE_SHIPS_UPGRADE_L_2 | OR_HUGE_SHIPS_UPGRADE_L_3 | OR_STARBASE_UPGRADE_L_1 | OR_STARBASE_UPGRADE_L_2 | OR_STARBASE_UPGRADE_L_3 | OR_Increased_Supplies_L1_Upgrade | OR_Increased_Supplies_L2_Upgrade | OR_Increased_Supplies_L3_Upgrade | OR_UPGRADE_SATELLITES_L_1 | OR_UPGRADE_SATELLITES_L_2 | OR_UPGRADE_SATELLITES_L_3 = 0,2" 
		,"S_SMALL_SHIPS_UPGRADE_L_1 | S_SMALL_SHIPS_UPGRADE_L_2 | S_SMALL_SHIPS_UPGRADE_L_3 | S_MEDIUM_SHIPS_UPGRADE_L_1 | S_MEDIUM_SHIPS_UPGRADE_L_2 | S_MEDIUM_SHIPS_UPGRADE_L_3 | S_HUGE_SHIPS_UPGRADE_L_1 | S_HUGE_SHIPS_UPGRADE_L_2 | S_HUGE_SHIPS_UPGRADE_L_3 | S_STARBASE_UPGRADE_L_1 | S_STARBASE_UPGRADE_L_2 | S_STARBASE_UPGRADE_L_3 | S_Increased_Supplies_L1_Upgrade | S_Increased_Supplies_L2_Upgrade | S_Increased_Supplies_L3_Upgrade | S_UPGRADE_SATELLITES_L_1 | S_UPGRADE_SATELLITES_L_2 | S_UPGRADE_SATELLITES_L_3 = 0,2"
		,"C_SMALL_SHIPS_UPGRADE_L_1 | C_SMALL_SHIPS_UPGRADE_L_2 | C_SMALL_SHIPS_UPGRADE_L_3 | C_MEDIUM_SHIPS_UPGRADE_L_1 | C_MEDIUM_SHIPS_UPGRADE_L_2 | C_MEDIUM_SHIPS_UPGRADE_L_3 | C_HUGE_SHIPS_UPGRADE_L_1 | C_HUGE_SHIPS_UPGRADE_L_2 | C_HUGE_SHIPS_UPGRADE_L_3 | C_STARBASE_UPGRADE_L_1 | C_STARBASE_UPGRADE_L_2 | C_STARBASE_UPGRADE_L_3 | C_Increased_Supplies_L1_Upgrade | C_Increased_Supplies_L2_Upgrade | C_Increased_Supplies_L3_Upgrade | C_UPGRADE_SATELLITES_L_1 | C_UPGRADE_SATELLITES_L_2 | C_UPGRADE_SATELLITES_L_3 = 0,2"
		,"R_SMALL_SHIPS_UPGRADE_L_1 | R_SMALL_SHIPS_UPGRADE_L_2 | R_SMALL_SHIPS_UPGRADE_L_3 | R_MEDIUM_SHIPS_UPGRADE_L_1 | R_MEDIUM_SHIPS_UPGRADE_L_2 | R_MEDIUM_SHIPS_UPGRADE_L_3 | R_HUGE_SHIPS_UPGRADE_L_1 | R_HUGE_SHIPS_UPGRADE_L_2 | R_HUGE_SHIPS_UPGRADE_L_3 | R_STARBASE_UPGRADE_L_1 | R_STARBASE_UPGRADE_L_2 | R_STARBASE_UPGRADE_L_3 | R_Increased_Supplies_L1_Upgrade | R_Increased_Supplies_L2_Upgrade | R_Increased_Supplies_L3_Upgrade | R_UPGRADE_SATELLITES_L_1 | R_UPGRADE_SATELLITES_L_2 | R_UPGRADE_SATELLITES_L_3 = 0,2"
		,"E_SMALL_SHIPS_UPGRADE_L_1 | E_SMALL_SHIPS_UPGRADE_L_2 | E_SMALL_SHIPS_UPGRADE_L_3 | E_MEDIUM_SHIPS_UPGRADE_L_1 | E_MEDIUM_SHIPS_UPGRADE_L_2 | E_MEDIUM_SHIPS_UPGRADE_L_3 | E_HUGE_SHIPS_UPGRADE_L_1 | E_HUGE_SHIPS_UPGRADE_L_2 | E_HUGE_SHIPS_UPGRADE_L_3 | E_STARBASE_UPGRADE_L_1 | E_STARBASE_UPGRADE_L_2 | E_STARBASE_UPGRADE_L_3 | E_Increased_Supplies_L1_Upgrade | E_Increased_Supplies_L2_Upgrade | E_Increased_Supplies_L3_Upgrade | E_UPGRADE_SATELLITES_L_1 | E_UPGRADE_SATELLITES_L_2 | E_UPGRADE_SATELLITES_L_3 = 0,2"         
		,"RA_SMALL_SHIPS_UPGRADE_L_1 | RA_SMALL_SHIPS_UPGRADE_L_2 | RA_SMALL_SHIPS_UPGRADE_L_3 | RA_MEDIUM_SHIPS_UPGRADE_L_1 | RA_MEDIUM_SHIPS_UPGRADE_L_2 | RA_MEDIUM_SHIPS_UPGRADE_L_3 | RA_HUGE_SHIPS_UPGRADE_L_1 | RA_HUGE_SHIPS_UPGRADE_L_2 | RA_HUGE_SHIPS_UPGRADE_L_3 | RA_STARBASE_UPGRADE_L_1 | RA_STARBASE_UPGRADE_L_2 | RA_STARBASE_UPGRADE_L_3 | RA_Increased_Supplies_L1_Upgrade | RA_Increased_Supplies_L2_Upgrade | RA_Increased_Supplies_L3_Upgrade | RA_UPGRADE_SATELLITES_L_1 | RA_UPGRADE_SATELLITES_L_2 | RA_UPGRADE_SATELLITES_L_3 = 0,2"
		,"IR_SMALL_SHIPS_UPGRADE_L_1 | IR_SMALL_SHIPS_UPGRADE_L_2 | IR_SMALL_SHIPS_UPGRADE_L_3 | IR_MEDIUM_SHIPS_UPGRADE_L_1 | IR_MEDIUM_SHIPS_UPGRADE_L_2 | IR_MEDIUM_SHIPS_UPGRADE_L_3 | IR_HUGE_SHIPS_UPGRADE_L_1 | IR_HUGE_SHIPS_UPGRADE_L_2 | IR_HUGE_SHIPS_UPGRADE_L_3 | IR_STARBASE_UPGRADE_L_1 | IR_STARBASE_UPGRADE_L_2 | IR_STARBASE_UPGRADE_L_3 | IR_Increased_Supplies_L1_Upgrade | IR_Increased_Supplies_L2_Upgrade | IR_Increased_Supplies_L3_Upgrade | IR_UPGRADE_SATELLITES_L_1 | IR_UPGRADE_SATELLITES_L_2 | IR_UPGRADE_SATELLITES_L_3 = 0,2"
		,"NR_SMALL_SHIPS_UPGRADE_L_1 | NR_SMALL_SHIPS_UPGRADE_L_2 | NR_SMALL_SHIPS_UPGRADE_L_3 | NR_MEDIUM_SHIPS_UPGRADE_L_1 | NR_MEDIUM_SHIPS_UPGRADE_L_2 | NR_MEDIUM_SHIPS_UPGRADE_L_3 | NR_HUGE_SHIPS_UPGRADE_L_1 | NR_HUGE_SHIPS_UPGRADE_L_2 | NR_HUGE_SHIPS_UPGRADE_L_3 | NR_STARBASE_UPGRADE_L_1 | NR_STARBASE_UPGRADE_L_2 | NR_STARBASE_UPGRADE_L_3 | NR_Increased_Supplies_L1_Upgrade | NR_Increased_Supplies_L2_Upgrade | NR_Increased_Supplies_L3_Upgrade | NR_UPGRADE_SATELLITES_L_1 | NR_UPGRADE_SATELLITES_L_2 | NR_UPGRADE_SATELLITES_L_3 = 0,2"
	}
	}
	 
	RequiredCategories = {"Upgrade"}
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
	ReserveForce.Set_As_Goal_System_Removable(false)

	-- Give some time to accumulate money.
	tech_level = PlayerObject.Get_Tech_Level()
	min_credits = 2000
	if tech_level == 2 then
		min_credits = 4000
	elseif tech_level >= 3 then
		min_credits = 6000
	end
	
	max_sleep_seconds = 120
	current_sleep_seconds = 0
	while (PlayerObject.Get_Credits() < min_credits) and (current_sleep_seconds < max_sleep_seconds) do
		current_sleep_seconds = current_sleep_seconds + 1
		Sleep(1)
	end

	ScriptExit()
end

