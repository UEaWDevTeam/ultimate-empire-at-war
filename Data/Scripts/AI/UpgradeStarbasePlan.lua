-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/UpgradeStarbasePlan.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/UpgradeStarbasePlan.lua $
--
--    Original Author: James Yarrow
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

-- Tell the script pooling system to pre-cache this number of scripts.
ScriptPoolCount = 16

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
	
	Category = "Upgrade_Starbase"
	IgnoreTarget = true
	TaskForce = {
	{
		"BaseForce",
		"S_STARBASE_1 | S_STARBASE_2 | S_STARBASE_3 | S_STARBASE_4 | S_STARBASE_5 = 1",
		"C_STARBASE_1 | C_STARBASE_2 | C_STARBASE_3 | C_STARBASE_4 | C_STARBASE_5 = 1",
		"E_STARBASE_1 | E_STARBASE_2 | E_STARBASE_3 | E_STARBASE_4 | E_STARBASE_5 = 1",
		"IR_STARBASE_1 | IR_STARBASE_2 | IR_STARBASE_3 | IR_STARBASE_4 | IR_STARBASE_5 = 1",
		"OR_STARBASE_1 | OR_STARBASE_2 | OR_STARBASE_3 | OR_STARBASE_4 | OR_STARBASE_5 = 1",
		"R_STARBASE_1 | R_STARBASE_2 | R_STARBASE_3 | R_STARBASE_4 | R_STARBASE_5 = 1",
		"RA_STARBASE_1 | RA_STARBASE_2 | RA_STARBASE_3 | RA_STARBASE_4 | RA_STARBASE_5 = 1",
		"NR_STARBASE_1 | NR_STARBASE_2 | NR_STARBASE_3 | NR_STARBASE_4 | NR_STARBASE_5 = 1"
	}
	}

	DebugMessage("%s -- Done Definitions", tostring(Script))
end

function BaseForce_Thread()
	DebugMessage("%s -- In BaseForce_Thread.", tostring(Script))
	
	BaseForce.Set_As_Goal_System_Removable(false)
	AssembleForce(BaseForce)
	
	BaseForce.Set_Plan_Result(true)
	DebugMessage("%s -- BaseForce done!", tostring(Script));
	ScriptExit()
end

function BaseForce_Production_Failed(tf, failed_object_type)
	DebugMessage("%s -- Abandonning plan owing to production failure.", tostring(Script))
	ScriptExit()
end