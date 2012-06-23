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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/AI_Plan_ExpansionGeneric_SkirmishUpgradeSpaceStation.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/AI_Plan_ExpansionGeneric_SkirmishUpgradeSpaceStation.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 54441 $
--
--          $DateTime: 2006/09/13 15:08:39 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////



require("pgevents")


function Definitions()
	
	Category = "Skirmish_Upgrade_Space_Station"
	IgnoreTarget = true
	TaskForce = {
	{
		"ReserveForce"
		,"OR_Starbase_Upgrade_Level_2 | OR_Starbase_Upgrade_Level_3 | OR_Starbase_Upgrade_Level_4 | OR_Starbase_Upgrade_Level_5 = 0,1"
		,"S_Starbase_Upgrade_Level_2 | S_Starbase_Upgrade_Level_3 | S_Starbase_Upgrade_Level_4 | S_Starbase_Upgrade_Level_5 = 0,1"
		,"R_Starbase_Upgrade_Level_2 | R_Starbase_Upgrade_Level_3 | R_Starbase_Upgrade_Level_4 | R_Starbase_Upgrade_Level_5 = 0,1"
		,"C_Starbase_Upgrade_Level_2 | C_Starbase_Upgrade_Level_3 | C_Starbase_Upgrade_Level_4 | C_Starbase_Upgrade_Level_5 = 0,1"
		,"RS_Level_Two_Starbase_Upgrade | RS_Level_Three_Starbase_Upgrade | RS_Level_Four_Starbase_Upgrade | RS_Level_Five_Starbase_Upgrade = 0,1"
		,"ES_Level_Two_Starbase_Upgrade | ES_Level_Three_Starbase_Upgrade | ES_Level_Four_Starbase_Upgrade | ES_Level_Five_Starbase_Upgrade = 0,1"
		,"NR_Starbase_Upgrade_Level_2 | NR_Starbase_Upgrade_Level_3 | NR_Starbase_Upgrade_Level_4 | NR_Starbase_Upgrade_Level_5 = 0,1"
		,"IR_Starbase_Upgrade_Level_2 | IR_Starbase_Upgrade_Level_3 | IR_Starbase_Upgrade_Level_4 | IR_Starbase_Upgrade_Level_5 = 0,1"
	}
	}
	RequiredCategories = {"Upgrade"}
	AllowFreeStoreUnits = false

end

function ReserveForce_Thread()
			
	BlockOnCommand(ReserveForce.Produce_Force())
	ReserveForce.Set_Plan_Result(true)
		
	ScriptExit()
end