----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Tiger Light Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local WeaponsFile = import('/lua/terranweapons.lua')
local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local aWeapons = import('/lua/aeonweapons.lua')
local AAASonicPulseBatteryWeapon = aWeapons.AAASonicPulseBatteryWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local AAAZealotMissileWeapon = aWeapons.AAAZealotMissileWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon

BROT3EXM1 = Class(TLandUnit){
    Weapons = {
        MainGun = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlashScale = 1.7,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
        },
        Missiles = Class(AAAZealotMissileWeapon){},
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
        EMPgun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        self:CreatTheEffects()
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        TLandUnit.OnDetachedFromTransport(self, transport, bone)
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
        TLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonGraniteDeath'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROT3EXM1', army, v):ScaleEmitter(1.50))
        end
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(1.60))
        end
        for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(1.60))
        end
    end,
}

TypeClass = BROT3EXM1
