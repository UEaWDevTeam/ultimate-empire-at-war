--//////////////////////////////////////////////////////////////////////////////////////
--      UU    UU    EEEEEEEE     AAAA     WW   WW   WW
--      UU    UU    EE         AA    AA   WW   WW   WW
--      UU    UU    EEEEE      AAAAAAAA   WW   WW   WW
--      UU    UU    EE         AA    AA    WW WWWW WW
--       UUUUUU     EEEEEEEE   AA    AA      WW  WW
-- Simulates the multi-shield system of a SSD
-- © UEAW Team
--//////////////////////////////////////////////////////////////////////////////////////
require("PGDebug")
require("PGStateMachine")
require("PGStoryMode")

function Definitions ()
        DebugMessage("%s -- In Definitions", tostring(Script))
        Define_State("State_Init", State_Init); 
        ServiceRate = 0.2

end

function State_Init(message) 
		empire = Find_Player("Empire")
        if message == OnEnter then             
        	if Get_Game_Mode() ~= "Space" then 
                ScriptExit()
        	end 
        	--initalize vars
        	shield_strength = 5000.0
        	shield_regeneration = 0.8
        	max_distance=50
        	shield_regeneration_timer = 0
			shield_output_timer = 20.0
        	reached_zero = false
        	shield_strength_original = shield_strength 
        	
		elseif message == OnUpdate then
				
				--check for projectiles/weaken shield
				enemy = FindDeadlyEnemy(Object)
				if TestValid(enemy) then
					projectile_types = enemy.Get_All_Projectile_Types()
					if projectile_types then
						for _, projectile in pairs(projectile_types) do
							projectiles = Find_All_Objects_Of_Type(projectile)
							for _, iprojectile in pairs(projectiles) do
								if iprojectile.Get_Distance(Object.Get_Bone_Position("HP_SHIELD_00")) <= max_distance or iprojectile.Get_Distance(Object.Get_Bone_Position("HP_SHIELD_01")) <= max_distance  then
									    if Object.Get_Shield() > 0 then
											damage = GetProjectileDamage(iprojectile)
											if shield_strength > 0 then
												shield_strength = shield_strength - damage
											else
												Object.Take_Damage(damage, "HP_SSD_E3_SHIELD_01")
												Object.Take_Damage(damage, "HP_SSD_E3_SHIELD_02")
											end
										else
											
										end
								end
							end
						end
					end
				end
				
				if Object.Get_Shield() <= 0 then
					shield_strength = 0
				else
					--regenerate shields
					if shield_strength <= 0 and shield_regeneration_timer == 0 and reached_zero == false then
				    	reached_zero = true
				    	shield_regeneration_timer = 5.0
					end
					if shield_strength > 0 and shield_strength <= shield_strength_original then
						shield_strength = shield_strength + shield_regeneration
					end
					if shield_strength > shield_strength_original then
						shield_strength = shield_strength_original
					end
					if  shield_strength == 0 and shield_regeneration_timer == 0 and reached_zero == true then
						shield_strength = 100
						reached_zero = false
					end
					
					--output shield strength after some time
					if shield_output_timer <= 0 then
						if (shield_strength/shield_strength_original) > 0.9 and (shield_strength/shield_strength_original) <= 1.0 then
							Game_Message("TEXT_PERCENTAGE_100_DS")
						end
						if (shield_strength/shield_strength_original) > 0.8 and (shield_strength/shield_strength_original) <= 0.9 then
							Game_Message("TEXT_PERCENTAGE_90_DS")
						end
						if (shield_strength/shield_strength_original) > 0.7 and (shield_strength/shield_strength_original) <= 0.8 then
							Game_Message("TEXT_PERCENTAGE_80_DS")
						end
						if (shield_strength/shield_strength_original) > 0.6 and (shield_strength/shield_strength_original) <= 0.7 then
							Game_Message("TEXT_PERCENTAGE_70_DS")
						end
						if (shield_strength/shield_strength_original) > 0.5 and (shield_strength/shield_strength_original) <= 0.6 then
							Game_Message("TEXT_PERCENTAGE_60_DS")
						end
						if (shield_strength/shield_strength_original) > 0.4 and (shield_strength/shield_strength_original) <= 0.5 then
							Game_Message("TEXT_PERCENTAGE_50_DS")
						end
						if (shield_strength/shield_strength_original) > 0.3 and (shield_strength/shield_strength_original) <= 0.4 then
							Game_Message("TEXT_PERCENTAGE_40_DS")
						end
						if (shield_strength/shield_strength_original) > 0.2 and (shield_strength/shield_strength_original) <= 0.3 then
							Game_Message("TEXT_PERCENTAGE_30_DS")
						end
						if (shield_strength/shield_strength_original) > 0.1 and (shield_strength/shield_strength_original) <= 0.2 then
							Game_Message("TEXT_PERCENTAGE_20_DS")
						end
						if (shield_strength/shield_strength_original) > 0 and (shield_strength/shield_strength_original) <= 0.1 then
							Game_Message("TEXT_PERCENTAGE_10_DS")
						end
						if shield_strength <= 0 then
							Game_Message("TEXT_PERCENTAGE_0_DS")
						end
						shield_output_timer = 10.0
					else
						shield_output_timer = shield_output_timer - 0.2
					end
					
				end
		end
	
end

function GetProjectileDamage(projectile)
	if projectile.Get_Name() == "Proj_Laser_E1_Blue_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Blue_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Blue_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Blue_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Blue_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Blue_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Blue_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Blue_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Green_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Green_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Green_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Green_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Green_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Green_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Green_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Green_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Red_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Red_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Red_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Red_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Red_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Red_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Red_Standard" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Red_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Harmonic_Bomb_Slave_I" then
		return 300
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E1_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E1_Medium" then
		return 50
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E1_Heavy" then
		return 60
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E2_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E2_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E2_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E3_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E3_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E3_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E4_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E4_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_Basic_E4_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E1_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E1_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E1_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E2_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E2_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E2_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E3_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E3_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E3_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E4_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E4_Medium" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Conc_Missile_AP_E4_Heavy" then
		return 12
	end
	if projectile.Get_Name() == "Proj_SO_Proton_Torp_E1" then
		return 24
	end
	if projectile.Get_Name() == "Proj_SO_Heavy_Proton_Torp_E1" then
		return 48
	end
	if projectile.Get_Name() == "Proj_SO_Proton_Torp_E2" then
		return 24
	end
	if projectile.Get_Name() == "Proj_SO_Heavy_Proton_Torp_E2" then
		return 48
	end
	if projectile.Get_Name() == "Proj_SO_Proton_Torp_E3" then
		return 24
	end
	if projectile.Get_Name() == "Proj_SO_Heavy_Proton_Torp_E3" then
		return 48
	end
	if projectile.Get_Name() == "Proj_SO_Proton_Torp_E4" then
		return 24
	end
	if projectile.Get_Name() == "Proj_SO_Heavy_Proton_Torp_E4" then
		return 48
	end
	if projectile.Get_Name() == "Proj_AP_Proton_Torp_E1" then
		return 68
	end
	if projectile.Get_Name() == "Proj_AP_Heavy_Proton_Torp_E1" then
		return 120
	end
	if projectile.Get_Name() == "Proj_AP_Proton_Torp_E2" then
		return 68
	end
	if projectile.Get_Name() == "Proj_AP_Heavy_Proton_Torp_E2" then
		return 120
	end
	if projectile.Get_Name() == "Proj_AP_Proton_Torp_E3" then
		return 68
	end
	if projectile.Get_Name() == "Proj_AP_Heavy_Proton_Torp_E3" then
		return 120
	end
	if projectile.Get_Name() == "Proj_AP_Proton_Torp_E4" then
		return 68
	end
	if projectile.Get_Name() == "Proj_AP_Heavy_Proton_Torp_E4" then
		return 120
	end
	if projectile.Get_Name() == "Proj_Plasma_Torpedo_E4" then
		return 60
	end
	if projectile.Get_Name() == "Proj_Diamond_Boron_Missile" then
		return 100
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E1_Starfighter" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E1_Light" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E1_Medium" then
		return 32
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E1_Heavy" then
		return 52
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E2_Light" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E2_Medium" then
		return 32
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E2_Heavy" then
		return 52
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Light" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Medium" then
		return 32
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Heavy" then
		return 52
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Light" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Medium" then
		return 32
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Heavy" then
		return 52
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Medium_Advanced" then
		return 43
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Medium_Advanced" then
		return 43
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Heavy_Advanced" then
		return 68
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Heavy_Advanced" then
		return 68
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Light_Advanced" then
		return 26
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Light_Advanced" then
		return 26
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E3_Heavy_Superior" then
		return 60
	end
	if projectile.Get_Name() == "Proj_Ion_Cannon_E4_Heavy_Superior" then
		return 60
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Orange_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Orange_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Orange_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Orange_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Orange_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Orange_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Orange_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Orange_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Orange_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Orange_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Orange_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Orange_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Red_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Red_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Red_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Red_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Red_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Red_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Green_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Green_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Green_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Green_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Green_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Green_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Blue_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Blue_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E1_Blue_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Blue_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Blue_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E2_Blue_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Blue_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Blue_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Blue_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Blue_Light" then
		return 4
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Blue_Medium" then
		return 6
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Blue_Heavy" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Red_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Red_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Red_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Red_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Red_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Red_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Red_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Red_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Green_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Green_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Green_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Green_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Green_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Green_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Green_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Green_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Blue_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E1_Blue_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Blue_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E2_Blue_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Blue_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E3_Blue_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Blue_Capital" then
		return 0.75
	end
	if projectile.Get_Name() == "Proj_Laser_E4_Blue_Capital_Heavy" then
		return 1.25
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Light_Advanced" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Medium_Advanced" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Heavy_Advanced" then
		return 17
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Light_Advanced" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Medium_Advanced" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Heavy_Advanced" then
		return 17
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Medium_Superior" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Heavy_Superior" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Green_Heavy_Quad" then
		return 53
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Medium_Superior" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Heavy_Superior" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Green_Heavy_Quad" then
		return 53
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Light_Advanced" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Medium_Advanced" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Heavy_Advanced" then
		return 17
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Light_Advanced" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Medium_Advanced" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Heavy_Advanced" then
		return 17
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Medium_Superior" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E3_Red_Heavy_Superior" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Medium_Superior" then
		return 12
	end
	if projectile.Get_Name() == "Proj_Turbolaser_E4_Red_Heavy_Superior" then
		return 20
	end
	if projectile.Get_Name() == "Proj_Flak_AS_E1" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Flak_AS_E2" then
		return 8
	end
	if projectile.Get_Name() == "Proj_Flak_AS_E3" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Flak_AS_E4" then
		return 10
	end
	if projectile.Get_Name() == "Proj_Cluster_Bomb" then
		return 75
	end
	
end