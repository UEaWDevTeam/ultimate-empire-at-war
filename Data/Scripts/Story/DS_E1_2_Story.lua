--//////////////////////////////////////////////////////////////////////////////////////
--       #                                   ######
--      # #   #      #####  #    #   ##      #     # #      #    # ######
--     #   #  #      #    # #    #  #  #     #     # #      #    # #
--    #     # #      #    # ###### #    #    ######  #      #    # #####
--    ####### #      #####  #    # ######    #     # #      #    # #
--    #     # #      #      #    # #    #    #     # #      #    # #
--    #     # ###### #      #    # #    #    ######  ######  ####  ######
--
--
-- Displays a screen text containing all orbital structures when zooming into a planet
-- © SmallPox
-- Modified for UEAW GC E1 LS (so not just Smallpoxscript :P)
--//////////////////////////////////////////////////////////////////////////////////////

require("PGDebug")
require("PGStateMachine")
require("PGStoryMode")

function Definitions()

        DebugMessage("%s -- In Definitions", tostring(Script))

        StoryModeEvents = { Universal_Story_Start = Begin_GC }

        --ServiceRate = 2


end



function Begin_GC(message)
        if message == OnEnter then

                zoomed_in = false


                empire = Find_Player("Empire")


                -- put all planets as strings in this table
                planet_list = {"Abregado_Rae_E1", "Alderaan_E1", "Anaxes_E1", "Atzerri_E1", "Bestine_E1", "Bonadan_E1", "Bothawui_E1", "Brentaal_E1", "Carida_E1", "Corellia_E1", "Corulag_E1", "Coruscant_E1", "Dantooine_E1", "Dxun_E1", "Felucia_E1", "Fondor_E1", "Fresia_E1", "Hapes_E1", "Honoghr_E1", "Hypori_E1", "Kashyyyk_E1", "Kessel_E1", "Korriban_E1", "Kuat_E1", "Manaan_E1", "Mandalore_E1", "Mechis3_E1", "MonCalimari_E1", "Naboo_E1", "NalHutta_E1", "Onderon_E1", "Rakata_Prime_E1", "Ryloth_E1", "Saleucami_E1", "Sullust_E1", "Taris_E1", "Tatooine_E1"}

                -- put all special structures as strings in this table
                special_structures = {"S_BERTH", "S_GOLAN", "DS_SENSOR_RELAY", "DS_TRADE_PORT", "DS_HYDROPONICS", "DS_GALACTIC_CARGO", "DS_GALACTIC_HYPERLANES", "DS_ORBITAL_MANUFACTURING", "DS_GALACTIC_ASTEROID_MINE", "DS_GALACTIC_GAS_EXTRACTOR", "DS_GALACTIC_ORBITAL_DEFENCE_POD", "S_HANGAR"}

                -- put the text entries of the special structures as strings in this table
                -- IMPORTANT: the order of the entries has to be the same as in the special_structures table!!!
                text_table = {"TEXT_ORBITAL_GOLAN", "TEXT_ORBITAL_BERTH", "TEXT_ORBITAL_SENSOR_RELAY", "TEXT_ORBITAL_TRADE_PORT", "TEXT_ORBITAL_HYDROPONICS", "TEXT_ORBITAL_CARGO_STORAGE", "TEXT_ORBITAL_HYPERSPACE_LANES", "TEXT_ORBITAL_MANUFACTURING", "TEXT_ORBITAL_ASTEROID_MINES", "TEXT_ORBITAL_GAS_EXTRACTORS", "TEXT_ORBITAL_DEFENCE_PODS", "TEXT_ORBITAL_HANGAR"}


                -- put the name of your story file in here. IMPORTANT: the command is case sensitive!
                plot = Get_Story_Plot("DS_E1_2.XML")


                show_text = plot.Get_Event("SCREEN_TEXT_Special_Structure")

                --remove_text = plot.Get_Event("REMOVE_ALL_TEXT")

                selected_planet = "none"







        elseif message == OnUpdate then

                                -- concatenate strings by using string1..string2
                for i, planetstring in pairs(planet_list) do
                        if Check_Story_Flag(empire, "ZOOMED_INTO_"..planetstring, nil, true) then

                                for j, structure in pairs(special_structures) do
                                        temp_structure_list = Find_All_Objects_Of_Type(structure)
                                        for k, obj in pairs(temp_structure_list) do
                                                if obj.Get_Planet_Location() == FindPlanet(planetstring) then
                                                        show_text.Set_Reward_Parameter(0, text_table[j])
                                                        Story_Event("SHOW_STRUCTURES")
                                                        Story_Event("RESET_TEXT_BRANCH")
                                                end
                                        end

                                end
                                zoomed_in = true
                        end
                        if Check_Story_Flag(empire, "SELECT_"..planetstring, nil, true) then
                                selected_planet = planetstring
                        end
                end

                if Check_Story_Flag(empire, "ZOOMED_OUT", nil, true) then
                        Remove_All_Text()

                zoomed_in = false
                end
                        --Game_Message("TEXT_UNIT_VENGEANCE_FRIGATE")

                if Check_Story_Flag(empire, "DemolishSensorStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_SENSOR_RELAY")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishBerthStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("S_BERTH")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishGolanStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("S_GOLAN")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishTradeStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_TRADE_PORT")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishHydroponicsStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_HYDROPONICS")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishCargoStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_GALACTIC_CARGO")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishManufacturingStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_ORBITAL_MANUFACTURING")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishAsteroidStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_GALACTIC_ASTEROID_MINE")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishGasStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_GALACTIC_GAS_EXTRACTOR")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishPodStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("DS_GALACTIC_ORBITAL_DEFENCE_POD")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

                if Check_Story_Flag(empire, "DemolishHangarStructure", nil, true) then
                        type_list = Find_All_Objects_Of_Type("S_HANGAR")
                                for i, obj in pairs(type_list) do
                                        if obj.Get_Planet_Location() == FindPlanet(selected_planet) then
                                        obj.Despawn()
                                        end
                                end
                end

        end
end



