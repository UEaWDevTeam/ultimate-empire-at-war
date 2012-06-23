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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ContrastToReconnect.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/ContrastToReconnect.lua $
--
--    Original Author: Steve_Copeland
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
-- Galactic Mode Contrast To Reconnect Islands of Nodes Script
--

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Conquer_To_Reconnect"
	TaskForce = {
	-- First Task Force
	{
		"SpaceForce"						
		,"MinimumTotalSize = 4"
		,"MinimumTotalForce = 2500"					
		,"Frigate | Capital | Corvette | Bomber | Fighter = 100%"
	},
	{
		"GroundForce"
		,"MinimumTotalSize = 4"
		,"MinimumTotalForce = 750"					
		,"Vehicle | Infantry | Air = 100%"
	}
	}
	RequiredCategories = { "Infantry", "Corvette | Frigate | Capital | Super" }		--Must have at least one ground unit, also make sure space force is reasonable

	PerFailureContrastAdjust = 0.5
	
	SpaceSecured = true
	LandSecured = false
	InSpaceConflict = false
	WasConflict = false

	sleep_duration = 150
	
	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function SpaceForce_Thread()
	DebugMessage("%s -- In SpaceForce_Thread.", tostring(Script))

	-- Since we're using plan failure to adjust contrast, we're 
	-- only concerned with failures in battle. Default the 
	-- plan to successful and then 
	-- only on the event of our task force being killed is the
	-- plan set to a failed state.
	SpaceForce.Set_Plan_Result(true)
		
	SpaceSecured = false

	if SpaceForce.Are_All_Units_On_Free_Store() == true then
		DebugMessage("SpaceForce converged on target (disconnecting node)")
		SynchronizedAssemble(SpaceForce)
		WasConflict = true
	else
		DebugMessage("%s -- Can't freestore allocate all our units, so just allocating build tasks.", tostring(Script))
		BlockOnCommand(SpaceForce.Produce_Force());
		return
	end
	
	
	if SpaceForce.Get_Force_Count() == 0 then
		if EvaluatePerception("Is_Good_Ground_Grab_Target", PlayerObject, Target) == 0 then
			DebugMessage("%s -- No SpaceForce at target and enemies still present in space.  Abandonning plan.", tostring(Script))
			SpaceForce.Set_Plan_Result(false)
			--Exit_Plan_With_Possible_Sleep()
		else
			DebugMessage("%s -- No SpaceForce, but Space at target appears clear anyway.", tostring(Script))
			SpaceSecured = true
		end
	else
		SpaceSecured = true
		
		while not LandSecured do
			Sleep(5)
		end
		
		SpaceForce.Release_Forces(1.0)
		DebugMessage("%s -- SpaceForce Done!  Exiting Script!", tostring(Script))
	end
end

function GroundForce_Thread()
	DebugMessage("%s -- In GroundForce_Thread.", tostring(Script))

	GroundForce.Set_Plan_Result(true)

	if GroundForce.Are_All_Units_On_Free_Store() == true then

		DebugMessage("%s -- GroundForce waiting for the space force to succede.", tostring(Script))
		while not SpaceSecured do
--			if WasConflict then
--				Exit_Plan_With_Possible_Sleep()
--			end
			Sleep(5)
		end
		DebugMessage("%s -- converging ground units on the target.", tostring(Script))
		SynchronizedAssemble(GroundForce)
	else
		DebugMessage("%s -- Can't freestore allocate all our units, so just allocating build tasks.", tostring(Script))
		BlockOnCommand(GroundForce.Produce_Force());
		return
	end
		
	WasConflict = true
	if Invade(GroundForce) == false then
		DebugMessage("%s -- Curses...The invasion failed!  Exiting Script!", tostring(Script))
--		Exit_Plan_With_Possible_Sleep()
	end

	DebugMessage("%s -- Political control changed building Ground and Starbase.", tostring(Script))
	LandSecured = true
	GroundForce.Release_Forces(1.0)
	GroundForce.Set_Plan_Result(true)
	FundBases(PlayerObject, Target)
--	Exit_Plan_With_Possible_Sleep()
end

function Exit_Plan_With_Possible_Sleep()
	if SpaceForce then
		SpaceForce.Release_Forces(1.0)
	end
	GroundForce.Release_Forces(1.0)
	if WasConflict then
		Sleep(sleep_duration)
	end
	ScriptExit()
end

function SpaceForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end

function GroundForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end

function GroundForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) or (PlayerObject.Get_Difficulty() == "Hard") then
			ScriptExit()
		end
	end
end

function SpaceForce_Original_Target_Owner_Changed(tf, old_owner, new_owner)	
	--Ignore changes to neutral - it might just be temporary on the way to
	--passing into my control.
	if new_owner ~= PlayerObject and new_owner.Is_Neutral() == false then
		if (not LandSecured) or (PlayerObject.Get_Difficulty() == "Hard") then
			ScriptExit()
		end
	end
end

function SpaceForce_No_Units_Remaining()
	if not LandSecured then
		DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
		SpaceForce.Set_Plan_Result(false) 
		--Don't exit since we need to sleep to enforce delays between AI attacks (can't be done inside an event handler)
	end
end

function GroundForce_No_Units_Remaining()
	if not LandSecured then
		DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
		GroundForce.Set_Plan_Result(false) 
		--Don't exit since we need to sleep to enforce delays between AI attacks (can't be done inside an event handler)
	end
end

