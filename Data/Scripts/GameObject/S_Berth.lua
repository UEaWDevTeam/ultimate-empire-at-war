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
-- UEAW LUA file

--Do not redistribute without permission

--Controls Capital berth launching ability at start

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

        Define_State("State_Init", State_Init)
end

function State_Init(message) --initialise

        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end

        if message == OnEnter then --unit has entered the game
				Owner = Object.Get_Owner()
				 
				empire_list_0 = 
				{
					"S_SITH_STAR_DESTROYER"
				}
				ReinforceList(empire_list_0, Object.Get_Bone_Position("SPAWN_00"), Owner, true, true, true) 
		elseif message == OnUpdate then --if the unit is doing something
			
		end
end