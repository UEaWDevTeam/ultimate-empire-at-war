--//////////////////////////////////////////////////////////////////////////////////////
--      UU    UU    EEEEEEEE     AAAA     WW   WW   WW
--      UU    UU    EE         AA    AA   WW   WW   WW
--      UU    UU    EEEEE      AAAAAAAA   WW   WW   WW
--      UU    UU    EE         AA    AA    WW WWWW WW
--       UUUUUU     EEEEEEEE   AA    AA      WW  WW
-- Controls Starbase Check, because marker always spawns the first specific marker object with the player's affiliation
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
			C_HYENA_LIST = Fidn_All_Objects_Of
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

			--Republic
			R_V19_TORRENT_LIST = Find_All_Objects_Of_Type("R_V19_TORRENT_SQUADRON")
			R_NTB_630_LIST = Find_All_Objects_Of_Type("R_NTB_630_SQUADRON")
			R_V_WING_LIST = Find_All_Objects_Of_Type("R_V-WING_SQUADRON")
			R_ARC_170_LIST = Find_All_Objects_Of_Type("R_ARC-170_SQUADRON")
			R_VICTORY_FRIGATE_LIST = Find_All_Objects_Of_Type("R_VICTORY_FRIGATE")
			R_CONSULAR_CLASS_LIST = Find_All_Objects_Of_Type("R_CONSULAR_CLASS")
			R_LIGHT_CRUISER_LIST = Find_All_Objects_Of_Type("R_LIGHT_CRUISER")
			R_CARRACK_CRUISER_LIST = Find_All_Objects_Of_Type("R_CARRACK_CRUISER")
			R_CARRACK_CRUISER_ESCORT_LIST = Find_All_Objects_Of_Type("R_CARRACK_CRUISER_ESCORT")
			R_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST = Find_All_Objects_Of_Type("R_ACCLAMATOR_ASSAULT_FRIGATE_I")
			R_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST = Find_All_Objects_Of_Type("R_ACCLAMATOR_ASSAULT_FRIGATE_II")
			R_DREADNAUGHT_LIST = Find_All_Objects_Of_Type("R_DREADNAUGHT")
			R_VICTORY_LIST = Find_All_Objects_Of_Type("R_VICTORY_I")
			R_VENATOR_LIST = Find_All_Objects_Of_Type("R_VENATOR")
			ARRESTOR_LIST = Find_All_Objects_Of_Type("Arrestor")
			INTEGRITY_LIST = Find_All_Objects_Of_Type("Integrity")
			--Rebel
			RA_X_WING_LIST = Find_All_Objects_Of_Type("RA_X-WING_SQUADRON")
			RA_Y_WING_LIST = Find_All_Objects_Of_Type("RA_Y-WING_SQUADRON")
			RA_A_WING_LIST = Find_All_Objects_Of_Type("RA_A-WING_SQUADRON")
			RA_B_WING_LIST = Find_All_Objects_Of_Type("RA_B-WING_SQUADRON")
			RA_CORELLIAN_CORVETTE_LIST = Find_All_Objects_Of_Type("RA_CORELLIAN_CORVETTE")
			RA_CORELLIAN_GUNBOAT_LIST = Find_All_Objects_Of_Type("RA_CORELLIAN_GUNBOAT")
			RA_MARAUDER_LIST = Find_All_Objects_Of_Type("RA_MARAUDER")
			RA_EF76_FRIGATE_LIST = Find_All_Objects_Of_Type("RA_EF76_FRIGATE")
			RA_EF76_HOSPITAL_FRIGATE_LIST = Find_All_Objects_Of_Type("RA_EF76_HOSPITAL_FRIGATE")
			RA_DREADNAUGHT_LIST = Find_All_Objects_Of_Type("RA_DREADNAUGHT")
			RA_DREADNAUGHT_REFIT_LIST = Find_All_Objects_Of_Type("RA_DREADNAUGHT_REFIT")
			RA_ASSAULT_FRIGATE_I_LIST = Find_All_Objects_Of_Type("RA_ASSAULT_FRIGATE_I")
			RA_ASSAULT_FRIGATE_II_LIST = Find_All_Objects_Of_Type("RA_ASSAULT_FRIGATE_II")
			RA_MC30_FRIGATE_LIST = Find_All_Objects_Of_Type("RA_MC30_FRIGATE")
			RA_MC80_LIBERTYTYPE_LIST = Find_All_Objects_Of_Type("RA_MC80_LIBERTYTYPE")
			RA_MC80_HOMEONETYPE_LIST = Find_All_Objects_Of_Type("RA_MC80_HOMEONETYPE")
			HAN_SOLO_LIST = Find_All_Objects_Of_Type("Millennium_Falcon")
			ANTILLES_LIST = Find_All_Objects_Of_Type("Sundred_Heart")
			ROGUE_LIST = Find_All_Objects_Of_Type("Rogue_Squadron_Space")
			RED_LIST = Find_All_Objects_Of_Type("Red_Squadron")
			ACKBAR_LIST = Find_All_Objects_Of_Type("Home_One")
			--New Republic
			NR_X_WING_LIST = Find_All_Objects_Of_Type("NR_X-WING_SQUADRON")
			NR_Y_WING_LIST = Find_All_Objects_Of_Type("NR_Y-WING_SQUADRON")
			NR_A_WING_LIST = Find_All_Objects_Of_Type("NR_A-WING_SQUADRON")
			NR_B_WING_LIST = Find_All_Objects_Of_Type("NR_B-WING_SQUADRON")
			NR_E_WING_LIST = Find_All_Objects_Of_Type("NR_E-WING_SQUADRON")
			NR_K_WING_LIST = Find_All_Objects_Of_Type("NR_K-WING_SQUADRON")
			NR_K_WING_ESCORT_LIST = Find_All_Objects_Of_Type("NR_K-WING_ESCORT_SQUADRON")
			NR_CORELLIAN_CORVETTE_LIST = Find_All_Objects_Of_Type("NR_CORELLIAN_CORVETTE")
			NR_CORELLIAN_GUNBOAT_LIST = Find_All_Objects_Of_Type("NR_CORELLIAN_GUNBOAT")
			NR_MARAUDER_LIST = Find_All_Objects_Of_Type("NR_MARAUDER")
			NR_EF76_FRIGATE_LIST = Find_All_Objects_Of_Type("NR_EF76_FRIGATE")
			NR_EF76_HOSPITAL_FRIGATE_LIST = Find_All_Objects_Of_Type("NR_EF76_HOSPITAL_FRIGATE")
			NR_DREADNAUGHT_REFIT_LIST = Find_All_Objects_Of_Type("NR_DREADNAUGHT_REFIT")
			NR_QUASAR_FIRE_CRUISER_LIST = Find_All_Objects_Of_Type("NR_QUASAR_FIRE_CRUISER")
			NR_ASSAULT_FRIGATE_I_LIST = Find_All_Objects_Of_Type("NR_ASSAULT_FRIGATE_I")
			NR_ASSAULT_FRIGATE_II_LIST = Find_All_Objects_Of_Type("NR_ASSAULT_FRIGATE_II")
			NR_MC30_FRIGATE_LIST = Find_All_Objects_Of_Type("NR_MC30_FRIGATE")
			NR_MC80_LIBERTYTYPE_LIST = Find_All_Objects_Of_Type("NR_MC80_LIBERTYTYPE")
			NR_MC80_HOMEONETYPE_LIST = Find_All_Objects_Of_Type("NR_MC80_HOMEONETYPE")
			NR_NEBULA_CLASS_STAR_DESTROYER_LIST = Find_All_Objects_Of_Type("NR_NEBULA_CLASS_STAR_DESTROYER")
			NR_MC90_LIST = Find_All_Objects_Of_Type("NR_MC90")
			OBI_WAN_DESTROYER_LIST = Find_All_Objects_Of_Type("Obi_Wan_Destroyer")
			
			--Multiplayer
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
			
			RA_X_WING_MP_LIST = Find_All_Objects_Of_Type("RA_X-WING_MP_SQUADRON")
			RA_Y_WING_MP_LIST = Find_All_Objects_Of_Type("RA_Y-WING_MP_SQUADRON")
			RA_A_WING_MP_LIST = Find_All_Objects_Of_Type("RA_A-WING_MP_SQUADRON")
			RA_B_WING_MP_LIST = Find_All_Objects_Of_Type("RA_B-WING_MP_SQUADRON")
			RA_CORELLIAN_CORVETTE_MP_LIST = Find_All_Objects_Of_Type("RA_CORELLIAN_CORVETTE_MP")
			RA_CORELLIAN_GUNBOAT_MP_LIST = Find_All_Objects_Of_Type("RA_CORELLIAN_GUNBOAT_MP")
			RA_MARAUDER_MP_LIST = Find_All_Objects_Of_Type("RA_MARAUDER_MP")
			RA_EF76_FRIGATE_MP_LIST = Find_All_Objects_Of_Type("RA_EF76_FRIGATE_MP")
			RA_EF76_HOSPITAL_FRIGATE_MP_LIST = Find_All_Objects_Of_Type("RA_EF76_HOSPITAL_FRIGATE_MP")
			RA_DREADNAUGHT_MP_LIST = Find_All_Objects_Of_Type("RA_DREADNAUGHT_MP")
			RA_DREADNAUGHT_REFIT_MP_LIST = Find_All_Objects_Of_Type("RA_DREADNAUGHT_REFIT_MP")
			RA_ASSAULT_FRIGATE_I_MP_LIST = Find_All_Objects_Of_Type("RA_ASSAULT_FRIGATE_I_MP")
			RA_ASSAULT_FRIGATE_II_MP_LIST = Find_All_Objects_Of_Type("RA_ASSAULT_FRIGATE_II_MP")
			RA_MC30_FRIGATE_MP_LIST = Find_All_Objects_Of_Type("RA_MC30_FRIGATE_MP")
			RA_MC80_LIBERTYTYPE_MP_LIST = Find_All_Objects_Of_Type("RA_MC80_LIBERTYTYPE_MP")
			RA_MC80_HOMEONETYPE_MP_LIST = Find_All_Objects_Of_Type("RA_MC80_HOMEONETYPE_MP")
			
			--define player
			Owner = Object.Get_Owner()
			--define spawning position
			starbase_marker = Object.Get_Bone_Position("ROOT")
			
	
			if Owner == Find_Player("Rebel") then
			--define Player
				Player = Find_Player("Rebel")
			--define Level for a Rebel Starbase
				if Object == FindObject("OR_STARBASE_1") then
					level = 1
				end
				if Object == FindObject("OR_STARBASE_2") then
					level = 2
				end
				if Object == FindObject("OR_STARBASE_3") then
					level = 3
				end
				if Object == FindObject("OR_STARBASE_4") then
					level = 4
				end
				if Object == FindObject("OR_STARBASE_5") then
					level = 5
				end
			
			--Check for CIS Units
			if table.getn(C_VULTURE_DROID_IAI_LIST) > 0 or table.getn(C_DROID_BOMBER_IAI_LIST) > 0 or table.getn(C_TRI_FIGHTER_LIST) > 0 or table.getn(C_MISSILE_FRIGATE_LIST) > 0 then
				starbase = { "R_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(C_RECUSANT_LIST) > 0 or table.getn(C_MUNIFICENT_LIST) > 0 or table.getn(C_RECUSANT_CARRIER_LIST) > 0 or table.getn(C_LUCREHULK_LIST) > 0 then				
				starbase = { "R_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(C_LUCREHULK_CARRIER_LIST) > 0 or table.getn(INVISIBLE_HAND_LIST) > 0 then
				starbase = { "R_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()					
			end
			
			--Check for Empire Units
			if table.getn(E_TIE_SCOUT_LIST) > 0 or table.getn(E_TIE_DEFENDER_LIST) > 0 or table.getn(E_XG_STAR_WING_LIST) > 0 or table.getn(E_TARTAN_CRUISER) > 0 then
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_IPV_PATROL_CRAFT_LIST) > 0 or table.getn(E_BROADSIDE_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 then				
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_INTERDICTOR_CRUISER) > 0 or table.getn(E_DREADNAUGHT_LIST) > 0 or table.getn(E_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(E_VICTORY_I_LIST) > 0 then
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_VICTORY_II_LIST) > 0 or table.getn(E_ISDI_LIST) > 0 or table.getn(E_ISDII_LIST) > 0 or table.getn(UEAW_ACCUSER_LIST) > 0 then				
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(ARC_HAMMER_LIST) > 0 or table.getn(VADER_LIST) > 0 or table.getn(SLAVE_I_LIST) > 0 then				
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
						
			--Check for Imperial Remnant Units
			if table.getn(IR_TIE_SCOUT_LIST) > 0 or table.getn(IR_TIE_DEFENDER_LIST) > 0 or table.getn(IR_XG_STAR_WING_LIST) > 0 or table.getn(IR_TARTAN_CRUISER) > 0 then
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_IPV_PATROL_CRAFT_LIST) > 0 or table.getn(IR_BROADSIDE_LIST) > 0 or table.getn(IR_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(IR_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 then				
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_INTERDICTOR_CRUISER) > 0 or table.getn(IR_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(IR_VICTORY_I_LIST) > 0 then
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_VICTORY_II_LIST) > 0 or table.getn(IR_ISDI_LIST) > 0 or table.getn(IR_ISDII_LIST) > 0 or table.getn(IR_ECLIPSE_LIST) > 0 then				
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(IR_TIE_PHANTOM_SQUADRON) > 0 or table.getn(IR_TIE_DROID_SQUADRON_LIST) > 0 or table.getn(IR_LANCER_FRIGATE_LIST) > 0 or table.getn(IR_STRIKE_CLASS_CRUISER) > 0 then				
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(PELLAEON_LIST) > 0 or table.getn(THRAWN_LIST) > 0 or table.getn(EXECUTOR_LIST) > 0 then				
				starbase = { "NR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
						
			--Check for Empire Multiplayer Units
			if table.getn(E_TIE_SCOUT_MP_LIST) > 0 or table.getn(E_TIE_DEFENDER_MP_LIST) > 0 or table.getn(E_XG_STAR_WING_MP_LIST) > 0 or table.getn(E_TARTAN_CRUISER_MP) > 0 then
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_IPV_PATROL_CRAFT_MP_LIST) > 0 or table.getn(E_BROADSIDE_MP_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_I_MP_LIST) > 0 or table.getn(E_ACCLAMATOR_ASSAULT_FRIGATE_II_MP_LIST) > 0 then				
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_INTERDICTOR_CRUISER_MP) > 0 or table.getn(E_DREADNAUGHT_MP_LIST) > 0 or table.getn(E_DREADNAUGHT_REFIT_MP_LIST) > 0 or table.getn(E_VICTORY_I_MP_LIST) > 0 then
				starbase = { "RA_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(E_VICTORY_II_MP_LIST) > 0 or table.getn(E_ISDI_MP_LIST) > 0 or table.getn(E_ISDII_MP_LIST) > 0 then				
				starbase = { "RA_STARBASE_..level" } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			else
			--define Player
				Player = Find_Player("Empire")
			--define Level for a Empire Starbase
				if Object == FindObject("S_STARBASE_1") then
					level = 1
				end
				if Object == FindObject("S_STARBASE_2") then
					level = 2
				end
				if Object == FindObject("S_STARBASE_3") then
					level = 3
				end
				if Object == FindObject("S_STARBASE_4") then
					level = 4
				end
				if Object == FindObject("S_STARBASE_5") then
					level = 5
				end			
				
			--Check for Republic Units
			if table.getn(R_V19_TORRENT_LIST) > 0 or table.getn(R_NTB_630_LIST) > 0 or table.getn(R_V_WING_LIST) > 0 or table.getn(R_ARC_170_LIST) > 0 then
				starbase = { "C_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(R_VICTORY_FRIGATE_LIST) > 0 or table.getn(R_CONSULAR_CLASS_LIST) > 0 or table.getn(R_LIGHT_CRUISER_LIST) > 0 or table.getn(R_CARRACK_CRUISER_LIST) > 0 then
				starbase = { "C_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end			

			if table.getn(R_CARRACK_CRUISER_ESCORT_LIST) > 0 or table.getn(R_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(R_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 or table.getn(R_DREADNAUGHT_LIST) > 0 then
				starbase = { "C_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(R_VENATOR_LIST) > 0 or table.getn(ARRESTOR_LIST) > 0 or table.getn(INTEGRITY_LIST) > 0 or table.getn(R_VICTORY_LIST) > 0 then
				starbase = { "C_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			--Check for Rebel Units
			if table.getn(RA_X_WING_LIST) > 0 or table.getn(RA_Y_WING_LIST) > 0 or table.getn(RA_A_WING_LIST) > 0 or table.getn(RA_B_WING_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(RA_CORELLIAN_CORVETTE_LIST) > 0 or table.getn(RA_CORELLIAN_GUNBOAT_LIST) > 0 or table.getn(RA_MARAUDER_LIST) > 0 or table.getn(RA_EF76_HOSPITAL_FRIGATE_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(RA_EF76_FRIGATE_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(RA_DREADNAUGHT_LIST) > 0 or table.getn(RA_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_II_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(RA_MC30_FRIGATE_LIST) > 0 or table.getn(RA_MC80_LIBERTYTYPE_LIST) > 0 or table.getn(RA_MC80_HOMEONETYPE_LIST) > 0 or table.getn(HAN_SOLO_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(ANTILLES_LIST) > 0 or table.getn(ROGUE_LIST) > 0 or table.getn(RED_LIST) > 0 or table.getn(ACKBAR_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			--Check for New Republic Units
			if table.getn(NR_X_WING_LIST) > 0 or table.getn(NR_Y_WING_LIST) > 0 or table.getn(NR_A_WING_LIST) > 0 or table.getn(NR_B_WING_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(NR_CORELLIAN_CORVETTE_LIST) > 0 or table.getn(NR_CORELLIAN_GUNBOAT_LIST) > 0 or table.getn(NR_MARAUDER_LIST) > 0 or table.getn(NR_EF76_HOSPITAL_FRIGATE_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(NR_EF76_FRIGATE_LIST) > 0 or table.getn(NR_E_WING_LIST) > 0 or table.getn(NR_K_WING_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(NR_K_WING_ESCORT_LIST) > 0 or table.getn(NR_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(NR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(NR_ASSAULT_FRIGATE_II_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(NR_MC30_FRIGATE_LIST) > 0 or table.getn(NR_MC80_LIBERTYTYPE_LIST) > 0 or table.getn(NR_MC80_HOMEONETYPE_LIST) > 0 or table.getn(HAN_SOLO_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(OBI_WAN_DESTROYER_LIST) > 0 or table.getn(NR_NEBULA_CLASS_STAR_DESTROYER_LIST) > 0 or table.getn(NR_MC90_LIST) > 0 or table.getn(NR_QUASAR_FIRE_CRUISER_LIST) > 0 then
				starbase = { "IR_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		
			
			--Check for Multiplayer Rebel Units
			if table.getn(RA_X_WING_MP_LIST) > 0 or table.getn(RA_Y_WING_MP_LIST) > 0 or table.getn(RA_A_WING_MP_LIST) > 0 or table.getn(RA_B_WING_MP_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(RA_CORELLIAN_CORVETTE_MP_LIST) > 0 or table.getn(RA_CORELLIAN_GUNBOAT_MP_LIST) > 0 or table.getn(RA_MARAUDER_MP_LIST) > 0 or table.getn(RA_EF76_HOSPITAL_FRIGATE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(RA_EF76_FRIGATE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(RA_DREADNAUGHT_MP_LIST) > 0 or table.getn(RA_DREADNAUGHT_REFIT_MP_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_I_MP_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_II_MP_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(RA_MC30_FRIGATE_MP_LIST) > 0 or table.getn(RA_MC80_LIBERTYTYPE_MP_LIST) > 0 or table.getn(RA_MC80_HOMEONETYPE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_"..level } 
				SpawnList(starbase, starbase_marker, Player, true, true)		
				Object.Despawn()	
				ScriptExit()
			end			
			end
	end
end