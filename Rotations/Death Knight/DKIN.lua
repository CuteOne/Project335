local rotationName = "InvalidNam3"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.obliterate },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.howlingBlast },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.frostStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.regrowth }
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.empowerRuneWeapon },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.empowerRuneWeapon },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.empowerRuneWeapon }
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.iceboundFortitude },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.iceboundFortitude }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.mindFreeze }
    };
    CreateButton("Interrupt",4,0)

end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, "General")
        -- APL
            br.ui:createDropdownWithout(section, "APL Mode", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFFSet APL Mode to use.")
        -- Path of Frost
            br.ui:createCheckbox(section,"Path of Frost")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Opener
            br.ui:createCheckbox(section, "Opener")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")

        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        -- Potion
            br.ui:createCheckbox(section,"Potion")
        -- Elixir
            br.ui:createDropdownWithout(section,"Elixir", {"Flask of Endless Rage", "None"}, 1, "|cffFFFFFFSet Elixir to use.")
        -- Racial
            br.ui:createCheckbox(section,"Racial")
        -- Unbreakable Armor
            br.ui:createCheckbox(section,"Unbreakable Armor")
        -- Empower Rune Weapon
            br.ui:createCheckbox(section,"Empower Rune Weapon")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Icebound Fortitude
            br.ui:createSpinner(section, "Icebound Fortitude",  40,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Anti-Magic Shell
            br.ui:createSpinner(section, "Anti-Magic Shell",  40,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")

        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Skull Bash
            br.ui:createCheckbox(section,"Mind Freeze")
        -- Mighty Bash
            br.ui:createCheckbox(section,"Strangulate")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupt at",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
        -- Cleave Toggle
            br.ui:createDropdown(section, "Cleave Mode", br.dropOptions.Toggle,  6)
        -- Prowl Toggle
            br.ui:createDropdown(section, "Prowl Mode", br.dropOptions.Toggle,  6)
        -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

----------------
--- ROTATION ---
----------------
local function runRotation()
    -- if br.timer:useTimer("debugFeral", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Cleave",0.25)
        br.player.mode.cleave = br.data.settings[br.selectedSpec].toggles["Cleave"]
        UpdateToggle("Prowl",0.25)
        br.player.mode.prowl = br.data.settings[br.selectedSpec].toggles["Prowl"]

--------------
--- Locals ---
--------------


        local brunes                                        = br.player.power.runes.amount('blood')
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
	    	local castable          							              = br.player.cast.debug
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.power.comboPoints.amount()
        local comboDeficit                                  = br.player.power.comboPoints.deficit()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local drunes                                        = br.player.power.runes.amount('death')
        local enemies                                       = enemies or {}
        local equiped                                       = br.player.equiped
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local frunes                                        = br.player.power.runes.amount('frost')
        local gcd                                           = br.player.gcd
        local gcdMax                                        = br.player.gcdMax
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local item                                          = br.player.spell.items
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation == 2) and br.player.mode.rotation ~= 3
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powmax, powgen, powerDeficit           = br.player.power.energy.amount(), br.player.power.energy.max(), br.player.power.energy.regen(), br.player.power.energy.deficit()
        local pullTimer                                     = PullTimerRemain() --br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local solo                                          = #br.friend < 2
        local friendsInRange                                = friendsInRange
        local spell                                         = br.player.spell
        local stealth                                       = br.player.buff.shadowmeld.exists()
        local talent                                        = br.player.talent
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.energy.ttm()
        local units                                         = units or {}
        local uhrunes                                       = br.player.power.runes.amount('unholy')
        local use                                           = br.player.use

        -- Get Best Unit for Range
        units.dyn40         = br.player.units(40)
        units.dyn20         = br.player.units(20)
        units.dyn8AoE       = br.player.units(8,true)
        units.dyn8          = br.player.units(8)
        units.dyn5          = br.player.units(5)

        -- Get List of Enemies for Range
        enemies.yards40     = br.player.enemies(40)
        enemies.yards20     = br.player.enemies(20)
        enemies.yards20nc   = br.player.enemies(20,"player",true)
        enemies.yards13     = br.player.enemies(13)
        enemies.yards8      = br.player.enemies(8)
        enemies.yards5      = br.player.enemies(5)

   		  if leftCombat == nil then leftCombat = GetTime() end
		    if profileStop == nil then profileStop = false end
		    if lastSpellCast == nil then lastSpellCast = spell.catForm end
        if opener == nil then opener = false end
        if lastForm == nil then lastForm = 0 end
		    if not inCombat and not hastar and profileStop==true then
            profileStop = false
		    end

        if br.player.potion.agility ~= nil then
            if br.player.potion.agility[1] ~= nil then
                agiPot = br.player.potion.agility[1].itemID
            else
                agiPot = 0
            end
        else
            agiPot = 0
        end

        friendsInRange = 0
        if not solo then
            for i = 1, #br.friend do
                if getDistance(br.friend[i].unit) < 15 then
                    friendsInRange = friendsInRange + 1
                end
            end
        end

        if power > 50 then
            fbMaxEnergy = true
        else
            fbMaxEnergy = false
        end
        -- Opener Reset
        if not inCombat and not GetObjectExists("target") then
			openerCount = 0
            OPN1 = false
            RK1 = false
            MF1 = false
            SR1 = false
            BER1 = false
            TF1 = false
            AF1 = false
            REG1 = false
            MF1 = false
            RIP1 = false
            THR1 = false
            SHR1 = false
            REG2 = false
            RIP2 = false
            opener = false
        end


--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
    -- Path of Frost
      if isChecked("Path of Frost") then
        if not inCombat and swimming and not buff.pathOfFrost.exists() then
            if cast.pathOfFrost() then return end
        end
      end
		-- Dummy Test
			if isChecked("DPS Testing") then
				if GetObjectExists("target") then
					if getCombatTime() >= (tonumber(getOptionValue("DPS Testing"))*60) and isDummy() then
						StopAttack()
						ClearTarget()
						Print(tonumber(getOptionValue("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
						profileStop = true
					end
				end
			end -- End Dummy Test
		end -- End Action List - Extras
	-- Action List - Defensive
		local function actionList_Defensive()
			if useDefensive() and not IsMounted() and not stealth and not flight  then
                -- Horn of Winter
                if cast.able.hornOfWinter() and not buff.hornOfWinter.exists() then
                    if cast.hornOfWinter() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                return
		 	end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_SimC_Cooldowns()
      if getDistance("target") < 5 then
              return
          end -- End useCooldowns check
      end -- End Action List - Cooldowns
    -- Action List - Opener
        function actionList_Opener()
        -- -- Wild Charge
        --     if isChecked("Wild Charge") and isValidUnit("target") and getDistance("target") >= 8 and getDistance("target") < 30 then
        --         if cast.wildCharge("target") then return end
        --     end
		-- Start Attack
            -- auto_attack
            if isChecked("Opener") and isBoss("target") and opener == false then
                if isValidUnit("target") and getDistance("target") < 5 then
                    opener = true
                end
			elseif (UnitExists("target") and not isBoss("target")) or not isChecked("Opener") then
				opener = true
			end
        end -- End Action List - Opener
    -- Action List - Finisher
        local function actionList_SimC_Finisher()
            return
        end
    -- Action List - Generator
        local function actionList_SimC_Generator()
            return
        end
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying()~=nil or IsMounted()~=nil) then

                -- Opener
                if actionList_Opener() then return end
            end
        end -- End Action List - PreCombat
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or mode.rotation==4 then
            return true
        else
-----------------------
--- Extras Rotation ---
-----------------------
            if actionList_Extras() then return end
--------------------------
--- Defensive Rotation ---
--------------------------
            if actionList_Defensive() then return end
------------------------------
--- Out of Combat Rotation ---
------------------------------
            if actionList_PreCombat() then return end
			-- if actionList_Opener() then return end
--------------------------
--- In Combat Rotation ---
--------------------------

            if inCombat and profileStop==false  and isValidUnit(units.dyn5) then

                if getDistance("target") < 40 then
                    -- auto_attack
                    -- StartAttack()
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                    -- if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                    if getOptionValue("APL Mode") == 1 then

                      -- action_list_str += "/obliterate";
                      if cast.able.obliterate() then
                        if cast.obliterate() then return end
                      end
                      -- Frost strike with KM proc.
                      if cast.able.frostStrike() and buff.killingMachine.exists() then
                        if cast.frostStrike() then return end
                      end
                      -- action_list_str += "/icy_touch,if=dot.frost_fever.remains<=0.1";
                      if cast.able.icyTouch() and debuff.frostFever.remain() <= 0.1 then
                        if cast.icyTouch() then return end
                      end
                      -- action_list_str += "/plague_strike,if=dot.blood_plague.remains<=0.1";
                      if cast.able.plagueStrike() and debuff.bloodPlague.remain() <= 0.1  then
                        if cast.plagueStrike() then return end
                      end
                      -- action_list_str += "/howling_blast,if=buff.rime.react&buff.killing_machine.react";
                      if cast.able.howlingBlast() and buff.freezingFog.exists() and buff.killingMachine.exists() then
                        if cast.howlingBlast() then return end
                      end
                      -- action_list_str += "/howling_blast,if=buff.rime.react";
                      if cast.able.howlingBlast() and buff.freezingFog.exists() then
                        if cast.howlingBlast() then return end
                      end
                      -- action_list_str += "/blood_strike,if=blood=2&death<=2";
                      if cast.able.bloodStrike() and brunes == 2 and drunes <= 2 then
                        if cast.bloodStrike() then return end
                      end
                      -- action_list_str += "/blood_strike,if=blood=1&death<=1";
                      if cast.able.bloodStrike() and brunes == 1 and drunes <= 1 then
                        if cast.bloodStrike() then return end
                      end
                      -- action_list_str += "/empower_rune_weapon,if=blood=0&unholy=0&death=0";
                      if isChecked("Empower Rune Weapon") and cast.able.empowerRuneWeapon() and brunes == 0 and uhrunes == 0 and drunes == 0 then
                        if cast.empowerRuneWeapon() then return end
                      end
                      -- action_list_str += "/blood_tap,time>=10,if=blood=0&frost=0&unholy=0&inactive_death=0";
                     -- if cast.able.bloodTap() and brunes == 0 and uhrunes = 0 and 
                      -- action_list_str += "/unbreakable_armor,if=cooldown.blood_tap.remains>=58"; //Forces Unbreakable Armor to only be used in combination with Blood Tap
                      if isChecked("Unbreakable Armor") and cast.able.unbreakableArmor() and cd.bloodTap.remain() >= 58 then 
                        if cast.unbreakableArmor() then return end
                      end
                      -- action_list_str += "/pestilence,if=dot.blood_plague.remains<=5|dot.frost_fever.remains<=5";
                      if cast.able.pestilence() and debuff.bloodPlague.remain() <= 5 and debuff.frostFever.remain() <= 5 and  debuff.bloodPlague.remain() > gcdMax then
                        if cast.pestilence() then return end
                      end

                    end -- End SimC APL
			    end -- End No Stealth | Rotation Off Check
			end --End In Combat
		end --End Rotation Logic
    -- end -- End Timer
end -- End runRotation
local id = 'DEATHKNIGHT'
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
