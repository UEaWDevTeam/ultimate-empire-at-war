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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PalpatineManager.lua#4 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PalpatineManager.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 52287 $
--
--          $DateTime: 2006/08/22 10:41:09 $
--
--          $Revision: #4 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

-- This plan simply puts palpatine in the right places.
-- It relies on the object script darthpalpatine.lua to activate abilities.

require("pgevents")

function Definitions()
	
	Category = "PalpatineManager"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Emperor_Palpatine = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true
	
	attack_attention_span = 30
	defend_attention_span = 60

end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	MainForce.Set_As_Goal_System_Removable(false)

	palpatine = MainForce.Get_Unit_Table()[1]
	if not TestValid(palpatine) then
		MessageBox("unexpected state; palpatine unavailable")
		ScriptExit()
	end

	-- Don't let Palpatine waste the landing party on Easy or Normal difficlties
	difficulty = PlayerObject.Get_Difficulty()
	if (EvaluatePerception("Is_Skirmish_Mode", PlayerObject) == 0) 
			and (difficulty == "Normal" or difficulty == "Easy") then
		friendly_structure = Find_Nearest(MainForce, "Structure", PlayerObject, true)
		if TestValid(friendly_structure) then
			BlockOnCommand(MainForce.Guard_Target(friendly_structure), 40)
		else
			Sleep(40)
		end
	end

	-- Continuously try to attack, assist the most significant nearby unit, and heal up
	while true do

		ConsiderHeal(palpatine)

		-- Occasionally, Palpatine will join the front line battle on harder difficulties
		if difficulty == "Hard" or (difficulty == "Normal" and GameRandom.Get_Float() < 0.5) then
		
			if not palpatine.Has_Attack_Target() then
				enemy_location = FindTarget.Reachable_Target(PlayerObject, "Current_Enemy_Location", "Tactical_Location", "Any_Threat", 0.5)
				if TestValid(enemy_location) then
					DebugMessage("%s--  moving toward enemy concentration", tostring(Script))
					BlockOnCommand(MainForce.Attack_Move(enemy_location), attack_attention_span)
				end
				nearest_enemy = Find_Nearest(MainForce, PlayerObject, false)
				if TestValid(nearest_enemy) then
					DebugMessage("%s--  attack_moving to nearest enemy %s", tostring(Script), tostring(nearest_enemy))
					BlockOnCommand(MainForce.Attack_Move(nearest_enemy), attack_attention_span)
				end
			end
		end

		ConsiderHeal(palpatine)

		-- Palpatine spends most of his time defending structures needing help
		structure_to_defend = FindTarget(MainForce, "Need_To_Defend_Structure", "Friendly_Structure", 1.0)
		while TestValid(structure_to_defend) and structure_to_defend.Is_Category("Structure") and (structure_to_defend.Get_Hull() < 0.9) do
			DebugMessage("%s-- guarding %s", tostring(Script), tostring(structure_to_defend))
			BlockOnCommand(MainForce.Guard_Target(structure_to_defend), defend_attention_span, Defended_Structure_Is_Gone)
			structure_to_defend = FindTarget(MainForce, "Need_To_Defend_Structure", "Friendly_Unit", 1.0)
		end
		
		MainForce.Set_Plan_Result(true)

		-- Make sure the loop always yields
		Sleep(1)
	
	end

end


function ConsiderDefending()
end

function Defended_Structure_Is_Gone()

	-- DELME
--	if TestValid(structure_to_defend) then
--		DebugMessage("%s-- structure %s is still alive", tostring(String), tostring(structure_to_defend))
--	end
	
	return not TestValid(structure_to_defend)
end



