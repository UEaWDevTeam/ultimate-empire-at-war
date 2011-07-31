-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildStructureSpace.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/BuildStructureSpace.lua $
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
	
	Category = "Build_Structure_Space"
	IgnoreTarget = true
	TaskForce = {
	{
		"MainForce"
		,"UC_S_DEFSAT_L | UC_S_DEFSAT_M | UC_S_DEFSAT_R = 0,1"
		,"UC_OR_DEFSAT_L | UC_OR_DEFSAT_M | UC_OR_DEFSAT_R = 0,1"
		,"UC_C_DEFSAT_L | UC_C_DEFSAT_M | UC_C_DEFSAT_R = 0,1"
		,"UC_R_DEFSAT_L | UC_R_DEFSAT_M | UC_R_DEFSAT_R = 0,1"
		,"UC_RA_DEFSAT_L | UC_RA_DEFSAT_M | UC_RA_DEFSAT_R = 0,1"
		,"UC_E_DEFSAT_L | UC_E_DEFSAT_M | UC_E_DEFSAT_R = 0,1"
		,"UC_IR_DEFSAT_L | UC_IR_DEFSAT_M | UC_IR_DEFSAT_R = 0,1"
		,"UC_NR_DEFSAT_L | UC_NR_DEFSAT_M | UC_NR_DEFSAT_R = 0,1"
	}
	}
	RequiredCategories = {"Structure"}
	AllowFreeStoreUnits = false

end

function MainForce_Thread()

	BlockOnCommand(MainForce.Build_All())
	MainForce.Set_Plan_Result(true)
	ScriptExit()
end


