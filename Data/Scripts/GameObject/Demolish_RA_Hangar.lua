-- UEAW LUA file

--Do not redistribute without permission
--planet_list = {"Abregado_Rae_E1", "Abregado_Rae_E2", "Abregado_Rae_E3", "Abregado_Rae_E4", "Aeten_II_E1", "Aeten_II_E2", "Aeten_II_E3", "Aeten_II_E4", "Alderaan_E1", "Alderaan_E2", "Alderaan_E3", "Alderaan_E4", "AlzocIII_E1", "AlzocIII_E2", "AlzocIII_E3", "AlzocIII_E4", "Anaxes_E1", "Anaxes_E2", "Anaxes_E3", "Anaxes_E4", "Atzerri_E1", "Atzerri_E2", "Atzerri_E3", "Atzerri_E4", "Bastion_E1", "Bastion_E2", "Bastion_E3", "Bastion_E4", "Bestine_E1", "Bestine_E2", "Bestine_E3", "Bestine_E4", "Bespin_E1", "Bespin_E2", "Bespin_E3", "Bespin_E4", "Bonadan_E1", "Bonadan_E2", "Bonadan_E3", "Bonadan_E4", "Bothawui_E1", "Bothawui_E2", "Bothawui_E3", "Bothawui_E4", "Breental_E1", "Breental_E2", "Breental_E3", "Breental_E4", "Byss_E1", "Byss_E2", "Byss_E3", "Byss_E4", "Carida_E1", "Carida_E2", "Carida_E3", "Carida_E4", "Corellia_E1", "Corellia_E2", "Corellia_E3", "Corellia_E4", "Corulag_E1", "Corulag_E2", "Corulag_E3", "Corulag_E4", "Coruscant_E1", "Coruscant_E2", "Coruscant_E3", "Coruscant_E4", "Dagobah_E1", "Dagobah_E2", "Dagobah_E3", "Dagobah_E4", "Dantooine_E1", "Dantooine_E2", "Dantooine_E3", "Dantooine_E4", "Dathomir_E1", "Dathomir_E2", "Dathomir_E3", "Dathomir_E4", "Dxun_E1", "Dxun_E2", "Dxun_E3", "Dxun_E4", "Endor_E1", "Endor_E2", "Endor_E3", "Endor_E4", "Eriadu_E1", "Eriadu_E2", "Eriadu_E3", "Eriadu_E4", "Felucia_E1", "Felucia_E2", "Felucia_E3", "Felucia_E4", "Fondor_E1", "Fondor_E2", "Fondor_E3", "Fondor_E4", "Fresia_E1", "Fresia_E2", "Fresia_E3", "Fresia_E4", "Geonosis_E1", "Geonosis_E2", "Geonosis_E3", "Geonosis_E4", "Hapes_E1", "Hapes_E2", "Hapes_E3", "Hapes_E4", "Honoghr_E1", "Honoghr_E2", "Honoghr_E3", "Honoghr_E4", "Hoth_E1", "Hoth_E2", "Hoth_E3", "Hoth_E4", "Hypori_E1", "Hypori_E2", "Hypori_E3", "Hypori_E4", "Ilum_E1", "Ilum_E2", "Ilum_E3", "Ilum_E4", "Jabiim_E1", "Jabiim_E2", "Jabiim_E3", "Jabiim_E4", "Kamino_E1", "Kamino_E2", "Kamino_E3", "Kamino_E4", "Kashyyyk_E1", "Kashyyyk_E2", "Kashyyyk_E3", "Kashyyyk_E4", "Kessel_E1", "Kessel_E2", "Kessel_E3", "Kessel_E4", "Korriban_E1", "Korriban_E2", "Korriban_E3", "Korriban_E4", "Kuat_E1", "Kuat_E2", "Kuat_E3", "Kuat_E4", "Lok_E1", "Lok_E2", "Lok_E3", "Lok_E4", "Manaan_E1", "Manaan_E2", "Manaan_E3", "Manaan_E4", "Mandalore_E1", "Mandalore_E2", "Mandalore_E3", "Mandalore_E4", "Mechis3_E1", "Mechis3_E2", "Mechis3_E3", "Mechis3_E4", "MonCalimari_E1", "MonCalimari_E2", "MonCalimari_E3", "MonCalimari_E4", "Mustafar_E1", "Mustafar_E2", "Mustafar_E3", "Mustafar_E4", "Muunilinst_E1", "Muunilinst_E2", "Muunilinst_E3", "Muunilinst_E4", "Myrkr_E1", "Myrkr_E2", "Myrkr_E3", "Myrkr_E4", "Naboo_E1", "Naboo_E2", "Naboo_E3", "Naboo_E4", "NalHutta_E1", "NalHutta_E2", "NalHutta_E3", "NalHutta_E4", "Onderon_E1", "Onderon_E2", "Onderon_E3", "Onderon_E4", "Ord_Mantell_E1", "Ord_Mantell_E2", "Ord_Mantell_E3", "Ord_Mantell_E4", "Polus_E1", "Polus_E2", "Polus_E3", "Polus_E4", "Praesitlyn_E1", "Praesitlyn_E2", "Praesitlyn_E3", "Praesitlyn_E4", "Rhyloth_E1", "Rhyloth_E2", "Rhyloth_E3", "Rhyloth_E4", "Saleucami_E1", "Saleucami_E2", "Saleucami_E3", "Saleucami_E4", "Shola_E1", "Shola_E2", "Shola_E3", "Shola_E4", "Sluis_Van_E1", "Sluis_Van_E2", "Sluis_Van_E3", "Sluis_Van_E4", "Sullust_E1", "Sullust_E2", "Sullust_E3", "Sullust_E4", "Taris_E1", "Taris_E2", "Taris_E3", "Taris_E4", "Tatooine_E1", "Tatooine_E2", "Tatooine_E3", "Tatooine_E4", "The_Maw_E1", "The_Maw_E2", "The_Maw_E3", "The_Maw_E4", "Thyferra_E1", "Thyferra_E2", "Thyferra_E3", "Thyferra_E4", "Trandosha_E1", "Trandosha_E2", "Trandosha_E3", "Trandosha_E4", "Utapau_E1", "Utapau_E2", "Utapau_E3", "Utapau_E4", "Wayland_E1", "Wayland_E2", "Wayland_E3", "Wayland_E4", "VergessoAsteroids_E1", "VergessoAsteroids_E2", "VergessoAsteroids_E3", "VergessoAsteroids_E4", "Yaga_Minor_E1", "Yaga_Minor_E2", "Yaga_Minor_E3", "Yaga_Minor_E4", "Yavin_E1", "Yavin_E2", "Yavin_E3", "Yavin_E4", "Rakata_Prime_E1", "Rakata_Prime_E2", "Rakata_Prime_E3", "Rakata_Prime_E4"}			
			
--Controls Demolish Structure demolish ability

require ("PGStateMachine")
require("PGStoryMode")

function Definitions ()

	DebugMessage("%s -- In Definitions", tostring(Script))
	Define_State("State_Init", State_Init);

end

function State_Init(message)
		if message == OnEnter then
			Planet = Object.Get_Planet_Location()
			--Structure which has to be demolished
			structures = Find_All_Objects_Of_Type("RA_HANGAR")
			for i, obj in pairs(structures) do
				if(obj.Get_Planet_Location() == Planet) then
					obj.Despawn()
				end
			end
			Object.Despawn()
		end
end