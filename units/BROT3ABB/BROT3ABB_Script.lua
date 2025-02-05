----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Scavenger Medium Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeapons = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local AAASonicPulseBatteryWeapon = AWeapons.AAASonicPulseBatteryWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon

BROT3ABB = Class(CWalkingLandUnit){
    Weapons = {
        mainguns = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle01,
        },
        mgweapon2 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlashScale = 1.4,
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        CWalkingLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        CWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonUnitDeathRing02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROT3ABB', army, v):ScaleEmitter(0.70))
        end
    end,
}

TypeClass = BROT3ABB
