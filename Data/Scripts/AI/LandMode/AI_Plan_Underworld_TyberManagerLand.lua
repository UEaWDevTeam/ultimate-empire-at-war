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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/AI_Plan_Underworld_TyberManagerLand.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/AI_Plan_Underworld_TyberManagerLand.lua $
--
--    Original Author: James Yarrow
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


require("pgevents")

function Definitions()
	
	Category = "Tyber_Manager_Land"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Tyber_Zann = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true
	
	attack_attention_span = 30
	defend_attention_span = 30

end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	MainForce.Set_As_Goal_System_Removable(false)

	tyber = MainForce.Get_Unit_Table()[1]
	if not TestValid(tyber) then
		ScriptExit()
	end

	tyber.Set_Single_Ability_Autofire("TACTICAL_BRIBE", false)

	-- Continuously try to attack, assist the most significant nearby unit, and heal up
	while true do

		threat_threshold = "Any_Threat"
		if tyber.Get_Hull() < 0.5 then
			threat_threshold = "Low_Threat"
		end
		
		if not ConsiderHeal(tyber) then
			if not Try_Bribe(tyber, threat_threshold) then
				if not Try_Defend(tyber, threat_threshold) then
					if not Try_Attack(tyber, threat_threshold) then
						Try_Ability(tyber, "STEALTH")
						Sleep(5)
					end
				end
			end
		end
		
		-- Make sure the loop always yields
		Sleep(1)
	
	end

end

function Try_Bribe(tyber, threat_threshold)

	if tyber.Is_Ability_Ready("TACTICAL_BRIBE") then
	
		bribe_target = FindTarget.Reachable_Target(PlayerObject, "Bribe_Target_Score", "Enemy_Unit", threat_threshold, 1.0, tyber)
		
		if TestValid(bribe_target) then
			bribe_cost = bribe_target.Get_Game_Object().Get_Type().Get_Bribe_Cost(tyber)
			if bribe_cost > 0.0 and bribe_cost < PlayerObject.Get_Credits() then
				tyber.Activate_Ability("STEALTH", true)
				BlockOnCommand(tyber.Activate_Ability("TACTICAL_BRIBE", bribe_target))
				return true
			end
		end
	end
	
	return false
end

function Try_Defend(tyber, threat_threshold)

	if EvaluatePerception("Allowed_As_Defender_Land", PlayerObject) <= 0.0 then
		
		structure_to_defend = FindTarget.Reachable_Target(PlayerObject, "Need_To_Defend_Structure", "Friendly_Structure", threat_threshold, 1.0, tyber)
		
		if TestValid(structure_to_defend) then
			BlockOnCommand(MainForce.Guard_Target(structure_to_defend), defend_attention_span)
			return true
		end
	end
	
	return false
end

function Try_Attack(tyber, threat_threshold)

	enemy = FindDeadlyEnemy(tyber)
	if not TestValid(enemy) then
		enemy = Find_Nearest(tyber, PlayerObject, false)
	end
	
	if TestValid(enemy) then
		BlockOnCommand(tyber.Attack_Move(enemy), attack_attention_span)
		return true
	end	
	
	return false
	
end