----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/XAL0104/XAL0104_script.lua
--  Author(s):  Jessica St. Croix, Gordon Duclos
--
--  Summary  :  Seraphim Mobile Anti-Air Script
--
--  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local SHoverLandUnit = import('/lua/seraphimunits.lua').SHoverLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPT1htt3 = Class(SHoverLandUnit){
    Weapons = {
        TauCannon01 = Class(SDFOhCannon){ FxMuzzleFlashScale = 1.5 },
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        SHoverLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        SHoverLandUnit.OnDetachedFromTransport(self, transport, bone)
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
        SHoverLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFExperimentalPhasonProjHit01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BRPT1BT', army, v):ScaleEmitter(0.7))
        end
    end,
}

TypeClass = BRPT1htt3
