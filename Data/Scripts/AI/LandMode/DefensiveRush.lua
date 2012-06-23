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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/DefensiveRush.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/DefensiveRush.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 52811 $
--
--          $DateTime: 2006/08/28 18:52:56 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////


-- This plan is to send a limited amount of force to try to initially push the attacker off a planet.
-- It should only be invoked if the defender can spare some units and still have a strong base defense.
-- This is to provide a middle ground between the all out rush (when the AI decides that it has overwhelming
-- force) and the total defensive posture (when AI doesn't clearly have overwhelming force).

require("pgevents")

ScriptPoolCount = 16

function Definitions()
	
	Category = "Defensive_Rush"
	AllowEngagedUnits = true
	IgnoreTarget = true
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Infantry | Vehicle | Air = 5,12"
	}
	}
	
	guard_duration = 20

end

function MainForce_Thread()

	BlockOnCommand(MainForce.Produce_Force())

	MainForce.Set_As_Goal_System_Removable(false)

	Set_Land_AI_Targeting_Priorities(MainForce)
	
	-- Rush the LZ
	lz_table = PruneFriendlyObjects(Find_All_Objects_Of_Type("IsRushTarget"))
	if TestValid(lz_table[1]) then
		--MessageBox("guarding the LZ")
		BlockOnCommand(MainForce.Attack_Move(lz_table[1]))
		BlockOnCommand(MainForce.Guard_Target(lz_table[1]), guard_duration)
	end

	-- Rush any attackers that we might be able to see
	nearest_enemy = Find_Nearest(MainForce, PlayerObject, false)
	while TestValid(nearest_enemy) do
		BlockOnCommand(MainForce.Attack_Move(nearest_enemy))
		nearest_enemy = Find_Nearest(MainForce, PlayerObject, false)
	end

	-- This plan should only be allowed to occur once
	while true do
		Sleep(200)
	end
end 

