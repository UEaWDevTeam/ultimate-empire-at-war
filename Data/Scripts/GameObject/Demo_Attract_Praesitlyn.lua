-- $Id: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/Demo_Attract_Controller.lua#1 $
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
--              $File: //depot/Projects/StarWars_Expansion/Run/Data/Scripts/GameObject/Demo_Attract_Controller.lua $
--
--    Original Author: Dan Etter
--
--            $Author: Dan_Etter $
--
--            $Change: 41675 $
--
--          $DateTime: 2006/04/21 13:38:27 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStateMachine")
require("PGStoryMode")


function Definitions()

	-- Object isn't valid at this point so don't do any operations that
    -- would require it.  State_Init is the first chance you have to do
    -- operations on Object
   
	DebugMessage("%s -- In Definitions", tostring(Script))
		
	Define_State("State_Init", State_Init); --Begin script

	dark_player = Find_Player("Dark_Side") --Find the dark/light side players
	light_player = Find_Player("Light_Side")
	
	move_command = true --initialise a variable
					
	controller = Find_First_Object("DEMO_ATTRACT_PRAESITLYN") --find the demo attract marker
	providence = Find_Object_Type("C_PROVIDENCE") --find these objects and assign them to the variables

end


function State_Init(message) --initialise
	
	if (move_command == true) then -- when the move command is true
	
		dark_reveal = FogOfWar.Reveal_All(dark_player) --reveal FoW for both players
		light_reveal = FogOfWar.Reveal_All(light_player)
	
		dark_unit_list = Find_All_Objects_Of_Type(dark_player) --Find all the units controlled by each player
		light_unit_list = Find_All_Objects_Of_Type(light_player)
		
		l_goto_list = Find_All_Objects_Of_Type ("STORY_TRIGGER_ZONE_00") --create the location list from all markers of the named type
		d_goto_list = Find_All_Objects_Of_Type ("STORY_TRIGGER_ZONE_01")
				
		Move_Fleet(light_unit_list, l_goto_list) --move the light side fleet to the markers
		
		Sleep(5)
		
		Move_Fleet(dark_unit_list, d_goto_list)
		
		--MessageBox("Fleets Defined")
		
		move_command = false --end the movement
	end

end

function Move_Fleet(list, loc_list)	--this function randomises the movement of ships not listed below
	for k, unit in pairs(list) do --cycle through
		if TestValid(unit) then --check units exist
			if not --checks unit type
				(unit.Get_Type() == providence) then --if it's not one of these
				
				rand_loc = GameRandom(1,3) --create a random number for a location between 1 and 3
				unit.Attack_Move(loc_list[rand_loc].Get_Position()) --attack move to one of the markers, chosen at random
			end
		end
	end
end
