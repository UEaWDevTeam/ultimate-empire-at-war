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
-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/HideTransports.lua#2 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/AI/SpaceMode/HideTransports.lua $
--
--    Original Author: James Yarrow
--
--            $Author: James_Yarrow $
--
--            $Change: 44927 $
--
--          $DateTime: 2006/05/23 17:53:49 $
--
--          $Revision: #2 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("pgevents")

function Definitions()

	AllowEngagedUnits = false
	Category = "Hide_Transports"
	IgnoreTarget = true
	TaskForce = 
	{
		{
			"MainForce",
			"Transport = 1,4"
		},
		{
			"EscortForce",
			"Fighter = 0,2"
		}
	}

end

function MainForce_Thread()
	BlockOnCommand(MainForce.Produce_Force())
	
	while true do
		AITarget = FindTarget(MainForce, "Space_Area_Is_Hidden", "Tactical_Location", 0.8, 5000.0)
		
		if TestValid(AITarget) then		
			Try_Ability(MainForce, "STEALTH")
			MainForce.Attack_Target(AITarget, 1)
			Sleep(10)
		else
			Sleep(0.1)
		end
	end
	
	ScriptExit()
end 

function EscortForce_Thread()
	BlockOnCommand(EscortForce.Produce_Force())
	
	-- Give an initial order to put the escorts in a state that the Escort function expects
	EscortForce.Guard_Target(MainForce)

	EscortAlive = true
	while EscortAlive do
		Escort(EscortForce, MainForce)
	end
end

function MainForce_No_Units_Remaining()
	DebugMessage("%s -- All units dead or non-buildable.  Abandonning plan.", tostring(Script))
	ScriptExit()
end

function EscortForce_No_Units_Remaining()
	EscortAlive = false
end