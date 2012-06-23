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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/AreaSweep.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/AreaSweep.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 44927 $
--
--          $DateTime: 2006/05/23 17:53:49 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

--
-- Space Mode Test Script
--

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Sweep_Area"
	MinContrastScale = 0.01
	MaxContrastScale = 1.3
	TaskForce = {
	-- First Task Force
	{
		"MainForce"
		,"Fighter | Corvette | Frigate | SpaceHero = 1, 10"
	}
	}
	
	AllowEngagedUnits = false

	kill_target = nil
	
	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
		
	MainForce.Collect_All_Free_Units("Fighter | Corvette | Frigate")
	SetClassPriorities(MainForce, "Attack_Move")
	MainForce.Activate_Ability("Turbo", true)
	MainForce.Activate_Ability("SPOILER_LOCK", true)
	Try_Ability(MainForce, "STEALTH")
	BlockOnCommand(MainForce.Attack_Move(AITarget))
	MainForce.Activate_Ability("Turbo", false)
	MainForce.Activate_Ability("SPOILER_LOCK", false)

	-- Try to at least find something, since we bothered coming over here
	-- There may be an enemy unit exposed, but the initial attack_move to the cell didn't find it.
	MainForce.Set_As_Goal_System_Removable(false)
	Target = Find_Nearest(MainForce, "Transport", PlayerObject, false)
	if TestValid(Target) then
		BlockOnCommand(MainForce.Attack_Move(Target))
	else
		Target = Find_Nearest(MainForce, "Fighter | Bomber | Corvette", PlayerObject, false)
		if TestValid(Target) then
			BlockOnCommand(MainForce.Attack_Move(Target))
		else
			Target = FindDeadlyEnemy(MainForce)
			if TestValid(Target) then
				BlockOnCommand(MainForce.Attack_Move(Target))
			end
		end
	end
	
	MainForce.Set_Plan_Result(true)
		
	ScriptExit()
end

-- Make sure that units don't sit idle at the end of their move order, waiting for others
function MainForce_Unit_Move_Finished(tf, unit)

	DebugMessage("%s -- %s reached end of move, giving new order", tostring(Script), tostring(unit))

	-- Assist the tf with whatever is holding it up
	kill_target = FindDeadlyEnemy(tf)
	if TestValid(kill_target) then
		unit.Attack_Move(kill_target)
	else
		unit.Attack_Move(tf)
	end
end