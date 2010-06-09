-- UEAW LUA file

--Do not redistribute without permission

--Controls non-independent droid starfighter behaviour

require ("PGStateMachine")

function Definitions ()

        Define_State("State_Init", State_Init)

        ServiceRate = 1 --set repeat rate of the check

end

function State_Init(message) --initialise

        if Get_Game_Mode() ~= "Space" then --end script if in any mode but space
                ScriptExit()
        end

        if message == OnEnter then --unit has entered the game

                returning_to_carrier = false --not returning yet

        elseif message == OnUpdate then --if the unit is doing something

                carrier_list = Find_All_Objects_Of_Type("C_PROVIDENCE", "C_RECUSANT", "C_RECUSANT_CARRIER", "C_LUCREHULK", "C_LUCREHULK_BATTLESHIP") --find all carrier units

                Return_to_Carrier(carrier_list)

        end

end

function Return_to_Carrier(carrierloc_list)

         Object.Get_Owner().Give_Money(1)
         Carrier_exists = false
         Carrier_in_Range = false

         if table.getn(carrierloc_list) ~= 0 then
         Object.Get_Owner().Give_Money(100)
                 for i=0, unit(carrierloc_list) do

                         carrierdist = Object.Get_Distance(carrierloc_list(i))


                         if carrierdist < 2000 then
                         Carrier_in_Range = true
                         Carrier_Name = carrierloc_list(i)
                         end
                 end

        else
                 Sleep (5)
                 Object.Take_Damage(500)

        end

        if Carrier_in_Range

        else
                 Object.Move_To(Carrier_Name) --move the fighter to it
                 Object.Lock_Current_Orders() --lock the move order until complete

        end


end






