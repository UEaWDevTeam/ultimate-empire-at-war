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
--//////////////////////////////////////////////////////////////////////////////////////
--      UU    UU    EEEEEEEE     AAAA     WW   WW   WW
--      UU    UU    EE         AA    AA   WW   WW   WW
--      UU    UU    EEEEE      AAAAAAAA   WW   WW   WW
--      UU    UU    EE         AA    AA    WW WWWW WW
--       UUUUUU     EEEEEEEE   AA    AA      WW  WW
-- Controls Starbase Check, because marker always spawns the first specific marker object with the player's affiliation
-- For OR Starbase Level 3
--//////////////////////////////////////////////////////////////////////////////////////

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

        Define_State("State_Init", State_Init)

end

function State_Init(message) --initialise
        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end
		
		if message == OnEnter then
			--Find each possible enemy unit
			--Singleplayer
			--Sith
			S_SITH_FIGHTER_LIST = Find_All_Objects_Of_Type("S_SITH_FIGHTER_SQUADRON")
			S_SITH_BOMBER_LIST = Find_All_Objects_Of_Type("S_SITH_BOMBER_SQUADRON")
			S_SITH_GUNBOAT_LIST = Find_All_Objects_Of_Type("S_SITH_GUNBOAT_SQUADRON")
			S_HEAVY_CRUISER_LIST = Find_All_Objects_Of_Type("S_HEAVY_CRUISER")
			S_HEAVY_CRUISER_ADV_LIST = Find_All_Objects_Of_Type("S_HEAVY_CRUISER_ADV")
			S_INTERDICTOR_CRUISER_LIST = Find_All_Objects_Of_Type("S_INTERDICTOR_CRUISER")
			S_INTERDICTOR_CRUISER_ADV_LIST = Find_All_Objects_Of_Type("S_INTERDICTOR_CRUISER_ADV")
			S_CENTURION_LIST = Find_All_Objects_Of_Type("S_CENTURION")
			S_SITH_STAR_DESTROYER_LIST = Find_All_Objects_Of_Type("S_SITH_DESTROYER")
			S_RAVAGER_LIST = Find_All_Objects_Of_Type("S_RAVAGER")
			--CIS
			C_VULTURE_DROID_IAI_LIST = Find_All_Objects_Of_Type("C_VULTURE_DROID_IAI_SQUADRON")
			C_DROID_BOMBER_IAI_LIST = Find_All_Objects_Of_Type("C_DROID_BOMBER_IAI_SQUADRON")
			C_TRI_FIGHTER_LIST = Find_All_Objects_Of_Type("C_TRI_FIGHTER_SQUADRON")
			C_MISSILE_FRIGATE_LIST = Find_All_Objects_Of_Type("C_MISSILE_FRIGATE")
			C_RECUSANT_LIST = Find_All_Objects_Of_Type("C_RECUSANT")
			C_MUNIFICENT_LIST = Find_All_Objects_Of_Type("C_MUNIFICENT")
			C_RECUSANT_CARRIER_LIST = Find_All_Objects_Of_Type("C_RECUSANT_CARRIER")
			C_LUCREHULK_LIST = Find_All_Objects_Of_Type("C_LUCREHULK")
			C_LUCREHULK_CARRIER_LIST = Find_All_Objects_Of_Type("C_LUCREHULK_CARRIER")
			INVISIBLE_HAND_LIST = Find_All_Objects_Of_Type("INVISIBLE_HAND")
			--Empire
			E_TIE_SCOUT_LIST = Find_All_Objects_Of_Type("E_TIE_SCOUT_SQUADRON")
			E_TIE_DEFENDER_LIST = Find_All_Objects_Of_Type("E_TIE_DEFENDER_SQUADRON")
			E_XG_STAR_WING_LIST = Find_All_Objects_Of_Type("E_XG_STAR_WING_SQUADRON")
			E_TARTAN_CRUISER = Find_All_Objects_Of_Type("E_TARTAN_CRUISER")
			E_IPV_PATROL_CRAFT_LIST = Find_All_Objects_Of_Type("E_IPV_PATROL_CRAFT")
			E_BROADSIDE_LIST = Find_All_Objects_Of_Type("E_BROADSIDE")
			E_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST = Find_All_Objects_Of_Type("E_ACCLAMATOR_ASSAULT_FRIGATE_I")
			E_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST = Find_All_Objects_Of_Type("E_ACCLAMATOR_ASSAULT_FRIGATE_II")
			E_INTERDICTOR_CRUISER = Find_All_Objects_Of_Type("E_INTERDICTOR_CRUISER")
			E_DREADNAUGHT_LIST = Find_All_Objects_Of_Type("E_DREADNAUGHT")
			E_DREADNAUGHT_REFIT_LIST = Find_All_Objects_Of_Type("E_DREADNAUGHT_REFIT")
			E_VICTORY_I_LIST = Find_All_Objects_Of_Type("E_VICTORY_I")
			E_VICTORY_II_LIST = Find_All_Objects_Of_Type("E_VICTORY_II")
			E_ISDI_LIST = Find_All_Objects_Of_Type("E_ISDI")
			E_ISDII_LIST = Find_All_Objects_Of_Type("E_ISDII")
			UEAW_ACCUSER_LIST = Find_All_Objects_Of_Type("UEAW_Accuser")
			ARC_HAMMER_LIST = Find_All_Objects_Of_Type("Arc_Hammer")
			VADER_LIST = Find_All_Objects_Of_Type("Darth_Team_Space_MP")
			SLAVE_I_LIST = Find_All_Objects_Of_Type("Slave_I")
			--Imperial Remnant
			IR_TIE_SCOUT_LIST = Find_All_Objects_Of_Type("IR_TIE_SCOUT_SQUADRON")
			IR_TIE_DEFENDER_LIST = Find_All_Objects_Of_Type("IR_TIE_DEFENDER_SQUADRON")
			IR_TIE_PHANTOM_SQUADRON = Find_All_Objects_Of_Type("IR_TIE_DEFENDER_SQUADRON")
			IR_TIE_DROID_SQUADRON_LIST = Find_All_Objects_Of_Type("IR_TIE_DROID_SQUADRON")
			IR_XG_STAR_WING_LIST = Find_All_Objects_Of_Type("IR_XG_STAR_WING_SQUADRON")
			IR_TARTAN_CRUISER = Find_All_Objects_Of_Type("IR_TARTAN_CRUISER")
			IR_IPV_PATROL_CRAFT_LIST = Find_All_Objects_Of_Type("IR_IPV_PATROL_CRAFT")
			IR_LANCER_FRIGATE_LIST = Find_All_Objects_Of_Type("IR_LANCER_FRIGATE")
			IR_BROADSIDE_LIST = Find_All_Objects_Of_Type("IR_BROADSIDE")
			IR_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST = Find_All_Objects_Of_Type("IR_ACCLAMATOR_ASSAULT_FRIGATE_I")
			IR_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST = Find_All_Objects_Of_Type("IR_ACCLAMATOR_ASSAULT_FRIGATE_II")
			IR_INTERDICTOR_CRUISER = Find_All_Objects_Of_Type("IR_INTERDICTOR_CRUISER")
			IR_STRIKE_CLASS_CRUISER = Find_All_Objects_Of_Type("IR_STRIKE_CLASS_CRUISER")
			IR_DREADNAUGHT_REFIT_LIST = Find_All_Objects_Of_Type("IR_DREADNAUGHT_REFIT")
			IR_VICTORY_I_LIST = Find_All_Objects_Of_Type("IR_VICTORY_I")
			IR_VICTORY_II_LIST = Find_All_Objects_Of_Type("IR_VICTORY_II")
			IR_ISDI_LIST = Find_All_Objects_Of_Type("IR_ISDI")
			IR_ISDII_LIST = Find_All_Objects_Of_Type("IR_ISDII")
			IR_ECLIPSE_LIST = Find_All_Objects_Of_Type("IR_ECLIPSE")
			PELLAEON_LIST = Find_All_Objects_Of_Type("Chimaera_Star_Destroyer")
			THRAWN_LIST = Find_All_Objects_Of_Type("Admonitor_Star_Destroyer")
			EXECUTOR_LIST = Find_All_Objects_Of_Type("Executor_Super_Star_Destroyer")
			--Multiplayer
			E_TIE_SCOUT_MP_LIST = Find_All_Objects_Of_Type("E_TIE_SCOUT_MP_SQUADRON")
			E_TIE_DEFENDER_MP_LIST = Find_All_Objects_Of_Type("E_TIE_DEFENDER_MP_SQUADRON")
			E_XG_STAR_WING_MP_LIST = Find_All_Objects_Of_Type("E_XG_STAR_WING_MP_SQUADRON")
			E_TARTAN_CRUISER_MP = Find_All_Objects_Of_Type("E_TARTAN_CRUISER_MP")
			E_IPV_PATROL_CRAFT_MP_LIST = Find_All_Objects_Of_Type("E_IPV_PATROL_CRAFT_MP")
			E_BROADSIDE_MP_LIST = Find_All_Objects_Of_Type("E_BROADSIDE_MP")
			E_ACCLAMATOR_ASSAULT_FRIGATE_I_MP_LIST = Find_All_Objects_Of_Type("E_ACCLAMATOR_ASSAULT_FRIGATE_I_MP")
			E_ACCLAMATOR_ASSAULT_FRIGATE_II_MP_LIST = Find_All_Objects_Of_Type("E_ACCLAMATOR_ASSAULT_FRIGATE_II_MP")
			E_INTERDICTOR_CRUISER_MP = Find_All_Objects_Of_Type("E_INTERDICTOR_CRUISER_MP")
			E_DREADNAUGHT_MP_LIST = Find_All_Objects_Of_Type("E_DREADNAUGHT_MP")
			E_DREADNAUGHT_REFIT_MP_LIST = Find_All_Objects_Of_Type("E_DREADNAUGHT_REFIT_MP")
			E_VICTORY_I_MP_LIST = Find_All_Objects_Of_Type("E_VICTORY_I_MP")
			E_VICTORY_II_MP_LIST = Find_All_Objects_Of_Type("E_VICTORY_II_MP")
			E_ISDI_MP_LIST = Find_All_Objects_Of_Type("E_ISDI_MP")
			E_ISDII_MP_LIST = Find_All_Objects_Of_Type("E_ISDII_MP")			
			
			Rebel = Find_Player("Rebel")
			starbase_marker = Object.Get_Bone_Position("ROOT")
			
			--Check for CIS Units
			if table.getn(C_VULTURE_DROID_IAI_LIST) > 0 or table.getn(C_DROID_BOMBER_IAI_LIST) > 0 or table.getn(C_TRI_FIGHTER_LIST) > 0 or table.getn(C_MISSILE_FRIGATE_LIST) > 0 then
				starbase = { "R_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(C_RECUSANT_LIST) > 0 or table.getn(C_MUNIFICENT_LIST) > 0 or table.getn(C_RECUSANT_CARRIER_LIST) > 0 or table.getn(C_LUCREHULK_LIST) > 0 then				
				starbase = { "R_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(C_LUCREHULK_CARRIER_LIST) > 0 or table.getn(INVISIBLE_HAND_LIST) > 0 then
					starbase = { "R_STARBASE_3" } 
					SpawnList(starbase, starbase_marker, Rebel, true, true)		
					Object.Despawn()	
					ScriptExit()					
			end
			
			--Check for Empire Units
			if table.getn(E_TIE_SCOUT_LIST) > 0 or table.getn(E_TIE_DEFENDER_LIST) > 0 or table.getn(E_XG_STAR_WING_LIST) > 0 or table.getn(E_TARTAN_CRUISER) > 0 then
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_IPV_PATROL_CRAFT_LIST) > 0 or table.getn(E_BROADSIDE_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 then				
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_INTERDICTOR_CRUISER) > 0 or table.getn(E_DREADNAUGHT_LIST) > 0 or table.getn(E_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(E_VICTORY_I_LIST) > 0 then
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_VICTORY_II_LIST) > 0 or table.getn(E_ISDI_LIST) > 0 or table.getn(E_ISDII_LIST) > 0 or table.getn(UEAW_ACCUSER_LIST) > 0 then				
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(ARC_HAMMER_LIST) > 0 or table.getn(VADER_LIST) > 0 or table.getn(SLAVE_I_LIST) > 0 then				
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
						
			--Check for Imperial Remnant Units
			if table.getn(IR_TIE_SCOUT_LIST) > 0 or table.getn(IR_TIE_DEFENDER_LIST) > 0 or table.getn(IR_XG_STAR_WING_LIST) > 0 or table.getn(IR_TARTAN_CRUISER) > 0 then
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_IPV_PATROL_CRAFT_LIST) > 0 or table.getn(IR_BROADSIDE_LIST) > 0 or table.getn(IR_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(IR_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 then				
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_INTERDICTOR_CRUISER) > 0 or table.getn(IR_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(IR_VICTORY_I_LIST) > 0 then
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_VICTORY_II_LIST) > 0 or table.getn(IR_ISDI_LIST) > 0 or table.getn(IR_ISDII_LIST) > 0 or table.getn(IR_ECLIPSE_LIST) > 0 then				
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_TIE_PHANTOM_SQUADRON) > 0 or table.getn(IR_TIE_DROID_SQUADRON_LIST) > 0 or table.getn(IR_LANCER_FRIGATE_LIST) > 0 or table.getn(IR_STRIKE_CLASS_CRUISER) > 0 then				
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(PELLAEON_LIST) > 0 or table.getn(THRAWN_LIST) > 0 or table.getn(EXECUTOR_LIST) > 0 then				
				starbase = { "NR_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
						
			--Check for Empire Multiplayer Units
			if table.getn(E_TIE_SCOUT_MP_LIST) > 0 or table.getn(E_TIE_DEFENDER_MP_LIST) > 0 or table.getn(E_XG_STAR_WING_MP_LIST) > 0 or table.getn(E_TARTAN_CRUISER_MP) > 0 then
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_IPV_PATROL_CRAFT_MP_LIST) > 0 or table.getn(E_BROADSIDE_MP_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_I_MP_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_II_MP_LIST) > 0 then				
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_INTERDICTOR_CRUISER_MP) > 0 or table.getn(E_DREADNAUGHT_MP_LIST) > 0 or table.getn(E_DREADNAUGHT_REFIT_MP_LIST) > 0 or table.getn(E_VICTORY_I_MP_LIST) > 0 then
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_VICTORY_II_MP_LIST) > 0 or table.getn(E_ISDI_MP_LIST) > 0 or table.getn(E_ISDII_MP_LIST) > 0 then				
				starbase = { "RA_STARBASE_3" } 
				SpawnList(starbase, starbase_marker, Rebel, true, true)		
				Object.Despawn()	
				ScriptExit()
			end			
			
		end
end