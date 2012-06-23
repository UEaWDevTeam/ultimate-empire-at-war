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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/StealVehicle.lua#4 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/StealVehicle.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 54633 $
--
--          $DateTime: 2006/09/14 17:46:53 $
--
--          $Revision: #4 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

function Definitions()
	
	Category = "Steal_Vehicle"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"CHEWBACCA = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true

end


function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	MainForce.Set_As_Goal_System_Removable(false)
	
	MainForce.Set_Single_Ability_Autofire("CAPTURE_VEHICLE", false)

	-- Do something productive while waiting for the ability to become available
	chewie = MainForce.Get_Unit_Table()[1]
	if not chewie then
		MessageBox("%s-- Couldn't find chewie", tostring(Script))
	end

	-- Keep chewie sprinting when he can
	needs_sprint = true
	Try_Ability(MainForce, "SPRINT")
	
	-- While chewie is in a vehicle already or his ability isn't ready, do something productive.
	while chewie.Get_Parent_Object() or not chewie.Is_Ability_Ready("CAPTURE_VEHICLE") do
		if not ConsiderHeal(chewie) then
			
			friendly_structure = Find_Nearest(chewie, "Structure", PlayerObject, true)
			if TestValid(friendly_structure) then
				BlockOnCommand(MainForce.Attack_Move(friendly_structure))
				chewie.Guard_Target(friendly_structure)
			else
				ScriptExit()
			end
		end
		Sleep(1)
	end

	BlockOnCommand(MainForce.Activate_Ability("CAPTURE_VEHICLE", AITarget))
	needs_sprint = false
	
	-- Give Chewie time to climb in before issuing another order, which could cancel the ability
	Sleep(2)
	
	-- Cause as much trouble as possible while in the enemy vehicle
	nearest_enemy = Find_Nearest(chewie, PlayerObject, false)
	while TestValid(nearest_enemy) and chewie.Get_Parent_Object() do
		BlockOnCommand(MainForce.Attack_Move(nearest_enemy))
		MainForce.Set_Plan_Result(true)
		nearest_enemy = Find_Nearest(chewie, PlayerObject, false)
	end

	-- Go heal up
	nearest_healer = Find_Nearest(chewie, "HealsInfantry", PlayerObject, true)
	if nearest_healer then
		Try_Ability(MainForce, "SPRINT")
		BlockOnCommand(MainForce.Move_To(nearest_healer))
		Sleep(20)
	end

	ScriptExit()
end

-- Try to recover use of an ability if it was lost while we were trying to use it.
function MainForce_Unit_Ability_Ready(tf, unit, ability)

	--MessageBox("%s -- Recovering %s for %s!", tostring(Script), ability, tostring(unit))
	if ability == "SPRINT" and needs_sprint then
		unit.Activate_Ability("SPRINT", true)
	end
	
	-- Default handler behavior is still desired
	Default_Unit_Ability_Ready(tf, unit, ability)
end

