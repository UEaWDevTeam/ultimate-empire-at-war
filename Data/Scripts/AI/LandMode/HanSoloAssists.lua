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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/HanSoloAssists.lua#3 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/HanSoloAssists.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 52287 $
--
--          $DateTime: 2006/08/22 10:41:09 $
--
--          $Revision: #3 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

-- This plan simply puts Han in the right places.
-- It relies on the object script HanSolo.lua to activate abilities.

require("pgevents")

function Definitions()
	
	Category = "HanSoloAssists"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Han_Solo = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true
	
	duration_to_fight = 60
	time_to_transition_reinforcement_point = 5
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	MainForce.Set_As_Goal_System_Removable(false)

	han = MainForce.Get_Unit_Table()[1]
	if not TestValid(han) then
		MessageBox("unexpected state; han unavailable")
		ScriptExit()
	end

	-- Continuously try to attack, assist the most significant nearby unit, and heal up
	while true do

		-- Make sure the loop always yields
		Sleep(1)

		ConsiderHeal(han)
		
		-- Grab a reinforcement point
		lz_table = PruneFriendlyObjects(Find_All_Objects_Of_Type("IsRushTarget"))
		if TestValid(lz_table[1]) then

			Try_Ability(han, "SPRINT")
			BlockOnCommand(han.Move_To(lz_table[1]))
			BlockOnCommand(han.Guard_Target(lz_table[1]), time_to_transition_reinforcement_point)
		end

		ConsiderHeal(han)

		-- Try to get near a good EMP stun target
		enemy_location = FindTarget.Reachable_Target(PlayerObject, "Area_Needs_Han_Solo_Assist", "Tactical_Location", "Any_Threat", 0.5)
		if TestValid(enemy_location) then
			DebugMessage("%s--  moving toward enemy concentration", tostring(Script))
			BlockOnCommand(MainForce.Attack_Move(enemy_location))
			if han.Is_Ability_Ready("AREA_EFFECT_STUN") then
				enemy_vehicle = Find_Nearest(han, "Vehicle", PlayerObject, false)
				if TestValid(enemy_vehicle) then
					BlockOnCommand(MainForce.Move_To(enemy_vehicle))
				end
			end
		end

		MainForce.Set_Plan_Result(true)
	
	end

end


