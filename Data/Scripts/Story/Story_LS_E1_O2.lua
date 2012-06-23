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
-- UEAW CAMPAIGN LUA file

--Do not redistribute without permission

--Controls 2. objective in the campaign (capture revan)

require("PGStoryMode")

function Definitions()

	DebugMessage("%s -- In Definitions", tostring(Script))
	
	StoryModeEvents = 
	{
		LS_E1_O2_Begin = State_LS_E1_O2_Begin
		--,LS_E1_O2_Dialog_Line_01_Remove_Text = State_IntroCine_Dialog_Line_01_Remove_Text
	}
	
	exit_range = 300

	first_time_serviced = true
	flag_shuttles_escaping = false
	
	fog_id = nil
end

function State_LS_E1_O2_Begin(message)
	if message == OnEnter then
	
		-- Prevent the AI from performing an automatic fog of war reveal for this tactical scenario.
		-- MessageBox("disallowing ai controlled fog reveal")
		GlobalValue.Set("Allow_AI_Controlled_Fog_Reveal", 0)
		
		LS_player = Find_Player("Light_Side")

		-- Find the transport
		transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
		if not transport1 then
			return
		end
		
		--find revans flag
		revanflag = Find_First_Object("S_INTERDICTOR_CRUISER", "revanflag")
		if not revanflag then
			return
		end
		
		-- Exit point for shuttles														 
		exit_marker = Find_Hint("GENERIC_MARKER_SPACE", "escapepoint")
		if TestValid(exit_marker) then
			Register_Prox(exit_marker, Exit_Prox, exit_range, LS_player)
		else
			return
		end

		-- Get all of the defense satellites
		sat_list = Find_All_Objects_With_Hint("defense_sat")
		for i, sat in pairs(sat_list) do
			if TestValid(sat) then
				sat.Prevent_AI_Usage(true)
				sat.Prevent_Opportunity_Fire(true)
			end
		end

		MoveTransportToRevan()

	end
end

------------------------------------------------------------------------------------------------------------------------
-- Opening Cinematic stuff
------------------------------------------------------------------------------------------------------------------------
function Intro_Cinematic()

	Suspend_AI(1)
	Lock_Controls(1)
	Letter_Box_In(0)

	transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
	
	if not transport1 then
		return
	end

	Start_Cinematic_Camera()
	
	Set_Cinematic_Camera_Key(transport1, 600, 15, 60, 1, 0, 0, 0)
	Set_Cinematic_Target_Key(transport1, 0, 0, 0, 0, 0, 0, 0)	

	--Resume_Hyperspace_In() 
	
	if TestValid(transport1) then
		--transport1.Cinematic_Hyperspace_In(69)
		transport1.Cinematic_Hyperspace_In(9)
	end
	
	Fade_Screen_In(1)
	Sleep(1)
	Resume_Hyperspace_In() 
	Sleep(5)
	
	Transition_Cinematic_Camera_Key(transport1, 6.0, 375, 15, 310, 1, 0, 0, 0)
	Transition_Cinematic_Target_Key(transport1, 2.5, 0, 0, 0, 0, 0, 0, 0)
	Sleep(5)
	
	Story_Event("CUE_M09_DIALOG_REBELPILOT_01") 
end

----------------------------------------------------------------------------------
-- cinematic dialog lua callbacks here
-----------------------------------------------------------------------------------

function State_IntroCine_Dialog_Line_01_Remove_Text(message)
	if message == OnEnter then
		
		Sleep(1)
		
		bastila = Find_First_Object("RM09_ALLIANCE_SHUTTLE", "1")
		
		if not TestValid(bastila) then
			return
		end
		
		Set_Cinematic_Camera_Key(bastila, 500, 18, 290, 1, 0, 0, 0)
		Set_Cinematic_Target_Key(bastila, 0, 0, 0, 0, 0, 0, 0)
		Transition_Cinematic_Camera_Key(bastila, 20.0, 450, 13, 260, 1, 0, 0, 0)
		
		MoveTransportToRevan()
	end
end

function MoveTransportToRevan()
	if not flag_shuttles_escaping then

		transport1 = Find_Hint("RM09_ALLIANCE_SHUTTLE", "1")
		
		transport1_move_to = Find_Hint("S_INTERDICTOR_CRUISER", "revanflag")

		if TestValid(transport1) then
			transport1.Move_To(transport1_move_to)
		end
		
	end   	
end

function Exit_Prox(prox_obj, trigger_obj)
	--MessageBox("Rebel unit close to marker")
	if trigger_obj == transport1 then
		Story_Event("shuttles_clear")
		prox_obj.Cancel_Event_Object_In_Range(Exit_Prox)
	end
end

function SwitchToLS(unit)
	unit.Set_Selectable(false)
	unit.Change_Owner(LS_player)
	--unit.Prevent_Opportunity_Fire(false)
	unit.Suspend_Locomotor(true)
	--unit.Prevent_All_Fire(true)
	
end