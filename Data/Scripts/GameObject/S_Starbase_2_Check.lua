--//////////////////////////////////////////////////////////////////////////////////////
--      UU    UU    EEEEEEEE     AAAA     WW   WW   WW
--      UU    UU    EE         AA    AA   WW   WW   WW
--      UU    UU    EEEEE      AAAAAAAA   WW   WW   WW
--      UU    UU    EE         AA    AA    WW WWWW WW
--       UUUUUU     EEEEEEEE   AA    AA      WW  WW
-- Controls Starbase Check, because marker always spawns the first specific marker object with the player's affiliation
-- For S Starbase Level 2
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
			
			Empire = Find_Player("Empire")
			starbase_marker = Object.Get_Bone_Position("ROOT")
			
			--Check for Republic Units
			if table.getn(R_V19_TORRENT_LIST) > 0 or table.getn(R_NTB_630_LIST) > 0 or table.getn(R_V_WING_LIST) > 0 or table.getn(R_ARC_170_LIST) > 0 then
				starbase = { "C_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(R_VICTORY_FRIGATE_LIST) > 0 or table.getn(R_CONSULAR_CLASS_LIST) > 0 or table.getn(R_LIGHT_CRUISER_LIST) > 0 or table.getn(R_CARRACK_CRUISER_LIST) > 0 then
				starbase = { "C_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end			

			if table.getn(R_CARRACK_CRUISER_ESCORT_LIST) > 0 or table.getn(R_ACCLAMATOR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(R_ACCLAMATOR_ASSAULT_FRIGATE_II_LIST) > 0 or table.getn(R_DREADNAUGHT_LIST) > 0 then
				starbase = { "C_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(R_VENATOR_LIST) > 0 or table.getn(ARRESTOR_LIST) > 0 or table.getn(INTEGRITY_LIST) > 0 or table.getn(R_VICTORY_LIST) > 0 then
				starbase = { "C_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			--Check for Rebel Units
			if table.getn(RA_X_WING_LIST) > 0 or table.getn(RA_Y_WING_LIST) > 0 or table.getn(RA_A_WING_LIST) > 0 or table.getn(RA_B_WING_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(RA_CORELLIAN_CORVETTE_LIST) > 0 or table.getn(RA_CORELLIAN_GUNBOAT_LIST) > 0 or table.getn(RA_MARAUDER_LIST) > 0 or table.getn(RA_EF76_HOSPITAL_FRIGATE_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(RA_EF76_FRIGATE_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(RA_DREADNAUGHT_LIST) > 0 or table.getn(RA_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_II_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(RA_MC30_FRIGATE_LIST) > 0 or table.getn(RA_MC80_LIBERTYTYPE_LIST) > 0 or table.getn(RA_MC80_HOMEONETYPE_LIST) > 0 or table.getn(HAN_SOLO_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(ANTILLES_LIST) > 0 or table.getn(ROGUE_LIST) > 0 or table.getn(RED_LIST) > 0 or table.getn(ACKBAR_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			--Check for New Republic Units
			if table.getn(NR_X_WING_LIST) > 0 or table.getn(NR_Y_WING_LIST) > 0 or table.getn(NR_A_WING_LIST) > 0 or table.getn(NR_B_WING_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(NR_CORELLIAN_CORVETTE_LIST) > 0 or table.getn(NR_CORELLIAN_GUNBOAT_LIST) > 0 or table.getn(NR_MARAUDER_LIST) > 0 or table.getn(NR_EF76_HOSPITAL_FRIGATE_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(NR_EF76_FRIGATE_LIST) > 0 or table.getn(NR_E_WING_LIST) > 0 or table.getn(NR_K_WING_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(NR_K_WING_ESCORT_LIST) > 0 or table.getn(NR_DREADNAUGHT_REFIT_LIST) > 0 or table.getn(NR_ASSAULT_FRIGATE_I_LIST) > 0 or table.getn(NR_ASSAULT_FRIGATE_II_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(NR_MC30_FRIGATE_LIST) > 0 or table.getn(NR_MC80_LIBERTYTYPE_LIST) > 0 or table.getn(NR_MC80_HOMEONETYPE_LIST) > 0 or table.getn(HAN_SOLO_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end
			
			if table.getn(OBI_WAN_DESTROYER_LIST) > 0 or table.getn(NR_NEBULA_CLASS_STAR_DESTROYER_LIST) > 0 or table.getn(NR_MC90_LIST) > 0 or table.getn(NR_QUASAR_FIRE_CRUISER_LIST) > 0 then
				starbase = { "IR_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	
			
			--Check for Multiplayer Rebel Units
			if table.getn(RA_X_WING_MP_LIST) > 0 or table.getn(RA_Y_WING_MP_LIST) > 0 or table.getn(RA_A_WING_MP_LIST) > 0 or table.getn(RA_B_WING_MP_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end

			if table.getn(RA_CORELLIAN_CORVETTE_MP_LIST) > 0 or table.getn(RA_CORELLIAN_GUNBOAT_MP_LIST) > 0 or table.getn(RA_MARAUDER_MP_LIST) > 0 or table.getn(RA_EF76_HOSPITAL_FRIGATE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end	

			if table.getn(RA_EF76_FRIGATE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end				

			if table.getn(RA_DREADNAUGHT_MP_LIST) > 0 or table.getn(RA_DREADNAUGHT_REFIT_MP_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_I_MP_LIST) > 0 or table.getn(RA_ASSAULT_FRIGATE_II_MP_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end		

			if table.getn(RA_MC30_FRIGATE_MP_LIST) > 0 or table.getn(RA_MC80_LIBERTYTYPE_MP_LIST) > 0 or table.getn(RA_MC80_HOMEONETYPE_MP_LIST) > 0 then
				starbase = { "E_STARBASE_2" } 
				SpawnList(starbase, starbase_marker, Empire, true, true)		
				Object.Despawn()	
				ScriptExit()
			end			
		end
end