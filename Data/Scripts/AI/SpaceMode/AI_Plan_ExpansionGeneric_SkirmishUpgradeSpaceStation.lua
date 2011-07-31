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