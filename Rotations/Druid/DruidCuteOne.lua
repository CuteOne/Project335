local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.swipeCat },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.swipeCat },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shred },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.regrowth}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.berserk },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.berserk },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.berserk }
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.survivalInstincts },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.survivalInstincts }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.maim },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.maim }
    };
    CreateButton("Interrupt",4,0)
-- Cleave Button
	CleaveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.", highlight = 1, icon = br.player.spell.swipeCat },
        [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets", highlight = 0, icon = br.player.spell.swipeCat }
    };
    CreateButton("Cleave",5,0)
-- Prowl Button
	ProwlModes = {
        [1] = { mode = "On", value = 1 , overlay = "Prowl Enabled", tip = "Rotation will use Prowl", highlight = 1, icon = br.player.spell.prowl },
        [2] = { mode = "Off", value = 2 , overlay = "Prowl Disabled", tip = "Rotation will not use Prowl", highlight = 0, icon = br.player.spell.prowl }
    };
    CreateButton("Prowl",6,0)
-- Form Button
    FormModes = {
        [1] = { mode = "Cat", value = 1 , overlay = "Cat Form", tip = "Rotation will use Cat Form", highlight = 1, icon = br.player.spell.catForm },
        [2] = { mode = "Bear", value = 2 , overlay = "Bear Form", tip = "Rotation will use Bear Form", highlight = 0, icon = br.player.spell.bearForm },
        [3] = { mode = "Caster", value = 3 , overlay = "Caster Form", tip = "Rotation will use Caster Form", highlight = 0, icon = br.player.spell.moonfire },
    };
    CreateButton("Form",7,0)
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
        -- Death Cat
            br.ui:createCheckbox(section,"Death Cat Mode","|cff15FF00Enable|cffFFFFFF/|cffD60000Disable |cffFFFFFFthis mode when running through low level content where you 1 hit kill mobs.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
        -- Opener
            br.ui:createCheckbox(section, "Opener")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
        -- Travel Shapeshifts
            br.ui:createCheckbox(section,"Auto Shapeshifts","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to best form for situation.|cffFFBB00.")
        -- Fall Timer
            br.ui:createSpinnerWithout(section,"Fall Timer", 2, 1, 5, 0.25, "|cffFFFFFFSet to desired time to wait until shifting to flight form when falling (in secs).")
        -- Break Crowd Control
            br.ui:createCheckbox(section,"Break Crowd Control","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFAuto Shapeshifting to break crowd control.|cffFFBB00.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
        -- Potion
            br.ui:createCheckbox(section,"Potion")
        -- Elixir
            br.ui:createDropdownWithout(section,"Elixir", {"Flask of Seventh Demon","Repurposed Fel Focuser","Oralius' Whispering Crystal","None"}, 1, "|cffFFFFFFSet Elixir to use.")
        -- Racial
            br.ui:createCheckbox(section,"Racial")
        -- Tiger's Fury
            br.ui:createCheckbox(section,"Tiger's Fury")
        -- Berserk
            br.ui:createCheckbox(section,"Berserk")
        -- Trinkets
            br.ui:createDropdownWithout(section,"Trinkets", {"|cff00FF00Everything","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Trinkets.")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
        -- Rebirth
            br.ui:createCheckbox(section,"Rebirth")
            br.ui:createDropdownWithout(section, "Rebirth - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
        -- Revive
            br.ui:createCheckbox(section,"Revive")
            br.ui:createDropdownWithout(section, "Revive - Target", {"|cff00FF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
        -- Remove Corruption
            br.ui:createCheckbox(section,"Remove Corruption")
            br.ui:createDropdownWithout(section, "Remove Corruption - Target", {"|cff00FF00Player","|cffFFFF00Target","|cffFF0000Mouseover"}, 1, "|cffFFFFFFTarget to cast on")
        -- Healthstone
            br.ui:createSpinner(section, "Pot/Stoned",  60,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Survival Instincts
            br.ui:createSpinner(section, "Survival Instincts",  40,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Healing Touch
            br.ui:createSpinner(section, "Healing Touch", 80, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        -- Regrowth
            br.ui:createSpinner(section, "Regrowth",  50,  0,  100,  5,  "|cffFFFFFFHealth Percent to Cast At")
        -- Rejuvenation
            br.ui:createSpinner(section, "Rejuvenation", 75, 0, 100, 5, "|cffFFFFFFHealth Percent to Cast At")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
        -- Skull Bash
            br.ui:createCheckbox(section,"Skull Bash")
        -- Mighty Bash
            br.ui:createCheckbox(section,"Mighty Bash")
        -- Maim
            br.ui:createCheckbox(section,"Maim")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "Interrupts",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
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
        -- Form Toggle
            br.ui:createDropdown(section, "Form Mode", br.dropOptions.Toggle, 6)
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
        UpdateToggle("Form",0.25)
        br.player.mode.form = br.data.settings[br.selectedSpec].toggles["Form"]

--------------
--- Locals ---
--------------
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
		local castable          							= br.player.cast.debug
        local clearcast                                     = br.player.buff.clearcasting.exists()
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.power.comboPoints.amount()
        local comboDeficit                                  = br.player.power.comboPoints.deficit()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local energy                                        = br.player.power.energy.amount()
        local equiped                                       = br.player.equiped
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local friendsInRange                                = friendsInRange
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
        local rage                                          = br.player.power.rage.amount()
        local solo                                          = #br.friend < 2
        local spell                                         = br.player.spell
        local stealth                                       = br.player.buff.prowl.exists() or br.player.buff.shadowmeld.exists()
        local talent                                        = br.player.talent
        local travel, flight, bear, cat, noform             = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.bearForm.exists(), br.player.buff.catForm.exists(), GetShapeshiftForm()==0
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.energy.ttm()
        local units                                         = units or {}
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

        -- for i = 1, #enemies.yards40 do
        --     local thisUnit = enemies.yards40[i]
        --     if debuff.moonfire.refresh(thisUnit) then
        --         if cast.moonfire(thisUnit) then return end
        --     end
        -- end
--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
		-- Shapeshift Form Management
			if isChecked("Auto Shapeshifts") then --and br.timer:useTimer("debugShapeshift", 0.25) then
                if inCombat or (not inCombat and (isValidUnit("target") or #enemies.yards20 > 0)) then
                    if cast.able.catForm() and mode.form == 1 and level > 20 and isKnown(spell.catForm) and not buff.catForm.exists() then
                        if cast.catForm() then return end
                    end
                    if cast.able.bearForm() and level > 10 and not buff.bearForm.exists() and isKnown(spell.bearForm) and (mode.form == 2 or (mode.form == 1 and not isKnown(spell.catForm))) then
                        if cast.bearForm() then return end
                    end
                    if mode.form == 3 or (mode.form == 2 and not isKnown(spell.bearForm)) then
                        CancelShapeshiftForm();
                    end
                end
			end -- End Shapeshift Form Management
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
			if useDefensive() and not IsMounted() and not stealth and not flight and not buff.prowl.exists() then
                if not inCombat or not (buff.catForm.exists() or buff.bearForm.exists()) then
                    -- Mark of the Wild
                    if cast.able.markOfTheWild() and buff.markOfTheWild.refresh() then
                        if cast.markOfTheWild() then return end
                    end
                    -- Thorns
                    if cast.able.thorns() and buff.thorns.refresh() then
                        if cast.thorns() then return end
                    end
                    -- Rejuvenation
                    if cast.able.rejuvenation() and not buff.rejuvenation.exists() and php <= getOptionValue("Rejuvenation") then
                        if cast.rejuvenation() then return end
                    end
                    -- Regrowth
                    if cast.able.regrowth() and not buff.regrowth.exists() and php <= getOptionValue("Regrowth") then
                        if cast.regrowth() then return end
                    end
                    -- Healing Touch
                    if cast.able.healingTouch() and php <= getOptionValue("Healing Touch") then
                        if cast.healingTouch() then return end
                    end
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
		local function actionList_Cooldowns()
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
    -- Action List - Bear
        local function actionList_Bear()
            if cast.able.bearForm and not buff.bearForm.exists() then
                if cast.bearForm() then return end
            end
            -- Enrage
            if rage < 10 then
                if cast.enrage() then return end
            end
            -- Maul
            if cast.able.maul() then
                if cast.maul() then return end
            end
        end
    -- Action List - Cat
        local function actionList_Cat()
            if cast.able.catForm and not buff.catForm.exists() then
                if cast.catForm() then return end
            end
        end
    -- Action List - Caster
        local function actionList_Caster()
            -- Caster Form
            if buff.bearForm.exists() or buff.catForm.exists() then
                CancelShapeshiftForm()
            end
            -- Moonfire
            if cast.able.moonfire() and not debuff.moonfire.exists() then
                if cast.moonfire() then return end
            end
            -- Wrath
            if cast.able.wrath() then
                if cast.wrath() then return end
            end
        end
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying()~=nil or IsMounted()~=nil) then
                if isValidUnit("target") and opener == true and getDistance("target") < 30 then
                    if cast.able.wrath("target") and (mode.form == 3 or level < 10 or (level > 10 and not isKnown(spell.bearForm))) then
                        if cast.wrath("target") then return end
                    end
                    if getDistance("target") < 5 then
                        StartAttack()
                    end
                end
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
        -- Cat is 4 fyte!
            -- if level >= 20 and inCombat and not cat and #enemies.yards5 > 0 and not moving and isChecked("Auto Shapeshifts") then
            --     if cast.catForm("player") then return end
            -- else
            if inCombat and profileStop==false and not isChecked("Death Cat Mode") and isValidUnit(units.dyn5) and opener == true then
        -- Wild Charge
                -- -- wild_charge
                -- if isChecked("Displacer Beast / Wild Charge") and isValidUnit("target") then
                --     if cast.wildCharge("target") then return end
                -- end
        -- Displacer Beast
                -- displacer_beast,if=movement.distance>10
        -- Dash/Worgen Racial
                -- dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
        -- Rake/Shred from Stealth
                -- rake,if=buff.prowl.up|buff.shadowmeld.up
                -- if (buff.prowl.exists() or buff.shadowmeld.exists()) and getDistance("target") < 40 then
                --     StartAttack()
                -- else
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
                        StartAttack()
                        if mode.form == 3 or level < 10 or (mode.form == 2 and not isKnown(spell.bearForm)) then
                            if actionList_Caster() then return end
                        end
                        if mode.form == 2 or level < 20 or (mode.form == 1 and not isKnown(spell.catForm)) then
                            if actionList_Bear() then return end
                        end
                        if mode.form == 1 then
                            if actionList_Cat() then return end
                        end
                    end -- End SimC APL
			    end -- End No Stealth | Rotation Off Check
			end --End In Combat
		end --End Rotation Logic
    -- end -- End Timer
end -- End runRotation
local id = 'DRUID'
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
