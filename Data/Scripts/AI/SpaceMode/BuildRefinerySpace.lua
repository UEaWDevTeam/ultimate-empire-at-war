-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildRefinerySpace.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildRefinerySpace.lua $
--
--    Original Author: Steve Copeland
--
--            $Author: James_Yarrow $
--
--            $Change: 46312 $
--
--          $DateTime: 2006/06/15 13:55:40 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")


function Definitions()
	
	Category = "Build_Refinery_Space"
	IgnoreTarget = true
	TaskForce = {
	{
		"MainForce"
		,"UC_Empire_Mineral_Extractor | UC_Rebel_Mineral_Extractor | UC_S_Mineral_Extractor | UC_OR_Mineral_Extractor | UC_R_Mineral_Extractor | UC_C_Mineral_Extractor | UC_NR_Mineral_Extractor | UC_IR_Mineral_Extractor = 1"
	}
	}
--	RequiredCategories = {"Structure"}
	AllowFreeStoreUnits = false
	good_pad = nil
	pad = nil
	refinery = nil

end

function MainForce_Thread()

	-- Make sure we use a build pad that's not too near to the enemy base
	nearby_pad_list = MainForce.Get_Reserved_Build_Pads()
	for i, pad in pairs(nearby_pad_list) do
		if EvaluatePerception("Distance_To_Nearest_Enemy_Starbase", PlayerObject, pad) > 2000 then
			good_pad = pad
			break
		end
	end
	
	if good_pad then 
	    is_built = false
		faction_name = PlayerObject.Get_Faction_Name()
		if faction_name == "EMPIRE" then
			MainForce.Build("UC_Empire_Mineral_Extractor", good_pad)
			is_built=true
		end
		
		if faction_name == "REBEL" then
			MainForce.Build("UC_Rebel_Mineral_Extractor", good_pad)
			is_built=true
		end
		
		if faction_name == "GALACTIC_EMPIRE" then
			MainForce.Build("UC_Empire_Mineral_Extractor", good_pad)
			is_built=true
		end
		
		if faction_name == "REBEL_ALLIANCE" then
			MainForce.Build("UC_Rebel_Mineral_Extractor", good_pad)
			is_built=true
		end
			
		if faction_name == "OLD_REPUBLIC" then
			MainForce.Build("UC_OR_Mineral_Extractor", good_pad)
			is_built=true
		end
			
			
		if faction_name == "SITH" then
			MainForce.Build("UC_S_Mineral_Extractor", good_pad)
			is_built=true
		end
			
			
		if faction_name == "CIS" then
			MainForce.Build("UC_C_Mineral_Extractor", good_pad)
			is_built=true
		end
			
			
		if faction_name == "REPUBLIC" then
			MainForce.Build("UC_R_Mineral_Extractor", good_pad)
			is_built=true
		end
			
			
		if faction_name == "NEW_REPUBLIC" then
			MainForce.Build("UC_NR_Mineral_Extractor", good_pad)
			is_built=true
		end
			
			
		if faction_name == "IMPERIAL_REMNANT" then
			MainForce.Build("UC_IR_Mineral_Extractor", good_pad)
			is_built=true
		end
			
						
		if is_built == false then
			MessageBox("unexpected faction name: %s", faction_name)
		end

		-- Make sure we track the results	
		MainForce.Set_As_Goal_System_Removable(false)
	
		-- If it survives X (before 30, now 20) seconds, consider it a successful plan
		Sleep(20)
		if TestValid(good_pad) then
			refinery = good_pad.Get_Build_Pad_Contents()
			if TestValid(refinery) then
				MainForce.Set_Plan_Result(true)
			end
		end
	else
		-- This plan/target sucks. Pause for a moment, then release the allocated cash.
		Sleep(3)
	end
	
	ScriptExit()
end



