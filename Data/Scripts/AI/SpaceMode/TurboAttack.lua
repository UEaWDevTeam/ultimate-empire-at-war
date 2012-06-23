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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TurboAttack.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/TurboAttack.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Andre_Arsenault $
--
--            $Change: 37816 $
--
--          $DateTime: 2006/02/15 15:33:33 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

--
-- Plan for corvettes to exploit their turbo or power to weapons abilities in a quick strike on a vulnerable unit.
--

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Turbo_Attack_Unit"
	TaskForce = {
	-- First Task Force
	{
		"MainForce"
		,"DenyHeroAttach"
		,"S_CENTURION | C_MISSILE_FRIGATE | C_MUNIFICENT | C_RECUSANT | C_PROVIDENCE | C_LUCREHULK | IR_TARTAN_CRUISER | IR_LANCER_FRIGATE | IR_STRIKE_CLASS_CRUISER | IR_ACCLAMATOR_ASSAULT_CRUISER_II | IR_DREADNAUGHT_REFIT | IR_VICTORY_I | IR_VICTORY_II | IR_ISDI | IR_ISDII | E_TARTAN_CRUISER | E_IPV_PATROL_CRAFT | E_ACCLAMATOR_ASSAULT_CRUISER_II | E_DREADNAUGHT | E_DREADNAUGHT_REFIT | E_VICTORY_I | E_VICTORY_II | E_ISDI | E_ISDII | OR_THRANTA | OR_HEAVY_CRUISER | OR_CENTURION | R_VICTORY_FRIGATE | R_VENATOR | R_VICTORY_I | RA_ASSAULT_FRIGATE_I | RA_ASSAULT_FRIGATE_II | NR_NEBULA_CLASS_STAR_DESTROYER | C_MISSILE_FRIGATE | C_RECUSANT | C_PROVIDENCE | C_LUCREHULK = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true

	needs_turbo = false

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force());
	
	QuickReinforce(PlayerObject, AITarget, MainForce)
		
	MainForce.Enable_Attack_Positioning(false)
	
	-- Move into position while avoiding threat and without stopping for attacks on the way
	needs_turbo = true
	Try_Ability(MainForce, "Turbo")
	BlockOnCommand(MainForce.Move_To(AITarget, 10, "ASTEROID"))
	MainForce.Activate_Ability("Turbo", false)
	needs_turbo = false

	-- Nah, let attack location plans steal units away 
	-- MainForce.Set_As_Goal_System_Removable(false)

	-- Make a tactical strike on one particular unit (and verify that there's still a good target here).
	enemy = FindTarget(MainForce, "Good_Turbo_Attack_Unit_Opportunity", "Enemy_Unit", 1.0)
	if TestValid(enemy) then
		BlockOnCommand(MainForce.Attack_Target(enemy, 10, "ASTEROID"), 10) -- Timeout after 10 seconds.
	end	
	
	-- Try to flee to a safe spot after the tactical strike
	escape_loc = FindTarget(MainForce, "Space_Area_Is_Hidden", "Tactical_Location", 1.0, 5000.0)
	if escape_loc then
		needs_turbo = true 
		MainForce.Activate_Ability("Turbo", true)
		BlockOnCommand(MainForce.Move_To(escape_loc, 10, "ASTEROID"))
	end

	ScriptExit()
end

-- Make sure that units don't sit idle at the end of their move order, waiting for others
function MainForce_Unit_Move_Finished(tf, unit)

	if Attacking and not unit.Has_Attack_Target() then
		DebugMessage("%s -- %s reached end of move, giving new order", tostring(Script), tostring(unit))
	
		-- Assist the tf with whatever is holding it up
		kill_target = FindDeadlyEnemy(tf)
		if TestValid(kill_target) then
			unit.Attack_Target(kill_target)
		else
			unit.Attack_Move(tf)
		end
	end
end

-- Try to recover use of turbo or power to weapons if it was lost while we were trying to use it.
function MainForce_Unit_Ability_Ready(tf, unit, ability)

	--MessageBox("%s -- Recovering %s for %s!", tostring(Script), ability, tostring(unit))
	if ability == "Turbo" and needs_turbo then
		unit.Activate_Ability("Turbo", true)
	end
	
	-- Default handler behavior is still desired
	Default_Unit_Ability_Ready(tf, unit, ability)
end
