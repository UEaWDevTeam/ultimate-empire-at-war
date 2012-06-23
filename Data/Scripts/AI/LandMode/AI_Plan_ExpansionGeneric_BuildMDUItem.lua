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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/AI_Plan_ExpansionGeneric_BuildMDUItem.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/AI_Plan_ExpansionGeneric_BuildMDUItem.lua $
--
--    Original Author: Steve_Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 56734 $
--
--          $DateTime: 2006/10/24 14:15:48 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

-- Build a single turret.

function Definitions()
	
	Category = "Build_Ysalamiri_Cage | Build_Sensor_Scrambler | Build_Rocket_Pod | Build_EM_Field_Generator | Build_Grenade_Mortar | Build_Offensive_Sensor_Node | Build_MDU_Repair_Facility | Build_Mobile_Shield_Generator | Build_Rapid_Fire_Laser"
	IgnoreTarget = true
	TaskForce = {
	{
		"MainForce"	
		,"DenyHeroAttach"				
		,"Underworld_Mobile_Defense_Unit | Rebel_Mobile_Defense_Unit | Empire_Mobile_Defense_Unit = 1"
	}
	}

end

function MainForce_Thread()

	goal_name = MainForce.Get_Goal_Type_Name()
	if goal_name == "Build_Ysalamiri_Cage" then
		build_item_name = "UC_Underworld_Ysalamiri_Cage"
	elseif goal_name == "Build_Sensor_Scrambler" then
		build_item_name = "UC_Underworld_Sensor_Scrambler"
	elseif goal_name == "Build_Rocket_Pod" then
		build_item_name = "UC_Underworld_Rocket_Pod"
	elseif goal_name == "Build_EM_Field_Generator" then
		build_item_name = "UC_Empire_EM_Field_Generator"
	elseif goal_name == "Build_Grenade_Mortar" then
		build_item_name = "UC_Empire_Greande_Mortar"
	elseif goal_name == "Build_Offensive_Sensor_Node" then
		build_item_name = "UC_Empire_Offensive_Sensor_Node"
	elseif goal_name == "Build_MDU_Repair_Facility" then
		build_item_name = "UC_Rebel_Buildable_Repair_Facility_MDU"
	elseif goal_name == "Build_Mobile_Shield_Generator" then
		build_item_name = "UC_Rebel_Mobile_Shield_Generator"
	elseif goal_name == "Build_Rapid_Fire_Laser" then
		build_item_name = "UC_Rebel_Rapid_Fire_Laser_Turret"
	end
	
	if not build_item_name then
		ScriptExit()
	end

	BlockOnCommand(MainForce.Produce_Force())
	QuickReinforce(PlayerObject, AITarget, MainForce)
	
	BlockOnCommand(MainForce.Move_To(Target, MainForce.Get_Self_Threat_Max()))
	build_started = true
	BlockOnCommand(MainForce.Activate_Ability("DEPLOY", true))	
	MainForce.Set_Plan_Result(true)
	
	Sleep(2)
	
	mdu = MainForce.Get_Unit_Table()[1]
	if not TestValid(mdu) then
		ScriptExit()
	end	
	
	mdu.Build(build_item_name)
	
	while TestValid(mdu) and not TestValid(mdu.Get_Build_Pad_Contents()) do
		Sleep(1)
	end
	
	ScriptExit()
end

function MainForce_Unit_Damaged(tf, unit, attacker, deliberate)
	if not build_started then
		Default_Unit_Damaged(tf, unit, attacker, deliberate)
	end
end