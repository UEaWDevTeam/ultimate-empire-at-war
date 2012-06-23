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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/ObiWanAssists.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/ObiWanAssists.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 52287 $
--
--          $DateTime: 2006/08/22 10:41:09 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

-- This plan simply puts ObiWan in the right places.
-- It relies on the object script obiwanplan.lua to activate abilities.

require("pgevents")

function Definitions()
	
	Category = "ObiWanAssists"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Obi_Wan_Kenobi = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true
	
	duration_to_assist = 20
	duration_to_fight = 30

end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	MainForce.Set_As_Goal_System_Removable(false)

	obiwan = MainForce.Get_Unit_Table()[1]
	if not TestValid(obiwan) then
		MessageBox("unexpected state; obiwan unavailable")
		ScriptExit()
	end

	-- Continuously try to attack, assist the most significant nearby unit, and heal up
	while true do

		ConsiderHeal(obiwan)

		enemy_location = FindTarget.Reachable_Target(PlayerObject, "Current_Enemy_Location", "Tactical_Location", "Any_Threat", 0.5)
		if TestValid(enemy_location) then
			DebugMessage("%s--  moving toward enemy concentration", tostring(Script))
			BlockOnCommand(MainForce.Attack_Move(enemy_location), duration_to_fight)
		end

		ConsiderHeal(obiwan)

		best_ally = FindTarget(MainForce, "Needs_ObiWan_Assist", "Friendly_Unit", 1.0, 1500)
		if TestValid(best_ally) then
			DebugMessage("%s-- assisting %s", tostring(Script), tostring(best_ally))
			BlockOnCommand(MainForce.Guard_Target(best_ally), duration_to_assist)
		end
		
		MainForce.Set_Plan_Result(true)

		-- Make sure the loop always yields
		Sleep(1)
	
	end

end

-- He really tries to preserve himself
function MainForce_Unit_Damaged(tf, unit, attacker, deliberate)
	
	if unit.Get_Hull() < 0.5 or unit.Get_Time_Till_Dead() < 30 then
		Try_Ability(unit, "TARGETED_INVULNERABILITY", unit)
	end
	
	Default_Unit_Damaged(tf, unit, attacker, deliberate)
end
