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
                "S_HEAVY_CRUISER"
                ,"S_HEAVY_CRUISER"
                ,"S_HEAVY_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_INTERDICTOR_CRUISER"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_GUNBOAT_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"
                ,"S_SITH_BOMBER_SQUADRON"

        }


        fleet_delay = 30
        DS_player = nil
end

function State_LS_E1_Begin(message)
        if message == OnEnter then
                --MessageBox("Beginning script E1O1")

                -- Find the players
                LS_player = Find_Player("Light_Side")
                DS_player = Find_Player("Dark_Side")

                -- Find the planets
                coruscant = Find_First_Object("Coruscant")
                byss = Find_First_Object("Byss")
                corellia = Find_First_Object("Corellia")
                bestine = Find_First_Object("Bestine")
                mechis3 = Find_First_Object("Mechis3")

                -- Create a fleet to attack Corellia
                sith_fleet_units_01 = SpawnList(sith_list_0,mechis3,DS_player,false,false)

                -- Start a new thread so other events won't be blocked
                Create_Thread("Move_Fleet01")

                fleet_created = false

        elseif message == OnUpdate then

                -- Constant check to see if fleet has been destroyed
                if fleet_created and not TestValid(sith_fleet_units_01) then
                        Story_Event("fleet01_destroyed")
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
        Move_Fleet_To_Planet(bestine)
        Move_Fleet_To_Planet(corellia)
        Move_Fleet_To_Planet(coruscant)
        Move_Fleet_To_Planet(byss)
        -- Don't use the move_fleet function since it sleeps after arriving.  We need to inform
        -- the story script as soon as it arrives
        BlockOnCommand(sith_fleet01.Move_To(moncal))
        if TestValid(sith_fleet01) then
                Story_Event("sith_fleet01_arrived")
        end
end



function Move_Fleet_To_Planet(next_planet)
        if TestValid(sith_fleet01) then
                --MessageBox("Moving super fleet to next planet")
                BlockOnCommand(sith_fleet01.Move_To(next_planet))
                Sleep(fleet_delay)
        end
end

