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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/DefendStructure.lua#5 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/DefendStructure.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 56734 $
--
--          $DateTime: 2006/10/24 14:15:48 $
--
--          $Revision: #5 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

ScriptPoolCount = 16

function Definitions()
	
	Category = "Defend_Structure"
	AllowEngagedUnits = true
	MinContrastScale = 1.2
	MaxContrastScale = 1.8
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"EscortForce"		-- This should force a good RPS match for the enemies in our target's zone
		,"Infantry = 0,20"
		,"Vehicle | Air = 0,20"
		,"LandHero = 0,3"
		,"-Gallofree_HTT_Company"
		,"-HAV_Juggernaut_Company"
		,"-F9TZ_Cloaking_Transport_Company"
		,"-AT_AA_Walker"		
	}
	}
	RequiredCategories = {"Infantry | Vehicle | Air"}

	structure = nil
	kill_target = nil
	
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())

	Set_Land_AI_Targeting_Priorities(MainForce)
	
	-- form up any spread out infantry
	MainForce.Activate_Ability("SPREAD_OUT", false)

	structure = AITarget.Get_Game_Object()
	DebugMessage("%s -- Found structure: %s.", tostring(Script), tostring(structure))
	if TestValid(structure) then
		kill_target = FindDeadlyEnemy(structure)
		DebugMessage("%s -- Found deadly enemy: %s.", tostring(Script), tostring(kill_target))
		if TestValid(kill_target) and (kill_target.Get_Distance(AITarget) < 500) then
			BlockOnCommand(MainForce.Attack_Target(kill_target, MainForce.Get_Self_Threat_Sum()))
		end
	
		BlockOnCommand(MainForce.Attack_Move(AITarget))
		BlockOnCommand(MainForce.Guard_Target(AITarget))
	end
end 


-- Make sure that units don't sit idle at the end of their move order, waiting for others
function MainForce_Unit_Move_Finished(tf, unit)

	Default_Unit_Move_Finished(tf, unit)

	if TestValid(AITarget) then
		-- As each unit arrives, guard the structure
		unit.Guard_Target(AITarget)
	end
end
