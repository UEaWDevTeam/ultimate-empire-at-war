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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/Droids.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/LandMode/Droids.lua $
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

function Definitions()
	
	Category = "Droids"
	TaskForce = {
	{
		"MainForce"					
		,"DenyHeroAttach"
		,"Tactical_R2_3PO_Team = 1"
	}
	}
	
	IgnoreTarget = true
	AllowEngagedUnits = true

	turret_seek_range = 500
	repair_seek_range = 500
end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	QuickReinforce(PlayerObject, AITarget, MainForce)

	MainForce.Set_As_Goal_System_Removable(false)
	
	droids = MainForce.Get_Unit_Table()[1]
	if not TestValid(droids) then
		MessageBox("unexpected state; droids unavailable")
	end

	-- Continuously try to use abilities and recharge or heal
	while true do

		ConsiderRepair(droids)

		-- If we're ready and there is a turret nearby, hack it
		if droids.Is_Ability_Ready("TARGETED_HACK") then
			nearest_turret = Find_Nearest(MainForce, "Turret", PlayerObject, false)
			if TestValid(nearest_turret) and MainForce.Get_Distance(nearest_turret) < turret_seek_range then
									 
				BlockOnCommand(MainForce.Activate_Ability("TARGETED_HACK", nearest_turret))
			end
		end

		
		ConsiderRepair(droids)

			
		-- Are we ready to find a vehicle to repair?
		if droids.Is_Ability_Ready("TARGETED_REPAIR") then
					
			-- Try a nearby one first
			repair_target = FindTarget(MainForce, "Needs_Repair", "Friendly_Unit", 1.0, repair_seek_range)
			if  TestValid(repair_target) then
			
				BlockOnCommand(MainForce.Activate_Ability("TARGETED_REPAIR", repair_target))

			else
			
				-- Find any vehicle to repair
				repair_target = FindTarget(MainForce, "Needs_Repair", "Friendly_Unit", 1.0)
				if TestValid(repair_target) then
					BlockOnCommand(MainForce.Activate_Ability("TARGETED_REPAIR", repair_target))
				end
			end
		end
		
		ConsiderRepair(droids)
		
		-- Generally move toward the most significant friendly vehicle
		big_vehicle = FindTarget(MainForce, "Vehicle_Needs_Escort", "Friendly_Unit", 1.0)
		if TestValid(big_vehicle) then
		
			-- Time out frequently, so that we can acquire other targets
			BlockOnCommand(MainForce.Move_To(big_vehicle), 5)
		end

		MainForce.Set_Plan_Result(true)
		
		-- Make sure that they have at least some non-offensive orders (because the above may cause no behavior)
		flee_loc = FindTarget(MainForce, "Space_Area_Is_Hidden", "Tactical_Location", 1.0, 5000.0)
		if flee_loc then
			BlockOnCommand(MainForce.Move_To(flee_loc))
		end

		-- Make sure the loop always yields
		Sleep(1)
	
	end

end
