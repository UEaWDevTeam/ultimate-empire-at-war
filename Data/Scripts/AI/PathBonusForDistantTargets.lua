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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/PathBonusForDistantTargets.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/PathBonusForDistantTargets.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 45506 $
--
--          $DateTime: 2006/05/31 16:18:01 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 1

--
--
--

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Distant_System_Path_Bonus"
	IgnoreTarget = true
	TaskForce = 
	{
	{
		"EmptyForce"
		, "TaskForceRequired"
	}
	}
	
	DebugMessage("%s -- Done Definitions", tostring(Script))
	
	planet_list = nil
	markup_table = {}
end

function EmptyForce_Thread()

	EmptyForce.Set_As_Goal_System_Removable(false)
	planet_list = FindPlanet.Get_All_Planets()
	
	while true do
		for i,planet in pairs(planet_list) do
		
			if TestValid(planet) then
				path_start = _FindStageArea(PlayerObject, planet, EmptyForce)
				if path_start then
					path = Find_Path(PlayerObject, path_start, planet)
					value = (EvaluatePerception("GenericPlanetValue", PlayerObject, planet)
						+ EvaluatePerception("Is_Neglected_By_My_Opponent_Space", PlayerObject, planet)) / 2
					markup_table[planet] = Apply_Markup(PlayerObject, path, value, markup_table[planet])
				end
			else
				planet_list[i] = nil
			end
			Sleep(1)
		end
	end
end

