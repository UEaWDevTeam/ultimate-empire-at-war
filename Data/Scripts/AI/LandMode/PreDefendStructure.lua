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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PreDefendStructure.lua#6 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/PreDefendStructure.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Andre_Arsenault $
--
--            $Change: 55814 $
--
--          $DateTime: 2006/10/02 16:55:52 $
--
--          $Revision: #6 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////


-- This plan serves to head off the main attacking force by placing an RPS appropriate forces
-- in the vicinity of the main base structure that will receive the enemy first.


require("pgevents")

ScriptPoolCount = 5

function Definitions()
	
	Category = "PreDefend_Structure"
	AllowEngagedUnits = true
	MinContrastScale = 0.5
	MaxContrastScale = 1.2
	TaskForce = {
	{
		"MainForce"			
		,"DenyHeroAttach"
		,"Infantry = 0,10"
		,"Vehicle | Air = 0,10"
		,"LandHero = 0,3"
	},
	{
		"GuardForce"
		,"EscortForce"		-- This should force a good RPS match for the enemies in our target's zone
		,"Infantry = 0,10"
		,"Vehicle | Air = 0,10"
		,"LandHero = 0,3"
	}
	}
	RequiredCategories = {"Infantry | Vehicle | Air"}

	structure = nil
end

function MainForce_Thread()

	-- We don't actually want the forces for contrast to AITarget, this plan
	-- is only concerned with the forces surrounding the AITarget.  We have
	-- to produce and release them to get them back on the freestore, however.
	BlockOnCommand(MainForce.Produce_Force())
	--MainForce.Release_Forces(1.0)

	QuickReinforce(PlayerObject, AITarget, MainForce, GuardForce)
	
	Set_Land_AI_Targeting_Priorities(MainForce)

	-- Find our structure nearest the enemy
	structure = Find_Nearest(AITarget, "Structure", PlayerObject, true)

	DebugMessage("%s -- PreDefending structure: %s.", tostring(Script), tostring(structure))
	if TestValid(structure) then
		BlockOnCommand(MainForce.Attack_Move(structure), 20)
	end
	
	ScriptExit()
end 

-- Make sure that units don't sit idle at the end of their move order, waiting for others
function MainForce_Unit_Move_Finished(tf, unit)

	Default_Unit_Move_Finished(tf, unit)

	-- As each unit arrives, guard the structure
	if TestValid(structure) then
		unit.Guard_Target(structure)
	end
end



function GuardForce_Thread()
	BlockOnCommand(GuardForce.Produce_Force())

	QuickReinforce(PlayerObject, AITarget, GuardForce, MainForce)

	Set_Land_AI_Targeting_Priorities(GuardForce)

	-- Find our structure nearest the enemy
	structure = Find_Nearest(AITarget, "Structure", PlayerObject, true)

	DebugMessage("%s -- PreDefending structure: %s.", tostring(Script), tostring(structure))
	if TestValid(structure) then
		BlockOnCommand(GuardForce.Attack_Move(structure), 20)
	end

	ScriptExit()
end 


-- Make sure that units don't sit idle at the end of their move order, waiting for others
function GuardForce_Unit_Move_Finished(tf, unit)

	Default_Unit_Move_Finished(tf, unit)

	-- As each unit arrives, guard the structure
	if TestValid(structure) then
		unit.Guard_Target(structure)
	end
end

function MainForce_Original_Target_Destroyed()
	ScriptExit()
end

function GuardForce_Original_Target_Destroyed()
	ScriptExit()
end

