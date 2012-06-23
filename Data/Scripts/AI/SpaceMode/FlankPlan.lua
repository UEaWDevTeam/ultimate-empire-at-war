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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/FlankPlan.lua#3 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/FlankPlan.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 45952 $
--
--          $DateTime: 2006/06/09 16:00:52 $
--
--          $Revision: #3 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	AllowEngagedUnits = false
	MinContrastScale = 0.75
	Category = "Destroy_Unit"
	TaskForce = {
	{
		"MainForce"
		,"Corvette | Frigate | Capital | Super = 2,6"
	},
	{
		"FlankForce"
		,"Fighter = 1,4"
	}
	}
	
	ExecuteFlank = true
	flank_block = nil
	flank_dist = 1000.0
	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function MainForce_Thread()
	DebugMessage("%s -- In MainForce_Thread.", tostring(Script))
	ExecuteFlank = false

	BlockOnCommand(MainForce.Produce_Force());
	
	QuickReinforce(PlayerObject, AITarget, MainForce, FlankForce)
	
	DebugMessage("MainForce constructed at stage area!")
	MainForce.Enable_Attack_Positioning(true)

	SetClassPriorities(MainForce, "Attack_Move")
	BlockOnCommand(MainForce.Attack_Move(AITarget, MainForce.Get_Self_Threat_Max()))	
	DebugMessage("%s -- MainForce Done!  Exiting Script!", tostring(Script))
	ScriptExit()
end

function FlankForce_Thread()
	BlockOnCommand(FlankForce.Produce_Force())

	QuickReinforce(PlayerObject, AITarget, FlankForce, MainForce)	

	-- Parameters = target, direction ("left", "right", "front", "back"), minimum distance from target, threat tolerance
	flank_block = FlankForce.Prepare_Ambush(AITarget, "back", flank_dist, 500.0)
	if not flank_block then 
		DebugMessage("Unable to reach BACK flank, trying right.")
		flank_block = FlankForce.Prepare_Ambush(AITarget, "right", flank_dist, 500.0)
	end

	if not flank_block then 
		DebugMessage("Unable to reach RIGHT flank, trying right.")
		flank_block = FlankForce.Prepare_Ambush(AITarget, "left", flank_dist, 500.0)
	end
	
	if not flank_block then 
		DebugMessage("Unable to reach a flank.  Abandonning plan.")
		ScriptExit()
	end
	
	-- Try to stay in position to perform the flank
	while not ExecuteFlank do
		if flank_block.IsFinished() then
			if TestValid(AITarget) and FlankForce.Get_Distance(AITarget) < flank_dist then
					DebugMessage("%s -- Attempting to stay out of range and safe.", tostring(Script))
					FlankForce.Move_To(Project_By_Unit_Range(AITarget.Get_Game_Object(), FlankForce), FlankForce.Get_Self_Threat_Max())
			end
		end
		Sleep(5)
	end
	
	BlockOnCommand(FlankForce.Attack_Target(AITarget))
	FlankForce.Enable_Attack_Positioning(false)
	
	ScriptExit()
end
	

function MainForce_No_Units_Remaining()
	DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
	ScriptExit()
end

function MainForce_Original_Target_Destroyed()
	DebugMessage("%s -- Target destroyed!  Exiting Script.", tostring(Script))
	ScriptExit()
end

function MainForce_Target_In_Range()
	ExecuteFlank = true
	MainForce.Enable_Attack_Positioning(true)
end

function FlankForce_Target_In_Range()
	FlankForce.Enable_Attack_Positioning(true)
end

function FlankForce_Original_Target_Destroyed()
	ScriptExit()	
end
