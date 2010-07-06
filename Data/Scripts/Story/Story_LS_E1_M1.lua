-- UEAW CAMPAIGN LUA file

--Do not redistribute without permission

--Controls first objective in the campaign (attack of Sith)

require("PGStoryMode")
require("PGSpawnUnits")


--
-- Definitions -- This function is called once when the script is first created.
--
function Definitions()

         DebugMessage("%s -- In Definitions", tostring(Script))

         StoryModeEvents =
        {
                LS_E1_Begin = State_LS_E1_Begin
        }

        sith_list_0 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }
		
        sith_list_1 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }
        sith_list_2 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }
        sith_list_3 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }
        sith_list_4 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }
        sith_list_5 = {
                "S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }



        fleet_delay = 1
        DS_player = nil
end

function State_LS_E1_Begin(message)
        if message == OnEnter then
                --MessageBox("Beginning script E1O1")

                -- Find the players
                LS_player = Find_Player("Light_Side")
                DS_player = Find_Player("Dark_Side")

                -- Find the planets
                eriadu = Find_First_Object("Eriadu")
                utapau = Find_First_Object("Utapau")
                bothawui = Find_First_Object("Bothawui")
                tatooine = Find_First_Object("Tatooine")
                polus = Find_First_Object("Polus")
                carida = Find_First_Object("Carida")
                onderon = Find_First_Object("Onderon")
                kashyyyk = Find_First_Object("Kashyyyk")
                sullust = Find_First_Object("Sullust")
                naboo = Find_First_Object("Naboo")
                ord_mantell = Find_First_Object("Ord_Mantell")
                trandosha = Find_First_Object("Trandosha")

                -- Create a fleet to attack Sullust
                sith_fleet_units_01 = SpawnList(sith_list_0,eriadu,DS_player,false,false)

                --Create a fleet to attack Naboo
                sith_fleet_units_02 = SpawnList(sith_list_1,utapau,DS_player,false,false)

                --Create a fleet to attack Bothawui
                sith_fleet_units_03 = SpawnList(sith_list_2,tatooine,DS_player,false,false)

                --Create a fleet to attack Ord Mantell
                sith_fleet_units_04 = SpawnList(sith_list_3,polus,DS_player,false,false)

                --Create a fleet to attack Carida
                sith_fleet_units_05 = SpawnList(sith_list_4,onderon,DS_player,false,false)

                --Create a fleet to attack Trandosha
                sith_fleet_units_06 = SpawnList(sith_list_5,kashyyyk,DS_player,false,false)

                -- Start a new thread so other events won't be blocked
                Create_Thread("Move_Fleet01")
								
				Create_Thread("Move_Fleet02")
				Create_Thread("Move_Fleet03")
				Create_Thread("Move_Fleet04")
				Create_Thread("Move_Fleet05")
				Create_Thread("Move_Fleet06")
				



                fleet_created = false

        elseif message == OnUpdate then

                -- Constant check to see if fleet has been destroyed
                if fleet_created and not TestValid(sith_fleet_units_01) then
                        Story_Event("fleet01_destroyed")
                end
				if fleet_created and not TestValid(sith_fleet_units_02) then
                        Story_Event("fleet02_destroyed")
                end
                if fleet_created and not TestValid(sith_fleet_units_03) then
                        Story_Event("fleet03_destroyed")
                end
                if fleet_created and not TestValid(sith_fleet_units_04) then
                        Story_Event("fleet04_destroyed")
                end
                if fleet_created and not TestValid(sith_fleet_units_05) then
                        Story_Event("fleet05_destroyed")
                end
                if fleet_created and not TestValid(sith_fleet_units_06) then
                        Story_Event("fleet06_destroyed")
                end


        end
end

function Move_Fleet01()
        sith_fleet01 = Assemble_Fleet(sith_fleet_units_01)
        if TestValid(sith_fleet_units_01) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet01_Moves")
        Move_Fleet_To_Planet(sullust)
        BlockOnCommand(sith_fleet01.Move_To(sullust))
        if TestValid(sith_fleet01) then
                Story_Event("sith_fleet01_arrived")
        end
end

function Move_Fleet02()
        sith_fleet02 = Assemble_Fleet(sith_fleet_units_02)
        if TestValid(sith_fleet_units_02) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet02_Moves")
        Move_Fleet_To_Planet(naboo)
        BlockOnCommand(sith_fleet02.Move_To(naboo))
        if TestValid(sith_fleet02) then
                Story_Event("sith_fleet02_arrived")
        end
end

function Move_Fleet03()
        sith_fleet03 = Assemble_Fleet(sith_fleet_units_03)
        if TestValid(sith_fleet_units_03) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet03_Moves")
        Move_Fleet_To_Planet(bothawui)
        BlockOnCommand(sith_fleet03.Move_To(bothawui))
        if TestValid(sith_fleet03) then
                Story_Event("sith_fleet03_arrived")
        end
end

function Move_Fleet04()
        sith_fleet04 = Assemble_Fleet(sith_fleet_units_04)
        if TestValid(sith_fleet_units_04) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet04_Moves")
        Move_Fleet_To_Planet(ord_mantell)
        BlockOnCommand(sith_fleet04.Move_To(ord_mantell))
        if TestValid(sith_fleet04) then
                Story_Event("sith_fleet04_arrived")
        end
end

function Move_Fleet05()
        sith_fleet05 = Assemble_Fleet(sith_fleet_units_05)
        if TestValid(sith_fleet_units_05) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet05_Moves")
        Move_Fleet_To_Planet(carida)
        BlockOnCommand(sith_fleet05.Move_To(carida))
        if TestValid(sith_fleet05) then
                Story_Event("sith_fleet05_arrived")
        end
end

function Move_Fleet06()
        sith_fleet06 = Assemble_Fleet(sith_fleet_units_06)
        if TestValid(sith_fleet_units_06) then
                fleet_created = true
        end

        -- Wait a little while and let the player find out about fleet through story dialog
        Sleep(fleet_delay)

        Story_Event("Fleet06_Moves")
        Move_Fleet_To_Planet(trandosha)
        BlockOnCommand(sith_fleet06.Move_To(trandosha))
        if TestValid(sith_fleet06) then
                Story_Event("sith_fleet06_arrived")
        end
end





function Move_Fleet_To_Planet(next_planet)
        if TestValid(sith_fleet01) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet01.Move_To(next_planet))
                Sleep(fleet_delay)
        end
        if TestValid(sith_fleet02) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet02.Move_To(next_planet))
                Sleep(fleet_delay)
        end
        if TestValid(sith_fleet03) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet03.Move_To(next_planet))
                Sleep(fleet_delay)
        end
        if TestValid(sith_fleet04) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet04.Move_To(next_planet))
                Sleep(fleet_delay)
        end
        if TestValid(sith_fleet05) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet05.Move_To(next_planet))
                Sleep(fleet_delay)
        end
        if TestValid(sith_fleet06) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet06.Move_To(next_planet))
                Sleep(fleet_delay)
        end

end
